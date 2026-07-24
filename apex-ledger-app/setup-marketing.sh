#!/bin/bash

# Apex Ledger - Marketing Assets Generator
# Create professional materials for your SaaS

echo "🎨 Apex Ledger Marketing Assets"
echo "================================"
echo ""

# Create landing page HTML
cat > landing-page.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apex Ledger - Professional Bookkeeping for Subscribers</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            color: #333;
        }
        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 20px;
            text-align: center;
        }
        header h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        header p {
            font-size: 20px;
            opacity: 0.9;
            margin-bottom: 30px;
        }
        .cta-button {
            background: white;
            color: #667eea;
            padding: 15px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            display: inline-block;
            transition: transform 0.3s;
        }
        .cta-button:hover {
            transform: translateY(-2px);
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin: 60px 0;
        }
        .feature-card {
            padding: 30px;
            background: #f9f9f9;
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }
        .feature-card h3 {
            margin-bottom: 15px;
            color: #667eea;
        }
        .pricing {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin: 60px 0;
        }
        .pricing-card {
            border: 2px solid #eee;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
        }
        .pricing-card.featured {
            border-color: #667eea;
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.15);
        }
        .price {
            font-size: 36px;
            font-weight: 700;
            color: #667eea;
            margin: 20px 0;
        }
        .price small {
            font-size: 16px;
            color: #666;
        }
        footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 30px;
            margin-top: 60px;
        }
    </style>
</head>
<body>
    <header>
        <h1>💼 Apex Ledger</h1>
        <p>Professional Bookkeeping for Modern Subscribers</p>
        <a href="#pricing" class="cta-button">Start Free Trial</a>
    </header>

    <div class="container">
        <h2 style="text-align: center; margin-bottom: 40px;">Why Choose Apex Ledger?</h2>
        
        <div class="features">
            <div class="feature-card">
                <h3>🏦 Bank Sync</h3>
                <p>Real-time transaction syncing from 12,000+ financial institutions</p>
            </div>
            <div class="feature-card">
                <h3>📊 Live Dashboard</h3>
                <p>Real-time cash flow tracking with beautiful visualizations</p>
            </div>
            <div class="feature-card">
                <h3>💰 Tax Ready</h3>
                <p>Automated tax calculations and audit-ready reports</p>
            </div>
            <div class="feature-card">
                <h3>📧 Email Reports</h3>
                <p>Monthly financial summaries delivered automatically</p>
            </div>
            <div class="feature-card">
                <h3>🔒 Enterprise Security</h3>
                <p>Bank-level encryption and PCI compliance</p>
            </div>
            <div class="feature-card">
                <h3>⚡ Auto-Scale</h3>
                <p>Handles unlimited transactions with zero downtime</p>
            </div>
        </div>

        <h2 style="text-align: center; margin: 80px 0 40px;">Simple, Transparent Pricing</h2>
        
        <div class="pricing">
            <div class="pricing-card">
                <h3>Free</h3>
                <div class="price">$0<small>/month</small></div>
                <ul style="text-align: left; margin: 30px 0;">
                    <li>✓ Basic tracking</li>
                    <li>✓ Up to 100 transactions</li>
                    <li>✓ Manual entry</li>
                </ul>
                <a href="/register" class="cta-button">Get Started</a>
            </div>
            <div class="pricing-card featured">
                <h3>⭐ Pro</h3>
                <div class="price">$29<small>/month</small></div>
                <ul style="text-align: left; margin: 30px 0;">
                    <li>✓ Unlimited transactions</li>
                    <li>✓ Bank sync</li>
                    <li>✓ Tax calculations</li>
                    <li>✓ Receipt vault</li>
                    <li>✓ Email support</li>
                </ul>
                <a href="/register" class="cta-button">Start Free Trial</a>
            </div>
            <div class="pricing-card">
                <h3>Enterprise</h3>
                <div class="price">$99<small>/month</small></div>
                <ul style="text-align: left; margin: 30px 0;">
                    <li>✓ All Pro features</li>
                    <li>✓ Payroll management</li>
                    <li>✓ API access</li>
                    <li>✓ Priority support</li>
                    <li>✓ Custom integrations</li>
                </ul>
                <a href="/contact" class="cta-button">Contact Sales</a>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Apex Ledger. All rights reserved.</p>
        <p style="margin-top: 10px; opacity: 0.8;">Made with ❤️ for entrepreneurs</p>
    </footer>
</body>
</html>
EOF

echo "✅ landing-page.html created"
echo ""

# Create email templates
cat > email-templates.md << 'EOF'
# Apex Ledger Email Templates

## Welcome Email

Subject: Welcome to Apex Ledger! 👋

---

Hi [Name],

Welcome to Apex Ledger – your professional bookkeeping partner!

We're excited to have you on board. Here's what you can do:

