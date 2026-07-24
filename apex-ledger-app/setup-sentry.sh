#!/bin/bash

# Apex Ledger - Sentry Error Tracking Setup
# Real-time error monitoring and alerting

echo "🚨 Setting up Sentry Error Tracking"
echo "===================================="
echo ""

echo "1️⃣  Create Sentry Account"
echo "   Go to: https://sentry.io/signup/"
echo "   Sign up for free (5000 errors/month included)"
echo ""

echo "2️⃣  Create Organization & Project"
echo "   Org name: Apex Ledger"
echo "   Project name: apex-ledger-api"
echo "   Platform: Node.js"
echo ""

echo "3️⃣  Get Your DSN (Data Source Name)"
echo "   Navigate to: Settings → Projects → DSN"
echo "   Copy the DSN (looks like: https://xxx@xxx.ingest.sentry.io/xxx)"
echo ""

echo "4️⃣  Install Sentry SDK"
echo "   npm install @sentry/node @sentry/tracing"
echo ""

echo "5️⃣  Add to .env"
echo "   SENTRY_DSN=https://xxx@xxx.ingest.sentry.io/xxx"
echo "   SENTRY_ENVIRONMENT=production"
echo ""

echo "6️⃣  Integration already added to server.js"
echo "   Check server.js for Sentry.init() call"
echo ""

echo "✅ Sentry Features:"
echo "   • Real-time error notifications"
echo "   • Stack trace analysis"
echo "   • User context tracking"
echo "   • Performance monitoring"
echo "   • Release tracking"
echo "   • Slack/Email alerts"
echo ""

echo "📊 Configure Alerts:"
echo "   1. Go to Sentry Dashboard"
echo "   2. Alerts → Create Alert Rule"
echo "   3. Condition: Error rate > 5%"
echo "   4. Action: Send to Slack/Email"
echo ""
