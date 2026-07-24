#!/bin/bash

# Production deployment checklist

echo "🚀 Apex Ledger Pre-Deployment Checklist"
echo "======================================"
echo ""

checklist=(
  "Have you changed JWT_SECRET in .env?"
  "Have you set STRIPE_SECRET_KEY and STRIPE_WEBHOOK_SECRET?"
  "Have you configured SMTP email settings?"
  "Have you set NODE_ENV=production?"
  "Have you set up MongoDB backups?"
  "Have you tested the app locally with 'npm test'?"
  "Have you updated the frontend API URL to production domain?"
  "Have you set up an SSL certificate?"
  "Have you configured database encryption?"
  "Have you set rate limiting for API endpoints?"
  "Have you enabled CORS for your production domain only?"
  "Have you set up error tracking (Sentry)?"
  "Have you configured automated backups?"
  "Have you set up monitoring and alerting?"
  "Have you tested payment processing with Stripe?"
)

echo "Before deploying to production, verify:"
echo ""

for i in "${!checklist[@]}"; do
  echo "[ ] $((i+1)). ${checklist[$i]}"
done

echo ""
echo "Once all items are checked, you're ready for:"
echo ""
echo "  AWS:          ./deploy-aws.sh"
echo "  DigitalOcean: ./deploy-digitalocean.sh"
echo "  Heroku:       ./deploy-heroku.sh"
echo ""
