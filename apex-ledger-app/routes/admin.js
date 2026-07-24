import express from 'express';
import User from '../models/User.js';
import Transaction from '../models/Transaction.js';
import { verifyToken } from '../middleware/auth.js';
import { sendMonthlyReport, sendAuditAlert } from '../services/emailService.js';

const router = express.Router();

router.use(verifyToken);

// Get admin dashboard (for admins)
router.get('/dashboard', async (req, res) => {
  try {
    const users = await User.find().select('name email subscription.tier subscription.status');
    const totalTransactions = await Transaction.countDocuments();
    const auditVerifiedCount = await Transaction.countDocuments({ auditVerified: true });

    res.json({
      totalUsers: users.length,
      totalTransactions,
      auditVerifiedCount,
      complianceRate: ((auditVerifiedCount / totalTransactions) * 100).toFixed(2),
      subscriptionBreakdown: {
        free: users.filter(u => u.subscription.tier === 'free').length,
        pro: users.filter(u => u.subscription.tier === 'pro').length,
        enterprise: users.filter(u => u.subscription.tier === 'enterprise').length
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Send monthly reports to all users
router.post('/send-monthly-reports', async (req, res) => {
  try {
    const users = await User.find();
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    for (const user of users) {
      const transactions = await Transaction.find({
        userId: user._id,
        date: { $gte: thirtyDaysAgo }
      });

      const totalIncome = transactions
        .filter(t => t.type === 'income')
        .reduce((sum, t) => sum + t.amount, 0);

      const totalExpenses = transactions
        .filter(t => t.type === 'expense')
        .reduce((sum, t) => sum + t.amount, 0);

      const metrics = {
        totalIncome,
        totalExpenses,
        netCashFlow: totalIncome - totalExpenses,
        totalTaxes: transactions
          .filter(t => t.salesTax)
          .reduce((sum, t) => sum + (t.salesTax.amount || 0), 0)
      };

      await sendMonthlyReport(user.email, metrics);
    }

    res.json({ message: 'Monthly reports sent to all users' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Send audit alerts
router.post('/send-audit-alerts', async (req, res) => {
  try {
    const users = await User.find();

    for (const user of users) {
      const transactions = await Transaction.find({ userId: user._id });
      const auditVerifiedCount = transactions.filter(t => t.auditVerified).length;
      const complianceScore = ((auditVerifiedCount / transactions.length) * 100).toFixed(2);

      const auditReport = {
        complianceScore,
        readyForTaxPrep: auditVerifiedCount === transactions.length
      };

      if (complianceScore >= 95) {
        await sendAuditAlert(user.email, auditReport);
      }
    }

    res.json({ message: 'Audit alerts sent' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
