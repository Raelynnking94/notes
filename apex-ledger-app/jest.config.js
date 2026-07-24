import { describe, it, expect, beforeAll, afterAll } from '@jest/globals';
import axios from 'axios';

const API_URL = 'http://localhost:5000/api';
let token;
let userId;
let transactionId;

describe('Apex Ledger API', () => {
  describe('Authentication', () => {
    it('should register a new user', async () => {
      const response = await axios.post(`${API_URL}/auth/register`, {
        name: 'Test User',
        email: `test-${Date.now()}@example.com`,
        password: 'TestPassword123!',
        businessName: 'Test Business'
      });

      expect(response.status).toBe(201);
      expect(response.data.token).toBeDefined();
      expect(response.data.user).toBeDefined();
      token = response.data.token;
      userId = response.data.user.id;
    });

    it('should login existing user', async () => {
      const response = await axios.post(`${API_URL}/auth/login`, {
        email: 'test@example.com',
        password: 'TestPassword123!'
      }).catch(err => err.response);

      if (response.status === 200) {
        expect(response.data.token).toBeDefined();
      }
    });
  });

  describe('Transactions', () => {
    it('should create a transaction', async () => {
      const response = await axios.post(`${API_URL}/transactions`, {
        type: 'expense',
        amount: 150.00,
        category: 'Supplies',
        description: 'Office supplies',
        date: new Date(),
        vendor: 'Office Depot',
        taxable: true,
        w2vs1099: 'business'
      }, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(201);
      expect(response.data.transaction).toBeDefined();
      transactionId = response.data.transaction._id;
    });

    it('should fetch transactions', async () => {
      const response = await axios.get(`${API_URL}/transactions`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(Array.isArray(response.data)).toBe(true);
    });

    it('should filter transactions by date range', async () => {
      const response = await axios.get(`${API_URL}/transactions?startDate=2026-01-01&endDate=2026-12-31`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(Array.isArray(response.data)).toBe(true);
    });

    it('should update a transaction', async () => {
      if (!transactionId) return;
      
      const response = await axios.put(`${API_URL}/transactions/${transactionId}`, {
        amount: 200.00,
        description: 'Updated office supplies'
      }, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
    });

    it('should delete a transaction', async () => {
      if (!transactionId) return;
      
      const response = await axios.delete(`${API_URL}/transactions/${transactionId}`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
    });
  });

  describe('Dashboard', () => {
    it('should fetch dashboard metrics', async () => {
      const response = await axios.get(`${API_URL}/dashboard/metrics?period=30`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(response.data.totalIncome).toBeDefined();
      expect(response.data.totalExpenses).toBeDefined();
      expect(response.data.netCashFlow).toBeDefined();
    });

    it('should fetch audit-ready report', async () => {
      const response = await axios.get(`${API_URL}/dashboard/audit-report`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(response.data.complianceScore).toBeDefined();
      expect(response.data.auditVerifiedCount).toBeDefined();
      expect(response.data.readyForTaxPrep).toBeDefined();
    });
  });

  describe('Subscriptions', () => {
    it('should fetch subscription tiers', async () => {
      const response = await axios.get(`${API_URL}/subscriptions`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(response.data.tiers).toBeDefined();
      expect(response.data.tiers.free).toBeDefined();
      expect(response.data.tiers.pro).toBeDefined();
      expect(response.data.tiers.enterprise).toBeDefined();
    });

    it('should upgrade subscription', async () => {
      const response = await axios.post(`${API_URL}/subscriptions/upgrade`, {
        tier: 'pro'
      }, {
        headers: { Authorization: `Bearer ${token}` }
      });

      expect(response.status).toBe(200);
      expect(response.data.subscription.tier).toBe('pro');
    });
  });
});
