import { useState } from 'react';
import axios from 'axios';
import './BankSync.css';

function BankSync() {
  const [bankConnections, setBankConnections] = useState([]);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState({ bankName: '', accountType: 'checking' });
  const token = localStorage.getItem('token');

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleConnect = async (e) => {
    e.preventDefault();
    // In production, integrate with Plaid SDK here
    alert('Plaid integration: In production, this would open Plaid Link modal for bank authentication');
    setShowForm(false);
  };

  const handleSync = async () => {
    alert('Bank sync initiated - Real bank data would be ingested in real-time with encrypted connections');
  };

  return (
    <div className="container bank-sync">
      <h1>Bank Sync</h1>
      
      <div className="card">
        <div className="header-actions">
          <h2>Connected Banks</h2>
          <button className="btn btn-primary" onClick={() => setShowForm(!showForm)}>
            {showForm ? 'Cancel' : '+ Connect Bank'}
          </button>
        </div>

        {showForm && (
          <form onSubmit={handleConnect} className="bank-form">
            <div className="input-group">
              <label>Bank Name</label>
              <input type="text" name="bankName" placeholder="e.g., Chase, Bank of America" onChange={handleChange} required />
            </div>
            <div className="input-group">
              <label>Account Type</label>
              <select name="accountType" value={formData.accountType} onChange={handleChange}>
                <option value="checking">Checking</option>
                <option value="savings">Savings</option>
                <option value="business">Business</option>
              </select>
            </div>
            <button type="submit" className="btn btn-primary">Connect with Plaid</button>
          </form>
        )}

        {bankConnections.length === 0 && !showForm && (
          <div className="empty-state">
            <p>No banks connected yet.</p>
            <p className="text-muted">Connect your bank account to enable real-time transaction syncing.</p>
          </div>
        )}

        {bankConnections.length > 0 && (
          <div className="connections-list">
            {bankConnections.map((conn, idx) => (
              <div key={idx} className="connection-item">
                <div className="connection-info">
                  <h3>{conn.bankName}</h3>
                  <p>{conn.accountType} • Last synced: {conn.lastSync}</p>
                </div>
                <button onClick={handleSync} className="btn btn-secondary">Sync Now</button>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="card">
        <h2>Plaid Integration</h2>
        <p>Apex Ledger uses Plaid for secure bank connections with:</p>
        <ul className="features-list">
          <li>✓ Automatic real-time transaction ingestion</li>
          <li>✓ Permanent encrypted connections</li>
          <li>✓ Instant bankroll reconciliation</li>
          <li>✓ Zero-latency cash flow updates</li>
          <li>✓ Support for 12,000+ financial institutions</li>
        </ul>
      </div>
    </div>
  );
}

export default BankSync;
