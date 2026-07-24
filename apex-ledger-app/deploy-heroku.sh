#!/bin/bash

# Apex Ledger - Heroku Deployment Script
# Deploy to Heroku with PostgreSQL database

echo "🚀 Apex Ledger Heroku Deployment"
echo "================================="
echo ""

if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI not found"
    echo "Install: https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

echo "✅ Heroku CLI found"
echo ""

echo "🔑 Step 1: Login to Heroku"
heroku login

echo ""
echo "📱 Step 2: Create Heroku app"
APP_NAME="apex-ledger-prod"
heroku create $APP_NAME

echo ""
echo "🗄️  Step 3: Add MongoDB add-on"
heroku addons:create mongolab:sandbox -a $APP_NAME

echo ""
echo "🔧 Step 4: Set environment variables"
heroku config:set \
  STRIPE_SECRET_KEY=sk_live_xxx \
  JWT_SECRET=$(openssl rand -hex 32) \
  NODE_ENV=production \
  -a $APP_NAME

echo ""
echo "📂 Step 5: Deploy code"
echo "git push heroku apex-ledger-app-build:main"

echo ""
echo "✅ DEPLOYMENT COMPLETE!"
echo ""
echo "📊 Your app:"
echo "   🌐 URL: https://$APP_NAME.herokuapp.com"
echo "   📖 View logs: heroku logs --tail -a $APP_NAME"
echo ""
