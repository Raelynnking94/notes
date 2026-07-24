# Apex Ledger - Complete Setup & Deployment Guide

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Node.js 18+
- MongoDB 6.0+
- Stripe Account (for payments)
- Plaid Account (for bank sync)

### 1. Docker Deployment (Recommended)

```bash
# Clone the repository
git clone https://github.com/Raelynnking94/notes.git
cd notes/apex-ledger-app

# Make deploy script executable
chmod +x deploy.sh

# Create .env file
cp .env.example .env

# Edit .env with your credentials
nano .env

# Deploy with Docker
./deploy.sh
```

### 2. Manual Setup

**Backend:**
```bash
cd apex-ledger-app
npm install
npm start
```

**Frontend:**
```bash
cd apex-ledger-app/client
npm install
npm run dev
```

---

## 📧 Email Service Setup

### SMTP Configuration
Add to `.env`:
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=noreply@apexledger.com
```

### Email Features
- ✅ Transaction confirmations
- ✅ Monthly financial reports
- ✅ Compliance alerts
- ✅ Receipt notifications

---

## 🧪 Testing

### Run All Tests
```bash
npm test
```

### Test Coverage
```bash
npm test -- --coverage
```

### E2E Testing with Postman
1. Import `postman-collection.json`
2. Set environment variables
3. Run test suite

---

## 📊 API Documentation

### Swagger UI
```
http://localhost:5000/api-docs
```

### OpenAPI Spec
See `openapi.yaml` for complete API documentation

---

## 🔐 Security Checklist

- ✅ JWT authentication
- ✅ Password hashing (bcryptjs)
- ✅ Encrypted bank connections
- ✅ Receipt vault with sealing
- ✅ HTTPS in production
- ✅ Environment variable management
- ✅ SQL injection prevention
- ✅ CORS configuration

---

## 📈 Monitoring & Logs

### Docker Logs
```bash
docker-compose logs -f
```

### Specific Service
```bash
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mongodb
```

---

## 🌐 Production Deployment

### GitHub Actions CI/CD
Automatically tests and deploys on push to `main`

### Manual Deployment
```bash
# SSH into production server
ssh user@production-server.com

# Pull latest code
git pull origin main

# Rebuild and restart
docker-compose down
docker-compose up -d --build
```

---

## 💳 Stripe Integration

1. Get API keys from Stripe Dashboard
2. Add to `.env`:
   ```
   STRIPE_SECRET_KEY=sk_live_xxx
   STRIPE_WEBHOOK_SECRET=whsec_xxx
   ```
3. Set webhook endpoint: `https://yourdomain.com/api/stripe/webhook`

---

## 🏦 Plaid Integration

1. Create Plaid account at plaid.com
2. Add to `.env`:
   ```
   PLAID_CLIENT_ID=client_id
   PLAID_SECRET=secret
   PLAID_ENV=sandbox|development|production
   ```
3. Enable bank sync in frontend settings

---

## 📱 Mobile Access

The React frontend is fully responsive for:
- Desktop (1920px+)
- Tablet (768px - 1024px)
- Mobile (320px - 767px)

---

## 🆘 Troubleshooting

### Port Already in Use
```bash
# Change ports in docker-compose.yml
# or kill the process
lsof -i :5000
kill -9 PID
```

### MongoDB Connection Error
```bash
# Check MongoDB is running
docker-compose logs mongodb

# Restart MongoDB
docker-compose restart mongodb
```

### Frontend Build Issues
```bash
cd client
rm -rf node_modules dist
npm install
npm run build
```

---

## 📞 Support

- 📧 Email: support@apexledger.com
- 💬 Chat: Available in app
- 📖 Docs: https://docs.apexledger.com

---

## 📄 License

MIT License - See LICENSE file
