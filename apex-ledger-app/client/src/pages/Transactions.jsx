import { useState, useEffect } from 'react';
import axios from 'axios';
import './Transactions.css';

function Transactions() {
  const [transactions, setTransactions] = useState([]);
  const [formData, setFormData] = useState({
    type: 'expense',
    amount: '',
    category: 'Other',
    description: '',
    date: new Date().toISOString().split('T')[0],
    vendor: '',
    taxable: true,
    w2vs1099: 'business'
  });
  const [loading, setLoading] = useState(false);
  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchTransactions();
  }, []);

  const fetchTransactions = async () => {
    try {
      const res = await axios.get('/api/transactions', {
        headers: { Authorization: `Bearer ${token}` }
      });
      setTransactions(res.data);
    } catch (error) {
      console.error('Failed to fetch transactions:', error);
    }
  };

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? checked : value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      await axios.post('/api/transactions', formData, {
        headers: { Authorization: `Bearer ${token}` }
      });
      setFormData({
        type: 'expense',
        amount: '',
        category: 'Other',
        description: '',
        date: new Date().toISOString().split('T')[0],
        vendor: '',
        taxable: true,
        w2vs1099: 'business'
      });
      fetchTransactions();
    } catch (error) {
      console.error('Failed to create transaction:', error);
    } finally {
      setLoading(false);
    }
  };

  const deleteTransaction = async (id) => {
    try {
      await axios.delete(`/api/transactions/${id}`, {
        headers: { Authorization: `Bearer ${token}` }
      });
      fetchTransactions();
    } catch (error) {
      console.error('Failed to delete transaction:', error);
    }
  };

  return (
    <div className="container transactions">
      <h1>Transactions</h1>

      <div className="card form-card">
        <h2>Record Transaction</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-grid">
            <div className="input-group">
              <label>Type</label>
              <select name="type" value={formData.type} onChange={handleChange}>
                <option value="expense">Expense</option>
                <option value="income">Income</option>
              </select>
            </div>
            <div className="input-group">
              <label>Amount</label>
              <input type="number" step="0.01" name="amount" value={formData.amount} onChange={handleChange} required />
            </div>
            <div className="input-group">
              <label>Category</label>
              <select name="category" value={formData.category} onChange={handleChange}>
                <option value="Other">Other</option>
                <option value="Supplies">Supplies</option>
                <option value="Utilities">Utilities</option>
                <option value="Travel">Travel</option>
                <option value="Equipment">Equipment</option>
              </select>
            </div>
            <div className="input-group">
              <label>Date</label>
              <input type="date" name="date" value={formData.date} onChange={handleChange} required />
            </div>
          </div>

          <div className="form-grid">
            <div className="input-group">
              <label>Vendor/Source</label>
              <input type="text" name="vendor" value={formData.vendor} onChange={handleChange} />
            </div>
            <div className="input-group">
              <label>W2 / 1099 Type</label>
              <select name="w2vs1099" value={formData.w2vs1099} onChange={handleChange}>
                <option value="business">Business</option>
                <option value="W2">W2</option>
                <option value="1099">1099</option>
                <option value="personal">Personal</option>
              </select>
            </div>
          </div>

          <div className="input-group">
            <label>Description</label>
            <textarea name="description" value={formData.description} onChange={handleChange} rows="3"></textarea>
          </div>

          <div className="checkbox-group">
            <input type="checkbox" name="taxable" checked={formData.taxable} onChange={handleChange} id="taxable" />
            <label htmlFor="taxable">Taxable Transaction</label>
          </div>

          <button type="submit" className="btn btn-primary" disabled={loading}>
            {loading ? 'Recording...' : 'Record Transaction'}
          </button>
        </form>
      </div>

      <div className="card">
        <h2>Recent Transactions</h2>
        <div className="transactions-list">
          {transactions.length === 0 ? (
            <p>No transactions recorded yet.</p>
          ) : (
            <table>
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Type</th>
                  <th>Category</th>
                  <th>Amount</th>
                  <th>Vendor</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {transactions.map((tx) => (
                  <tr key={tx._id}>
                    <td>{new Date(tx.date).toLocaleDateString()}</td>
                    <td><span className={`badge ${tx.type === 'income' ? 'badge-success' : 'badge-warning'}`}>{tx.type}</span></td>
                    <td>{tx.category}</td>
                    <td className={tx.type === 'income' ? 'text-positive' : 'text-negative'}>
                      {tx.type === 'income' ? '+' : '-'}${tx.amount.toFixed(2)}
                    </td>
                    <td>{tx.vendor || '-'}</td>
                    <td><span className="badge badge-success">Verified</span></td>
                    <td>
                      <button onClick={() => deleteTransaction(tx._id)} className="btn btn-secondary btn-small">
                        Delete
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}

export default Transactions;
