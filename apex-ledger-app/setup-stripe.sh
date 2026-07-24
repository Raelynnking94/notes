#!/bin/bash

# Apex Ledger - Stripe Payment Processing Setup
# Production payment gateway configuration

echo "💳 Setting up Stripe Payment Processing"
echo "======================================="
echo ""

echo "1️⃣  Create Stripe Account"
echo "   Go to: https://dashboard.stripe.com/register"
echo "   Sign up with your business email"
echo ""

echo "2️⃣  Verify Your Account"
echo "   Complete business verification"
echo "   Add banking information"
echo "   Wait for approval (usually instant)"
echo ""

echo "3️⃣  Get API Keys"
echo "   Go to: Developers → API Keys"
echo "   Copy PUBLISHABLE KEY and SECRET KEY"
echo ""

echo "4️⃣  Add to .env"
cat > .env.stripe << 'EOF'
# Stripe Configuration
STRIPE_SECRET_KEY=sk_live_your_secret_key_here
STRIPE_PUBLISHABLE_KEY=pk_live_your_publishable_key_here
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret_here
EOF

echo "   STRIPE_SECRET_KEY=sk_live_xxx"
echo "   STRIPE_PUBLISHABLE_KEY=pk_live_xxx"
echo "   STRIPE_WEBHOOK_SECRET=whsec_xxx"
echo ""

echo "5️⃣  Create Subscription Products"
echo "   Dashboard → Products → Add Product"
echo ""
echo "   Product 1: Apex Ledger Pro"
echo "   • Price: $29/month"
echo "   • Billing Period: Monthly"
echo "   • Save Price ID: price_xxx"
echo ""
echo "   Product 2: Apex Ledger Enterprise"
echo "   • Price: $99/month"
echo "   • Billing Period: Monthly"
echo "   • Save Price ID: price_xxx"
echo ""

echo "6️⃣  Install Stripe SDK"
echo "   npm install stripe"
echo ""

echo "7️⃣  Set Webhook Endpoint"
echo "   Developers → Webhooks → Add endpoint"
echo "   URL: https://yourdomain.com/api/stripe/webhook"
echo "   Events: customer.subscription.updated, invoice.payment_succeeded"
echo ""

echo "✅ Stripe Features Configured:"
echo "   • Subscription management"
echo "   • Automatic billing"
echo "   • Invoice generation"
echo "   • Dunning management"
echo "   • PCI compliance"
echo "   • Fraud protection"
echo ""

echo "💰 Pricing Model:"
echo "   • Free: $0/month"
echo "   • Pro: $29/month (best for growing businesses)"
echo "   • Enterprise: $99/month (custom features)"
echo ""

echo "🧪 Test Payment:"
echo "   Use test card: 4242 4242 4242 4242"
echo "   Expiry: Any future date"
echo "   CVC: Any 3 digits"
echo ""

echo "📊 Production Checklist:"
echo "   [ ] Switch to Live API keys"
echo "   [ ] Set up webhook verification"
echo "   [ ] Test payment flow end-to-end"
echo "   [ ] Configure receipt emails"
echo "   [ ] Enable 3D Secure for fraud prevention"
echo "   [ ] Set up retry logic for failed payments"
echo ""
