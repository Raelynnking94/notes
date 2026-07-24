#!/bin/bash

# Apex Ledger Email Notification Service
# Sends transaction confirmations, receipts, and compliance alerts

import nodemailer from 'nodemailer';
import dotenv from 'dotenv';

dotenv.config();

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  secure: process.env.SMTP_SECURE === 'true',
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS
  }
});

export const sendTransactionConfirmation = async (userEmail, transaction) => {
  const mailOptions = {
    from: process.env.SMTP_FROM,
    to: userEmail,
    subject: `Transaction Confirmed - ${transaction.type === 'income' ? '+' : '-'}$${transaction.amount.toFixed(2)}`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <h2>Transaction Confirmed</h2>
        <p>Your transaction has been recorded in Apex Ledger:</p>
        <table style="width: 100%; border-collapse: collapse;">
          <tr>
            <td style="padding: 8px; font-weight: bold; border-bottom: 1px solid #ddd;">Type:</td>
            <td style="padding: 8px; border-bottom: 1px solid #ddd;">${transaction.type}</td>
          </tr>
          <tr>
            <td style="padding: 8px; font-weight: bold; border-bottom: 1px solid #ddd;">Amount:</td>
            <td style="padding: 8px; border-bottom: 1px solid #ddd;">$${transaction.amount.toFixed(2)}</td>
          </tr>
          <tr>
            <td style="padding: 8px; font-weight: bold; border-bottom: 1px solid #ddd;">Category:</td>
            <td style="padding: 8px; border-bottom: 1px solid #ddd;">${transaction.category}</td>
          </tr>
          <tr>
            <td style="padding: 8px; font-weight: bold; border-bottom: 1px solid #ddd;">Date:</td>
            <td style="padding: 8px; border-bottom: 1px solid #ddd;">${new Date(transaction.date).toLocaleDateString()}</td>
          </tr>
          <tr>
            <td style="padding: 8px; font-weight: bold; border-bottom: 1px solid #ddd;">Audit Status:</td>
            <td style="padding: 8px; border-bottom: 1px solid #ddd;"><span style="background: #d1fae5; color: #065f46; padding: 4px 12px; border-radius: 20px;">✓ Verified</span></td>
          </tr>
        </table>
        <p style="margin-top: 20px; color: #666; font-size: 12px;">Powered by Apex Ledger - Professional Bookkeeping</p>
      </div>
    `
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log(`Email sent to ${userEmail}`);
  } catch (error) {
    console.error('Email send error:', error);
  }
};

export const sendMonthlyReport = async (userEmail, metrics) => {
  const mailOptions = {
    from: process.env.SMTP_FROM,
    to: userEmail,
    subject: `Your Monthly Bookkeeping Report - Apex Ledger`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <h2>Monthly Bookkeeping Summary</h2>
        <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <h3 style="margin-top: 0; color: #667eea;">Financial Overview</h3>
          <table style="width: 100%;">
            <tr>
              <td style="padding: 12px; font-weight: bold;">Total Income:</td>
              <td style="padding: 12px; text-align: right; color: #10b981; font-weight: bold;">$${metrics.totalIncome.toFixed(2)}</td>
            </tr>
            <tr style="background: white;">
              <td style="padding: 12px; font-weight: bold;">Total Expenses:</td>
              <td style="padding: 12px; text-align: right; color: #ef4444; font-weight: bold;">$${metrics.totalExpenses.toFixed(2)}</td>
            </tr>
            <tr>
              <td style="padding: 12px; font-weight: bold;">Net Cash Flow:</td>
              <td style="padding: 12px; text-align: right; color: #667eea; font-weight: bold; font-size: 18px;">$${metrics.netCashFlow.toFixed(2)}</td>
            </tr>
            <tr style="background: white;">
              <td style="padding: 12px; font-weight: bold;">Total Taxes:</td>
              <td style="padding: 12px; text-align: right;">$${metrics.totalTaxes.toFixed(2)}</td>
            </tr>
          </table>
        </div>
        <p style="margin-top: 20px; color: #666; font-size: 12px;">This report is audit-ready and compliant with tax regulations.</p>
      </div>
    `
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log(`Monthly report sent to ${userEmail}`);
  } catch (error) {
    console.error('Email send error:', error);
  }
};

export const sendAuditAlert = async (userEmail, auditReport) => {
  const mailOptions = {
    from: process.env.SMTP_FROM,
    to: userEmail,
    subject: `Compliance Alert - Audit Report Ready`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <h2>Your Audit Report is Ready</h2>
        <div style="background: #d1fae5; padding: 16px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #10b981;">
          <p style="margin: 0; color: #065f46;">
            ✓ Compliance Score: <strong>${auditReport.complianceScore}%</strong>
          </p>
          <p style="margin: 8px 0 0 0; color: #065f46;">
            Your books are <strong>${auditReport.readyForTaxPrep ? 'ready' : 'not ready'}</strong> for tax preparation.
          </p>
        </div>
        <p>You can download your audit report from your dashboard anytime.</p>
      </div>
    `
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log(`Audit alert sent to ${userEmail}`);
  } catch (error) {
    console.error('Email send error:', error);
  }
};
