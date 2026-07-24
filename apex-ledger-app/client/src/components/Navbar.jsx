import { Link } from 'react-router-dom';
import './Navbar.css';

function Navbar({ onLogout }) {
  return (
    <nav className="navbar">
      <div className="nav-container">
        <Link to="/dashboard" className="nav-logo">
          💼 Apex Ledger
        </Link>
        <ul className="nav-menu">
          <li><Link to="/dashboard">Dashboard</Link></li>
          <li><Link to="/transactions">Transactions</Link></li>
          <li><Link to="/bank-sync">Bank Sync</Link></li>
          <li><Link to="/subscriptions">Subscriptions</Link></li>
          <li><button onClick={onLogout} className="btn btn-secondary">Logout</button></li>
        </ul>
      </div>
    </nav>
  );
}

export default Navbar;
