#!/bin/bash

# Apex Ledger - User Onboarding Flow Setup
# Create smooth user experience from signup to first transaction

echo "🎯 User Onboarding Flow Setup"
echo "============================="
echo ""

cat > ONBOARDING_FLOW.md << 'EOF'
# Apex Ledger User Onboarding Flow

## Goal: Get users to their first transaction in 2 minutes

---

## Step 1: Landing Page (0 seconds)

**User sees:**
- Beautiful hero section
- Key benefits highlighted
- Clear CTA: "Start Free Trial" or "Sign Up"
- Social proof (testimonials, stats)

**Action:** Click signup

---

## Step 2: Registration (30 seconds)

**Form fields:**
```
├─ Full Name
├─ Email
├─ Business Name (optional)
├─ Password
└─ Accept Terms
```

**Incentive:** "14 days free Pro trial – no credit card required"

**Action:** Sign up

---

## Step 3: Welcome Email (Immediate)

**Email received:**
```
Subject: Welcome to Apex Ledger! 👋

✅ Account created
✅ 14-day trial started
✅ Next: Complete your profile

[Complete Profile Button]
```

**Action:** Click button

---

## Step 4: Profile Setup (1 minute)

**In-app onboarding:**

```
┌─────────────────────────────────┐
│  Welcome, [Name]! 👋             │
│                                  │
│  Let's get you set up            │
│  50% complete                    │
├─────────────────────────────────┤
│                                  │
│  📋 Profile Information          │
│     - Business name              │
│     - Tax ID (optional)          │
│     - Business type              │
│     - Annual revenue (optional)  │
│                                  │
│  [Next] →                        │
└─────────────────────────────────┘
```

**Action:** Click "Next"

---

## Step 5: Bank Connection (2 minutes)

**Offer to sync bank:**
```
┌─────────────────────────────────┐
│  🏦 Connect Your Bank            │
│                                  │
│  Auto-sync transactions and      │
│  save hours every month!         │
│                                  │
│  [Connect with Plaid]            │
│  [Skip for now]                  │
└─────────────────────────────────┘
```

**If user clicks "Connect with Plaid":**
- Opens Plaid modal
- User selects bank
- User logs in
- Transactions synced automatically

**If user skips:**
- Continue to manual entry

**Action:** Either connect or skip

---

## Step 6: First Transaction (2 minutes)

**Guided transaction entry:**
```
┌─────────────────────────────────┐
│  ✨ Your First Transaction      │
│                                  │
│  Type: [ Expense ▼ ]             │
│  Amount: $ [____________]        │
│  Category: [ Other ▼ ]           │
│  Description: [________________] │
│  Date: [ Today ]                 │
│                                  │
│  [Record Transaction] →          │
└─────────────────────────────────┘
```

**Action:** Record first transaction

---

## Step 7: Success! (2:15 total)

**Confirmation screen:**
```
┌─────────────────────────────────┐
│  ✅ Transaction Recorded!        │
│                                  │
│  Expense: -$XX.XX               │
│  Category: [Category]            │
│  Status: Verified ✓             │
│                                  │
│  🎉 You're all set!              │
│                                  │
│  Next steps:                     │
│  • Record more transactions      │
│  • Connect your bank             │
│  • View your dashboard           │
│                                  │
│  [Go to Dashboard] →             │
└─────────────────────────────────┘
```

**Action:** Go to dashboard

---

## Step 8: Dashboard Overview (2:30 total)

**User sees:**
```
┌─────────────────────────────────┐
│  📊 Your Dashboard               │
│                                  │
│  ┌─────────────────────────────┐ │
│  │ Cash Flow Summary            │ │
│  │ Income:     $0.00            │ │
│  │ Expenses:   -$XX.XX          │ │
│  │ Net Flow:   -$XX.XX          │ │
│  └─────────────────────────────┘ │
│                                  │
│  Your first transaction:          │
│  [Transaction details]            │
│                                  │
│  💡 Pro Tips:                    │
│  • Connect your bank              │
│  • Set up recurring expenses      │
│  • Enable email reports           │
└─────────────────────────────────┘
```

---

## Post-Onboarding Support

### Day 1: Welcome
**Email:**
```
Subject: Your first transaction is recorded! 🎉

Great start! You've recorded 1 transaction.

Next: Connect your bank to auto-sync all future transactions.
[Connect Bank Button]
```

### Day 3: Reminder
**Email:**
```
Subject: You're off to a great start! 📈

You've recorded X transactions in 3 days.

Tip: Enable automatic email reports to get monthly summaries.
[Enable Reports Button]
```

### Day 7: Trial Halfway
**Email:**
```
Subject: Halfway through your trial! ⏰

You have 7 days left in your 14-day free trial.

Features you're loving:
✓ Real-time dashboard
✓ Transaction tracking
✓ Audit-ready reports

Ready to continue? Upgrade now:
[Upgrade Button]
```

### Day 13: Trial Ending
**Email:**
```
Subject: Your trial ends in 1 day! 🚀

Don't lose access to Apex Ledger Pro.

Your trial expires tomorrow. Upgrade now:
[Upgrade Button]
```

### Day 15: Trial Ended (Free Tier)
**Email:**
```
Subject: Your trial has ended – but you can still use Apex Ledger!

Your Pro trial ended. You're now on our Free tier.

Free tier includes:
✓ Basic transaction tracking
✓ Up to 100 transactions/month
✓ Manual entry

Miss Pro features? Upgrade anytime:
[Upgrade Button]
```

---

## Onboarding Metrics to Track

```
📊 Key Metrics:

1. Signup to First Transaction: [Time]
   Target: < 5 minutes
   
2. Bank Connection Rate: [%]
   Target: > 60%
   
3. Day 7 Active Users: [%]
   Target: > 70%
   
4. Trial to Paid Conversion: [%]
   Target: > 30%
   
5. Churn Rate: [%]
   Target: < 5%/month
```

---

## Optimization Checklist

- [ ] Track onboarding completion rate
- [ ] Identify where users drop off
- [ ] A/B test CTA button text
- [ ] A/B test email subject lines
- [ ] Optimize form fields (remove unnecessary)
- [ ] Add tooltips for confusing sections
- [ ] Test on mobile thoroughly
- [ ] Get user feedback on flow
- [ ] Iterate based on data

EOF

echo "✅ ONBOARDING_FLOW.md created"
echo ""
echo "🎯 Onboarding Flow Features:"
echo "  ✅ 2-minute setup"
echo "  ✅ Bank sync integration"
echo "  ✅ First transaction guide"
echo "  ✅ Post-signup emails"
echo "  ✅ Success metrics"
echo ""
echo "📊 Implementation:"
echo "  1. Add to-onboarding tour component (React)"
echo "  2. Set up automated email sequences"
echo "  3. Track metrics in analytics"
echo "  4. Optimize based on drop-off points"
echo ""
