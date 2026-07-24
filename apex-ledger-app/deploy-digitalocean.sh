#!/bin/bash

# Apex Ledger - DigitalOcean Deployment Script
# Deploy to DigitalOcean App Platform

echo "🚀 Apex Ledger DigitalOcean Deployment"
echo "======================================"
echo ""

# Check for doctl CLI
if ! command -v doctl &> /dev/null; then
    echo "❌ doctl CLI not found"
    echo "Install: https://docs.digitalocean.com/reference/doctl/how-to/install/"
    exit 1
fi

echo "✅ doctl CLI found"
echo ""

echo "🔑 Step 1: Authenticate with DigitalOcean"
echo "doctl auth init"
echo ""

echo "📂 Step 2: Creating app.yaml for DigitalOcean"
cat > app.yaml << 'EOF'
name: apex-ledger
services:
- name: api
  github:
    repo: Raelynnking94/notes
    branch: apex-ledger-app-build
  build_command: npm ci
  run_command: npm start
  http_port: 5000
  source_dir: apex-ledger-app
  envs:
  - key: MONGODB_URI
    value: ${db.connection_string}
  - key: JWT_SECRET
    scope: RUN_AND_BUILD_TIME
    value: ${JWT_SECRET}
  - key: STRIPE_SECRET_KEY
    scope: RUN_AND_BUILD_TIME
    value: ${STRIPE_SECRET_KEY}
  - key: NODE_ENV
    value: production

- name: web
  github:
    repo: Raelynnking94/notes
    branch: apex-ledger-app-build
  build_command: cd client && npm ci && npm run build
  source_dir: apex-ledger-app
  http_port: 3000
  envs:
  - key: VITE_API_URL
    value: https://${api.name}.ondigitalocean.app

databases:
- name: db
  engine: MONGODB
  production: true
EOF

echo "✅ app.yaml created"
echo ""

echo "🚀 Step 3: Deploying to DigitalOcean"
echo "Run: doctl apps create --spec app.yaml"
echo ""
echo "This will:"
echo "  • Provision MongoDB database"
echo "  • Deploy Node.js backend"
echo "  • Deploy React frontend"
echo "  • Assign free SSL certificate"
echo ""

echo "📊 View deployment:"
echo "Run: doctl apps list"
echo ""

echo "💾 To push updates:"
echo "Just push to apex-ledger-app-build branch"
echo "DigitalOcean will automatically rebuild and deploy"
