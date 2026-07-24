import Stripe from 'stripe';
import User from '../models/User.js';
import { verifyToken } from '../middleware/auth.js';
import Transaction from '../models/Transaction.js';

const router = require('express').Router();
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);

router.use(verifyToken);

// Create subscription checkout session
router.post('/create-checkout-session', async (req, res) => {
  try {
    const { tier } = req.body;
    const user = await User.findById(req.userId);

    const priceMap = {
      pro: process.env.STRIPE_PRICE_PRO || 'price_1234567890',
      enterprise: process.env.STRIPE_PRICE_ENTERPRISE || 'price_0987654321'
    };

    const session = await stripe.checkout.sessions.create({
      customer_email: user.email,
      line_items: [
        {
          price: priceMap[tier],
          quantity: 1
        }
      ],
      mode: 'subscription',
      success_url: `${process.env.CLIENT_URL}/dashboard?payment=success`,
      cancel_url: `${process.env.CLIENT_URL}/subscriptions?payment=canceled`,
      metadata: {
        userId: req.userId,
        tier
      }
    });

    res.json({ url: session.url });
  } catch (error) {
    console.error('Stripe error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Handle webhook events
router.post(
  '/webhook',
  express.raw({ type: 'application/json' }),
  async (req, res) => {
    const sig = req.headers['stripe-signature'];

    let event;

    try {
      event = stripe.webhooks.constructEvent(
        req.body,
        sig,
        process.env.STRIPE_WEBHOOK_SECRET
      );
    } catch (err) {
      console.error('Webhook error:', err.message);
      return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    switch (event.type) {
      case 'customer.subscription.created':
      case 'customer.subscription.updated': {
        const subscription = event.data.object;
        const user = await User.findOne({
          'subscription.stripeCustomerId': subscription.customer
        });

        if (user) {
          user.subscription.status = subscription.status === 'active' ? 'active' : 'inactive';
          user.subscription.stripeCustomerId = subscription.customer;
          user.subscription.renewalDate = new Date(subscription.current_period_end * 1000);
          await user.save();
          console.log(`Subscription updated for user ${user.email}`);
        }
        break;
      }

      case 'customer.subscription.deleted': {
        const subscription = event.data.object;
        const user = await User.findOne({
          'subscription.stripeCustomerId': subscription.customer
        });

        if (user) {
          user.subscription.status = 'canceled';
          await user.save();
          console.log(`Subscription canceled for user ${user.email}`);
        }
        break;
      }

      case 'invoice.payment_succeeded': {
        const invoice = event.data.object;
        console.log(`Payment succeeded for invoice ${invoice.id}`);
        break;
      }

      case 'invoice.payment_failed': {
        const invoice = event.data.object;
        console.error(`Payment failed for invoice ${invoice.id}`);
        // Could send email notification here
        break;
      }
    }

    res.json({ received: true });
  }
);

// Get billing portal
router.post('/billing-portal', async (req, res) => {
  try {
    const user = await User.findById(req.userId);

    if (!user.subscription.stripeCustomerId) {
      return res.status(400).json({ error: 'No Stripe customer found' });
    }

    const session = await stripe.billingPortal.sessions.create({
      customer: user.subscription.stripeCustomerId,
      return_url: `${process.env.CLIENT_URL}/subscriptions`
    });

    res.json({ url: session.url });
  } catch (error) {
    console.error('Billing portal error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get subscription details
router.get('/subscription', async (req, res) => {
  try {
    const user = await User.findById(req.userId);
    res.json({
      tier: user.subscription.tier,
      status: user.subscription.status,
      renewalDate: user.subscription.renewalDate,
      stripeCustomerId: user.subscription.stripeCustomerId
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
