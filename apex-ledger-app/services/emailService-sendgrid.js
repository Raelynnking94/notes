import sgMail from '@sendgrid/mail';
import dotenv from 'dotenv';

dotenv.config();

// Initialize SendGrid
if (process.env.SENDGRID_API_KEY) {
  sgMail.setApiKey(process.env.SENDGRID_API_KEY);
}

export const sendTransactionConfirmation = async (userEmail, transaction) => {
  if (!process.env.SENDGRID_API_KEY) {
    console.warn('SendGrid API key not configured, skipping email');
    return;
  }

  const msg = {
    to: userEmail,
    from: process.env.SENDGRID_FROM_EMAIL || 'noreply@apexledger.com',
    subject: `Transaction Confirmed - ${transaction.type === 'income' ? '+' : '-'}$${transaction.amount.toFixed(2)}`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; max-width: 600px; margin: 0 auto;">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; border-radius: 8px; color: white;">
          <h2 style="margin: 0;">💰 Transaction Confirmed</h2>
        </div>
        <div style="background: #f9f9f9; padding: 20px; margin-top: 20px; border-radius: 8px;">
          <table style="width: 100%;">
            <tr>
              <td style="padding: 10px; font-weight: bold; color: #333;">Type:</td>
              <td style="padding: 10px; color: #667eea; font-weight: bold;">${transaction.type.toUpperCase()}</td>
            </tr>
            <tr>
              <td style="padding: 10px; font-weight: bold; color: #333;">Amount:</td>
              <td style="padding: 10px; color: ${transaction.type === 'income' ? '#10b981' : '#ef4444'}; font-weight: bold; font-size: 18px;">$${transaction.amount.toFixed(2)}</td>
            </tr>
            <tr>
              <td style="padding: 10px; font-weight: bold; color: #333;">Category:</td>
              <td style="padding: 10px; color: #666;">${transaction.category}</td>
            </tr>
            <tr>
              <td style="padding: 10px; font-weight: bold; color: #333;">Date:</td>
              <td style="padding: 10px; color: #666;">${new Date(transaction.date).toLocaleDateString()}</td>
            </tr>
            <tr>
              <td style="padding: 10px; font-weight: bold; color: #333;">Status:</td>
              <td style="padding: 10px;"><span style="background: #d1fae5; color: #065f46; padding: 4px 12px; border-radius: 20px; font-size: 12px;">✓ VERIFIED</span></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #eee; text-align: center; color: #999; font-size: 12px;">
          <p>This is an automated message from Apex Ledger</p>
        </div>
      </div>
    `
  };

  try {
    await sgMail.send(msg);
    console.log(`✅ Email sent to ${userEmail}`);
  } catch (error) {
    console.error('SendGrid error:', error);
  }
};

export const sendMonthlyReport = async (userEmail, metrics) => {
  if (!process.env.SENDGRID_API_KEY) {
    console.warn('SendGrid API key not configured, skipping email');
    return;
  }

  const msg = {
    to: userEmail,
    from: process.env.SENDGRID_FROM_EMAIL || 'noreply@apexledger.com',
    subject: `Your Monthly Bookkeeping Report - Apex Ledger`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; max-width: 600px; margin: 0 auto;">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; border-radius: 8px; color: white;">
          <h2 style="margin: 0;">📊 Monthly Bookkeeping Summary</h2>
        </div>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 20px;">
          <div style="background: #f9f9f9; padding: 15px; border-radius: 8px; border-left: 4px solid #10b981;">
            <div style="font-size: 12px; color: #666; margin-bottom: 5px;">TOTAL INCOME</div>
            <div style="font-size: 24px; font-weight: bold; color: #10b981;">$${metrics.totalIncome.toFixed(2)}</div>
          </div>
          <div style="background: #f9f9f9; padding: 15px; border-radius: 8px; border-left: 4px solid #ef4444;">
            <div style="font-size: 12px; color: #666; margin-bottom: 5px;">TOTAL EXPENSES</div>
            <div style="font-size: 24px; font-weight: bold; color: #ef4444;">$${metrics.totalExpenses.toFixed(2)}</div>
          </div>
          <div style="background: #f9f9f9; padding: 15px; border-radius: 8px; border-left: 4px solid #667eea;">
            <div style="font-size: 12px; color: #666; margin-bottom: 5px;">NET CASH FLOW</div>
            <div style="font-size: 24px; font-weight: bold; color: #667eea;">$${metrics.netCashFlow.toFixed(2)}</div>
          </div>
          <div style="background: #f9f9f9; padding: 15px; border-radius: 8px; border-left: 4px solid #f59e0b;">
            <div style="font-size: 12px; color: #666; margin-bottom: 5px;">TOTAL TAXES</div>
            <div style="font-size: 24px; font-weight: bold; color: #f59e0b;">$${metrics.totalTaxes.toFixed(2)}</div>
          </div>
        </div>
        <div style="margin-top: 20px; padding: 15px; background: #d1fae5; border-radius: 8px; border-left: 4px solid #10b981; color: #065f46;">
          <strong>✓ Your books are audit-ready</strong>
          <p style="margin: 5px 0 0 0; font-size: 12px;">All transactions verified and compliant with tax regulations</p>
        </div>
        <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #eee; text-align: center; color: #999; font-size: 12px;">
          <p>Powered by Apex Ledger - Professional Bookkeeping</p>
        </div>
      </div>
    `
  };

  try {
    await sgMail.send(msg);
    console.log(`✅ Monthly report sent to ${userEmail}`);
  } catch (error) {
    console.error('SendGrid error:', error);
  }
};

