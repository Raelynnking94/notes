import { useState, useEffect } from 'react';
import axios from 'axios';
import './Subscriptions.css';

function Subscriptions() {
  const [subscription, setSubscription] = useState(null);
  const [selectedTier, setSelectedTier] = useState(null);
  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchSubscription();
  }, []);

  const fetchSubscription = async () => {
    try {
      const res = await axios.get('/api/subscriptions', {
        headers: { Authorization: `Bearer ${token}` }
      });
      setSubscription(res.data);
    } catch (error) {
      console.error('Failed to fetch subscription:', error);
    }
  };

  const handleUpgrade = async (tier) => {
    try {
      await axios.post('/api/subscriptions/upgrade', { tier }, {
        headers: { Authorization: `Bearer ${token}` }
      });
      alert(`Successfully upgraded to ${tier} tier!`);
      fetchSubscription();
    } catch (error) {
      console.error('Failed to upgrade:', error);
    }
  };

  const handleStripeCheckout = (tier) => {
    alert(`Stripe checkout would open for ${tier} tier subscription`);
    // In production, integrate with @stripe/react-stripe-js here
  };

  if (!subscription) return <div className="container"><p>Loading subscription info...</p></div>;

  return (
    <div className="container subscriptions">
      <h1>Subscription Plans</h1>
      <p className="subtitle">Choose the perfect plan for your bookkeeping needs</p>

      <div className="tiers-grid">
        {Object.entries(subscription.tiers).map(([tierName, tierData]) => (
          <div key={tierName} className={`tier-card ${tierName === subscription.subscription.tier ? 'active' : ''}`}>
            <h2>{tierName.charAt(0).toUpperCase() + tierName.slice(1)}</h2>
            <div className="price">
              ${tierData.price}
              {tierData.price > 0 && <span className="period">/month</span>}
            </div>
            <ul className="features">
              {tierData.features.map((feature, idx) => (
                <li key={idx}>✓ {feature}</li>
              ))}
            </ul>
            <div className="tier-actions">
              {tierName === subscription.subscription.tier ? (
                <button className="btn btn-secondary" disabled>Current Plan</button>
              ) : (
                <>
                  <button 
                    className="btn btn-primary"
                    onClick={() => handleUpgrade(tierName)}
                  >
                    Upgrade to {tierName}
                  </button>
                  <button 
                    className="btn btn-secondary"
                    onClick={() => handleStripeCheckout(tierName)}
                  >
                    Pay with Stripe
                  </button>
                </>
              )}
            </div>
          </div>
        ))}
      </div>

      <div className="card trial-card">
        <h2>14-Day Free Trial</h2>
        <p>Start with our Pro plan free for 14 days. No credit card required. Perfect for testing all features.</p>
        <button className="btn btn-primary">Start Free Trial</button>
      </div>
    </div>
  );
}

export default Subscriptions;
