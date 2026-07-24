#!/bin/bash

# Apex Ledger - Analytics Dashboard Setup
# Track business metrics and user behavior

echo "📊 Analytics Dashboard Setup"
echo "============================"
echo ""

cat > ANALYTICS.md << 'EOF'
# Apex Ledger Analytics Dashboard

## Key Business Metrics

### Revenue Metrics
```
💰 Monthly Recurring Revenue (MRR)
   Formula: (Pro Subscribers × $29) + (Enterprise × $99)
   Target Growth: 20% month-over-month

💰 Annual Recurring Revenue (ARR)
   Formula: MRR × 12
   Target: $100K+ ARR

💰 Average Revenue Per User (ARPU)
   Formula: Total Revenue / Total Subscribers
   Target: > $35

💰 Customer Lifetime Value (LTV)
   Formula: ARPU × Average Customer Lifespan
   Target: > $500
```

### User Growth Metrics
```
📈 Monthly Active Users (MAU)
   Users who logged in last 30 days
   Target: 10,000+ MAU

📈 New User Signups
   New accounts per month
   Target: 1,000+ new users/month

📈 Trial to Paid Conversion
   Percentage of trial users who upgrade
   Target: > 30%

📈 Free to Paid Conversion
   Percentage of free users who upgrade
   Target: > 15%
```

### Engagement Metrics
```
🔄 Daily Active Users (DAU)
   Users who logged in today
   DAU/MAU Ratio Target: > 20%

🔄 Transactions Per User (Monthly)
   Average transactions recorded
   Target: > 30/month

🔄 Feature Adoption Rate
   % of users using bank sync
   Target: > 60%

🔄 Email Report Opens
   % of users opening monthly reports
   Target: > 50%
```

### Retention & Churn
```
📉 Monthly Churn Rate
   (Churned Customers / Starting Customers) × 100
   Target: < 5%

📉 Annual Churn Rate
   Formula: 1 - (Ending MRR / Starting MRR)
   Target: < 40%

📉 Net Revenue Retention
   (MRR with upgrades - MRR from churn) / Starting MRR
   Target: > 95%
```

---

## Analytics Tools Setup

### Google Analytics 4 (Free)

**Installation:**
```bash
npm install react-ga4
```

**Add to App.jsx:**
```javascript
import ReactGA from "react-ga4";

ReactGA.initialize("G-YOUR_TRACKING_ID");

// Track page views
ReactGA.send({ hitType: "pageview", page: location.pathname });

// Track events
ReactGA.event("sign_up", { method: "email" });
ReactGA.event("transaction_recorded", { amount: 100 });
```

**Track:**
- Signups
- Transactions recorded
- Bank connections
- Feature usage
- Upgrade events
- Churn events

---

### Mixpanel (Product Analytics)

**Installation:**
```bash
npm install mixpanel-browser
```

**Implementation:**
```javascript
import mixpanel from 'mixpanel-browser';

mixpanel.init('YOUR_TOKEN');

// Track user
mixpanel.identify(userId);
mixpanel.people.set({
  email: user.email,
  plan: user.subscription.tier,
  signup_date: user.createdAt
});

// Track events
mixpanel.track('Transaction Created', {
  amount: 100,
  category: 'Supplies',
  type: 'expense'
});
```

---

### Amplitude (User Analytics)

**Key Events to Track:**
```
1. signup
2. login
3. first_transaction
4. bank_connected
5. email_report_opened
6. upgrade_initiated
7. upgrade_completed
8. transaction_count_milestone
```

---

## Dashboard (Metabase/Tableau)

**Create these dashboards:**

### Executive Dashboard
```
┌─────────────────────────────────────┐
│  KPI Cards (Red/Yellow/Green)       │
├─────────────────────────────────────┤
│                                     │
│  MRR: $X,XXX ↑ 20%                 │
│  Active Users: X,XXX ↑ 15%         │
│  Churn Rate: X% ↓ 1.2%             │
│  Conversion: X% (trial to paid)    │
│                                     │
│  Revenue by Plan (pie chart)        │
│  User Growth (line chart)           │
│  Churn Cohorts (cohort analysis)   │
│                                     │
└─────────────────────────────────────┘
```

### Product Dashboard
```
┌─────────────────────────────────────┐
│  Feature Usage (bar chart)          │
│  - Bank sync: 65%                   │
│  - Email reports: 45%               │
│  - Receipt upload: 30%              │
│                                     │
│  Transactions Per User (histogram)  │
│  Engagement Funnel                  │
│  Session Duration (over time)       │
│                                     │
│  Error Rate (time series)           │
│  API Response Time (percentiles)    │
│                                     │
└─────────────────────────────────────┘
```

### Sales Dashboard
```
┌─────────────────────────────────────┐
│  Trial Signups (daily)              │
│  Conversion Rate (by cohort)        │
│  Customer Acquisition Cost (CAC)    │
│  Lifetime Value (LTV)               │
│  LTV:CAC Ratio (target > 3)        │
│                                     │
│  Upgrade Sources (organic/ads)      │
│  Top Referral Sources               │
│                                     │
└─────────────────────────────────────┘
```

---

## Weekly Reporting

**Every Monday, analyze:**

```
📊 WEEKLY REPORT TEMPLATE

Week of: [Date]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 REVENUE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• MRR: $X (↑/↓ from last week)
• New Paid Customers: X (↑/↓ X%)
• Churned Customers: X
• Net MRR Change: $X

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 USERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• New Signups: X (↑/↓ X%)
• Active Users: X (↑/↓ X%)
• Trial Conversions: X% (target: 30%)
• Free Upgrades: X

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ENGAGEMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Avg Transactions/User: X
• Bank Sync Adoption: X%
• Report Opens: X%
• DAU/MAU: X%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 PRODUCT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• System Uptime: X%
• Error Rate: X%
• API Response Time (p95): Xms
• Support Tickets: X

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 PRIORITIES NEXT WEEK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Priority 1]
2. [Priority 2]
3. [Priority 3]
```

---

## Goal: First 1000 Paid Users

### Timeline
```
Month 1-2: Beta Launch (100 users)
  - Focus: Product refinement
  - Metric: 30% trial conversion
  
Month 3-4: Early Growth (500 users)
  - Focus: Word of mouth
  - Metric: < 5% churn
  
Month 5-6: Scale (1000+ users)
  - Focus: Paid acquisition
  - Metric: > 20% MoM growth
```

### Success Metrics at 1000 Users

```
✅ MRR: $20,000+
✅ Churn: < 5%
✅ Trial Conversion: > 25%
✅ DAU/MAU: > 25%
✅ NPS: > 50
✅ Uptime: > 99.9%
```

EOF

echo "✅ ANALYTICS.md created"
echo ""
echo "📊 Analytics Stack Setup:"
echo "  ✅ Google Analytics 4 (free)"
echo "  ✅ Mixpanel (product analytics)"
echo "  ✅ Sentry (error tracking)"
echo "  ✅ DigitalOcean Metrics (infrastructure)"
echo ""
echo "📈 Dashboards to create:"
echo "  1. Executive dashboard (MRR, users, churn)"
echo "  2. Product dashboard (features, engagement)"
echo "  3. Sales dashboard (conversions, CAC)"
echo "  4. Support dashboard (tickets, response time)"
echo ""
echo "📊 Track these weekly:"
echo "  • MRR & growth rate"
echo "  • New signups & conversions"
echo "  • Churn & retention"
echo "  • Feature adoption"
echo "  • System health"
echo ""