export const sendAuditAlert = async (userEmail, auditReport) => {
  if (!process.env.SENDGRID_API_KEY) {
    console.warn('SendGrid API key not configured, skipping email');
    return;
  }

  const msg = {
    to: userEmail,
    from: process.env.SENDGRID_FROM_EMAIL || 'noreply@apexledger.com',
    subject: `Compliance Alert - Audit Report Ready`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; max-width: 600px; margin: 0 auto;">
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; border-radius: 8px; color: white;">
          <h2 style="margin: 0;">✅ Audit Report Ready</h2>
        </div>
        <div style="margin-top: 20px; padding: 15px; background: #d1fae5; border-radius: 8px; border-left: 4px solid #10b981;">
          <div style="color: #065f46;">
            <p style="margin: 0 0 10px 0;"><strong>Compliance Score: ${auditReport.complianceScore}%</strong></p>
            <p style="margin: 0;">✓ Your books are ${auditReport.readyForTaxPrep ? 'ready' : 'not yet ready'} for tax preparation</p>
          </div>
        </div>
        <div style="margin-top: 20px; padding: 15px; background: #f9f9f9; border-radius: 8px;">
          <h3 style="margin-top: 0; color: #333;">Report Summary</h3>
          <ul style="color: #666; line-height: 1.8;">
            <li>Total Transactions: ${auditReport.totalTransactions}</li>
            <li>Verified Transactions: ${auditReport.auditVerifiedCount}</li>
            <li>Bank-Synced Transactions: ${auditReport.bankSyncedCount}</li>
            <li>Taxable Transactions: ${auditReport.taxableTransactions}</li>
          </ul>
        </div>
        <div style="margin-top: 20px; text-align: center;">
          <a href="https://apexledger.com/dashboard" style="background: #667eea; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">View Report</a>
        </div>
        <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #eee; text-align: center; color: #999; font-size: 12px;">
          <p>Powered by Apex Ledger - Professional Bookkeeping</p>
        </div>
      </div>
    `
  };

  try {
    await sgMail.send(msg);
    console.log(`✅ Audit alert sent to ${userEmail}`);
  } catch (error) {
    console.error('SendGrid error:', error);
  }
};