📊 Track Income & Expenses
🏦 Connect your bank account
💰 Get real-time cash flow insights
📧 Receive monthly financial reports
✅ Export audit-ready reports

Get started: [Link to Dashboard]

Questions? Reply to this email or visit our help center.

Best,
The Apex Ledger Team

---

## Trial Ending Soon

Subject: Your 14-day trial ends in 3 days 🚀

---

Hi [Name],

Your 14-day free trial of Apex Ledger Pro ends in 3 days.

During your trial, you've:
- Tracked [X] transactions
- Synced with [Y] bank accounts
- Generated [Z] reports

Upgrade now to keep using Pro features:

[Upgrade Button]

Need help? Contact support@apexledger.com

Best,
The Apex Ledger Team

---

## Upgrade Successful

Subject: ✅ Your upgrade to Apex Ledger Pro is complete!

---

Hi [Name],

Thank you for upgrading to Apex Ledger Pro! 🎉

You now have access to:
✅ Bank sync
✅ Unlimited transactions
✅ Tax calculations
✅ Email support

Start using Pro features: [Link]

Enjoy!,
The Apex Ledger Team

EOF

echo "✅ email-templates.md created"
echo ""

# Create social media content
cat > social-media.md << 'EOF'
# Apex Ledger Social Media Content

## Twitter Posts

📌 Post 1:
"Stop spending hours on bookkeeping. Apex Ledger syncs your bank, calculates taxes, and generates audit-ready reports—all automatically. Try free today: [link] #bookkeeping #smallbusiness"

📌 Post 2:
"Your finances deserve more than spreadsheets. Real-time cash flow, tax compliance, and email reports. Apex Ledger does it all. [link] #accounting #saas"

📌 Post 3:
"Tax season doesn't have to be stressful. With Apex Ledger's audit-ready reports, you're always prepared. Free trial → [link]"

## LinkedIn Posts

📌 Post 1:
"Bookkeeping is the backbone of every business, yet it remains one of the most time-consuming tasks. What if it didn't have to be?

Apex Ledger automates:
• Bank transactions
• Tax calculations
• Compliance reporting
• Invoice generation

Focus on growing your business. Let us handle the numbers.
[link]"

## Facebook Posts

📌 Post 1:
"Tired of manual bookkeeping? Join thousands of entrepreneurs using Apex Ledger to automate their finances. 

✅ Bank sync
✅ Real-time reports
✅ Tax ready
✅ Professional support

Start your free trial today!"

EOF

echo "✅ social-media.md created"
echo ""

# Create press release
cat > PRESS_RELEASE.md << 'EOF'
# PRESS RELEASE

## Apex Ledger: Professional Bookkeeping Automation for Modern Entrepreneurs

**Automated bank sync, real-time reporting, and tax compliance in one platform**

[CITY, STATE] – [DATE] – Apex Ledger today announced the launch of its professional bookkeeping platform, designed to simplify financial management for entrepreneurs and small business owners.

Built on modern cloud infrastructure, Apex Ledger combines real-time bank synchronization, automated tax calculations, and professional reporting—eliminating the need for manual bookkeeping or expensive accountants.

### Key Features

- **Real-Time Bank Sync**: Automatically pulls transactions from 12,000+ financial institutions
- **Smart Tax Compliance**: Calculates tax liabilities and generates audit-ready reports
- **Professional Email Reports**: Monthly summaries sent automatically
- **Beautiful Dashboards**: Real-time cash flow visualization
- **Secure & Compliant**: Bank-level encryption and PCI compliance

### Pricing

- Free: $0/month (basic tracking)
- Pro: $29/month (unlimited transactions, bank sync)
- Enterprise: $99/month (payroll, API, custom integrations)

"Bookkeeping shouldn't take hours every month," said [Founder Name], CEO of Apex Ledger. "Our mission is to give entrepreneurs back their time so they can focus on what they do best—growing their business."

### Availability

Apex Ledger is available at apexledger.com. New users get 14 days free.

### About Apex Ledger

Apex Ledger is a cloud-based bookkeeping platform serving entrepreneurs and small business owners. Built on modern infrastructure with a focus on simplicity and reliability.

---

For press inquiries, contact: press@apexledger.com

EOF

echo "✅ PRESS_RELEASE.md created"
echo ""

echo "🎨 Marketing Assets Created:"
echo "  ✅ landing-page.html - Beautiful landing page"
echo "  ✅ email-templates.md - Email templates"
echo "  ✅ social-media.md - Social media content"
echo "  ✅ PRESS_RELEASE.md - Press release template"
echo ""
echo "📝 Next steps:"
echo "  1. Customize with your branding"
echo "  2. Deploy landing page to your domain"
echo "  3. Share social media content"
echo "  4. Send press release to relevant media"
echo ""
