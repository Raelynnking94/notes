import express from 'express';
import Stripe from 'stripe';
import User from '../models/User.js';
import { verifyToken } from '../middleware/auth.js';

const router = express.Router();
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);

router.use(verifyToken);

const prices = {
  pro: 'price_pro_monthly',
  enterprise: 'price_enterprise_monthly'
};

// Create checkout session
router.post('/checkout', async (req, res) => {
  try {
    const { tier } = req.body;
    const user = await User.findById(req.userId);

    const session = await stripe.checkout.sessions.create({
      customer_email: user.email,
      line_items: [
        {
          price: prices[tier],
          quantity: 1
        }
      ],
      mode: 'subscription',
      success_url: `${process.env.CLIENT_URL}/subscriptions?success=true`,
      cancel_url: `${process.env.CLIENT_URL}/subscriptions?canceled=true`,
      metadata: {
        userId: req.userId,
        tier
      }
    });

    res.json({ url: session.url });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Webhook for subscription updates
router.post('/webhook', express.raw({ type: 'application/json' }), async (req, res) => {
  const sig = req.headers['stripe-signature'];
  const event = stripe.webhooks.constructEvent(
    req.body,
    sig,
    process.env.STRIPE_WEBHOOK_SECRET
  );

  if (event.type === 'customer.subscription.updated') {
    const subscription = event.data.object;
    const user = await User.findOne({ 'subscription.stripeCustomerId': subscription.customer });
    if (user) {
      user.subscription.status = subscription.status === 'active' ? 'active' : 'inactive';
      await user.save();
    }
  }

  res.json({ received: true });
});

export default router;
