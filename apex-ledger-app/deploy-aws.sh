#!/bin/bash

# Apex Ledger - AWS EC2 Deployment Script
# Deploys the full production stack to AWS

set -e

echo "🚀 Apex Ledger AWS Deployment"
echo "============================="
echo ""

# Configuration
AWS_REGION=${AWS_REGION:-us-east-1}
INSTANCE_NAME="apex-ledger-prod"
SECURITY_GROUP="apex-ledger-sg"

echo "📦 Step 1: Checking AWS CLI"
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Install it first: https://aws.amazon.com/cli/"
    exit 1
fi

echo "✅ AWS CLI found"
echo ""

echo "🔑 Step 2: Configuring AWS credentials"
echo "Run: aws configure"
echo "Then paste AWS Access Key ID and Secret Access Key"
echo ""

echo "🖥️  Step 3: Launching EC2 instance"
echo "Using: Ubuntu 22.04 LTS, t3.medium (2 vCPU, 4GB RAM)"
echo ""

# Launch instance (if not already running)
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=$INSTANCE_NAME" "Name=instance-state-name,Values=running" \
  --query 'Reservations[0].Instances[0].InstanceId' \
  --output text \
  --region $AWS_REGION)

if [ "$INSTANCE_ID" = "None" ] || [ -z "$INSTANCE_ID" ]; then
    echo "Creating new EC2 instance..."
    INSTANCE_ID=$(aws ec2 run-instances \
      --image-id ami-0c55b159cbfafe1f0 \
      --instance-type t3.medium \
      --key-name apex-ledger-key \
      --security-groups $SECURITY_GROUP \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
      --query 'Instances[0].InstanceId' \
      --output text \
      --region $AWS_REGION)
    echo "✅ Instance created: $INSTANCE_ID"
else
    echo "✅ Instance already running: $INSTANCE_ID"
fi

echo ""
echo "⏳ Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $AWS_REGION

echo ""
echo "📍 Getting instance details..."
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text \
  --region $AWS_REGION)

echo "✅ Instance IP: $PUBLIC_IP"
echo ""

echo "⏳ Waiting for SSH to be ready (30 seconds)..."
sleep 30

echo "🔐 Step 4: Installing Docker on instance"
ssh -i apex-ledger-key.pem -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP << 'REMOTE_SCRIPT'
    echo "Installing Docker and Docker Compose..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose git
    sudo usermod -aG docker ubuntu
    echo "✅ Docker installed"
REMOTE_SCRIPT

echo ""
echo "📂 Step 5: Cloning repository"
ssh -i apex-ledger-key.pem -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP << 'REMOTE_SCRIPT'
    cd ~
    git clone https://github.com/Raelynnking94/notes.git
    cd notes/apex-ledger-app
    echo "✅ Repository cloned"
REMOTE_SCRIPT

echo ""
echo "🔧 Step 6: Configuring environment"
echo "Creating .env file on instance..."
ssh -i apex-ledger-key.pem -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP << 'REMOTE_SCRIPT'
    cd ~/notes/apex-ledger-app
    cat > .env << 'EOF'
PORT=5000
MONGODB_URI=mongodb://admin:password123@mongodb:27017/apex-ledger?authSource=admin
JWT_SECRET=apex-ledger-secret-key-change-this
STRIPE_SECRET_KEY=sk_live_your_stripe_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
CLIENT_URL=http://localhost:3000
NODE_ENV=production
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=noreply@apexledger.com
EOF
    echo "✅ .env created - REMEMBER TO UPDATE WITH YOUR KEYS!"
REMOTE_SCRIPT

echo ""
echo "🚀 Step 7: Starting Docker containers"
ssh -i apex-ledger-key.pem -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP << 'REMOTE_SCRIPT'
    cd ~/notes/apex-ledger-app
    sudo docker-compose up -d
    echo "⏳ Waiting for services to start..."
    sleep 15
    sudo docker-compose ps
REMOTE_SCRIPT

echo ""
echo "✅ DEPLOYMENT COMPLETE!"
echo ""
echo "📊 Your Apex Ledger is running:"
echo "   🎨 Dashboard: http://$PUBLIC_IP:3000"
echo "   🔌 API: http://$PUBLIC_IP:5000"
echo "   📖 API Docs: http://$PUBLIC_IP:5000/api-docs"
echo ""
echo "⚠️  IMPORTANT NEXT STEPS:"
echo "   1. SSH into instance: ssh -i apex-ledger-key.pem ubuntu@$PUBLIC_IP"
echo "   2. Update .env with real Stripe & email credentials"
echo "   3. Restart containers: docker-compose restart"
echo "   4. Set up domain & SSL certificate"
echo "   5. Configure database backups"
echo ""
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $PUBLIC_IP"
echo "Region: $AWS_REGION"
