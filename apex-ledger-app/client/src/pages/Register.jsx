import { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import axios from 'axios';
import './Auth.css';

function Register({ onLogin }) {
  const [formData, setFormData] = useState({ name: '', email: '', password: '', businessName: '' });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const response = await axios.post('/api/auth/register', formData);
      onLogin(response.data.token);
      navigate('/dashboard');
    } catch (err) {
      setError(err.response?.data?.error || 'Registration failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <h1>Create Account</h1>
        <p className="subtitle">Join Apex Ledger - Professional Bookkeeping</p>
        
        {error && <div className="error-message">{error}</div>}
        
        <form onSubmit={handleSubmit}>
          <div className="input-group">
            <label>Full Name</label>
            <input type="text" name="name" placeholder="John Doe" onChange={handleChange} required />
          </div>
          <div className="input-group">
            <label>Email</label>
            <input type="email" name="email" placeholder="you@example.com" onChange={handleChange} required />
          </div>
          <div className="input-group">
            <label>Business Name</label>
            <input type="text" name="businessName" placeholder="Your Business Inc." onChange={handleChange} />
          </div>
          <div className="input-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" onChange={handleChange} required />
          </div>
          <button type="submit" className="btn btn-primary" disabled={loading}>
            {loading ? 'Creating account...' : 'Register'}
          </button>
        </form>
        
        <p className="auth-footer">Already have an account? <Link to="/login">Login here</Link></p>
      </div>
    </div>
  );
}

export default Register;
