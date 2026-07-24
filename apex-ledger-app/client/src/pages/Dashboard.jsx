import { useState, useEffect } from 'react';
import axios from 'axios';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import './Dashboard.css';

function Dashboard() {
  const [metrics, setMetrics] = useState(null);
  const [auditReport, setAuditReport] = useState(null);
  const [loading, setLoading] = useState(true);
  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      const metricsRes = await axios.get('/api/dashboard/metrics', {
        headers: { Authorization: `Bearer ${token}` }
      });
      const auditRes = await axios.get('/api/dashboard/audit-report', {
        headers: { Authorization: `Bearer ${token}` }
      });
      setMetrics(metricsRes.data);
      setAuditReport(auditRes.data);
    } catch (error) {
      console.error('Failed to fetch dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="container"><p>Loading dashboard...</p></div>;

  const expenseData = metrics ? Object.entries(metrics.expensesByCategory).map(([category, amount]) => ({
    category,
    amount
  })) : [];

  return (
    <div className="container dashboard">
      <h1>Dashboard</h1>
      
      <div className="metrics-grid">
        <div className="metric-card">
          <div className="metric-label">Total Income</div>
          <div className="metric-value metric-positive">${metrics?.totalIncome.toFixed(2)}</div>
        </div>
        <div className="metric-card">
          <div className="metric-label">Total Expenses</div>
          <div className="metric-value metric-negative">${metrics?.totalExpenses.toFixed(2)}</div>
        </div>
        <div className="metric-card">
          <div className="metric-label">Net Cash Flow</div>
          <div className={`metric-value ${metrics?.netCashFlow >= 0 ? 'metric-positive' : 'metric-negative'}`}>
            ${metrics?.netCashFlow.toFixed(2)}
          </div>
        </div>
        <div className="metric-card">
          <div className="metric-label">Total Taxes</div>
          <div className="metric-value">${metrics?.totalTaxes.toFixed(2)}</div>
        </div>
      </div>

      <div className="grid">
        <div className="card">
          <h3>Expenses by Category</h3>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={expenseData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="category" />
              <YAxis />
              <Tooltip />
              <Bar dataKey="amount" fill="#667eea" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>

      <div className="card">
        <h3>Compliance & Audit Status</h3>
        <div className="compliance-grid">
          <div className="compliance-item">
            <span>Compliance Score:</span>
            <strong>{auditReport?.complianceScore}%</strong>
          </div>
          <div className="compliance-item">
            <span>Verified Transactions:</span>
            <strong>{auditReport?.auditVerifiedCount}/{auditReport?.totalTransactions}</strong>
          </div>
          <div className="compliance-item">
            <span>W2 Transactions:</span>
            <strong>{auditReport?.w2Transactions}</strong>
          </div>
          <div className="compliance-item">
            <span>1099 Transactions:</span>
            <strong>{auditReport?.['1099Transactions']}</strong>
          </div>
          <div className="compliance-item">
            <span>Ready for Tax Prep:</span>
            <strong className="badge badge-success">{auditReport?.readyForTaxPrep ? 'Yes' : 'No'}</strong>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
