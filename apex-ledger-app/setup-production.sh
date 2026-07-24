#!/bin/bash

# Apex Ledger - Complete Production Setup
# Integrates Sentry, SendGrid, and Stripe

echo "🚀 Apex Ledger Production Setup"
echo "==============================="
echo ""
echo "This script will configure:"
echo "  ✅ Sentry (Error tracking)"
echo "  ✅ SendGrid (Email delivery)"
echo "  ✅ Stripe (Payment processing)"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo "📋 Step 1: Setting up Sentry"
echo "============================="
echo ""
echo "Create free account at: https://sentry.io/signup/"
echo ""
read -p "Enter your Sentry DSN: " SENTRY_DSN

echo ""
echo "📧 Step 2: Setting up SendGrid"
echo "==============================="
echo ""
echo "Create free account at: https://signup.sendgrid.com/"
echo ""
read -p "Enter your SendGrid API Key: " SENDGRID_API_KEY
read -p "Enter your SendGrid From Email: " SENDGRID_FROM_EMAIL

echo ""
echo "💳 Step 3: Setting up Stripe"
echo "============================"
echo ""
echo "Get API keys from: https://dashboard.stripe.com/apikeys"
echo ""
read -p "Enter your Stripe Secret Key: " STRIPE_SECRET_KEY
read -p "Enter your Stripe Publishable Key: " STRIPE_PUBLISHABLE_KEY
read -p "Enter your Stripe Webhook Secret: " STRIPE_WEBHOOK_SECRET

echo ""
echo "💾 Writing to .env"
echo ""

cat >> .env << EOF

# ===== SENTRY ERROR TRACKING =====
SENTRY_DSN=$SENTRY_DSN
SENTRY_ENVIRONMENT=production

# ===== SENDGRID EMAIL DELIVERY =====
SENDGRID_API_KEY=$SENDGRID_API_KEY
SENDGRID_FROM_EMAIL=$SENDGRID_FROM_EMAIL
SENDGRID_FROM_NAME=Apex Ledger

# ===== STRIPE PAYMENTS =====
STRIPE_SECRET_KEY=$STRIPE_SECRET_KEY
STRIPE_PUBLISHABLE_KEY=$STRIPE_PUBLISHABLE_KEY
STRIPE_WEBHOOK_SECRET=$STRIPE_WEBHOOK_SECRET
EOF

echo "✅ Environment variables saved"
echo ""
echo "📦 Installing dependencies"
echo ""
npm install @sentry/node @sentry/tracing @sendgrid/mail stripe

echo ""
echo "✅ SETUP COMPLETE!"
echo ""
echo "🎉 Your production integrations are ready:"
echo ""
echo "  ✅ Sentry - Real-time error tracking"
echo "  ✅ SendGrid - Professional email delivery"
echo "  ✅ Stripe - Secure payment processing"
echo ""
echo "🚀 To deploy:"
echo ""
echo "  1. Review .env file"
echo "  2. Commit changes: git add . && git commit -m 'Add production integrations'"
echo "  3. Push: git push origin apex-ledger-app-build"
echo "  4. Deploy: doctl apps create --spec app.yaml"
echo ""
echo "📊 Testing Payments:"
echo "  Use card: 4242 4242 4242 4242"
echo "  Date: Any future date"
echo "  CVC: Any 3 digits"
echo ""
echo "✨ Done! Your Apex Ledger is production-ready!"
echo ""
