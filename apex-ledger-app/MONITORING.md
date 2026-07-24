# Apex Ledger - Monitoring & Observability Setup

## 📊 Real-Time Dashboards

### Datadog Integration

```bash
# Install Datadog agent
npm install dd-trace

# Add to server.js
const tracer = require('dd-trace').init({
  logInjection: true,
  analyticsEnabled: true
})
```

### Prometheus Metrics

```bash
npm install prom-client
```

Add to `server.js`:
```javascript
const prometheus = require('prom-client');

app.get('/metrics', (req, res) => {
  res.set('Content-Type', prometheus.register.contentType);
  res.end(prometheus.register.metrics());
});
```

---

## 🚨 Error Tracking

### Sentry Integration

```bash
npm install @sentry/node
```

Add to `server.js`:
```javascript
const Sentry = require('@sentry/node');

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 1.0
});

app.use(Sentry.Handlers.errorHandler());
```

---

## 📈 Performance Monitoring

### New Relic Agent

```bash
npm install newrelic
```

Create `newrelic.js`:
```javascript
exports.config = {
  app_name: ['Apex Ledger'],
  license_key: process.env.NEW_RELIC_LICENSE_KEY,
  logging: {
    level: 'info'
  }
};
```

Add as first line of `server.js`:
```javascript
require('newrelic');
```

---

## 📝 Centralized Logging

### Winston Logger

```bash
npm install winston
```

Create `logger.js`:
```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple()
  }));
}

module.exports = logger;
```

---

## 🔔 Alerting Setup

### PagerDuty Integration

```javascript
const PagerDuty = require('pagerduty');

const client = new PagerDuty({
  token: process.env.PAGERDUTY_TOKEN
});

// Alert on critical errors
if (error.severity === 'critical') {
  client.incidents.create({
    title: error.message,
    urgency: 'high'
  });
}
```

---

## 📱 Uptime Monitoring

### Status Page Setup

1. Create account at `status.io` or `statuspage.io`
2. Add monitoring for:
   - API endpoint: `/api/health`
   - Frontend: `https://apexledger.com`
   - Database connectivity

3. Set up automated status updates

---

## 🔐 Security Monitoring

### CloudFlare WAF Rules

```
- Rate limit API: 100 requests/minute per IP
- Block suspicious user agents
- Enable DDoS protection
- Monitor for SQL injection attempts
- Track failed login attempts
```

---

## 📊 Key Metrics to Track

### API Performance
- Response time (p50, p95, p99)
- Error rate (%)
- Request rate (req/sec)
- Database query time
- Memory usage
- CPU usage

### Business Metrics
- Active users
- Subscription conversion rate
- Average transaction value
- User retention
- Churn rate

### User Experience
- Frontend load time
- Time to interactive
- JavaScript errors
- API latency from user perspective

---

## 🎯 Alert Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| API Response Time | > 500ms | > 2s |
| Error Rate | > 1% | > 5% |
| CPU Usage | > 70% | > 90% |
| Memory Usage | > 75% | > 90% |
| Database Connections | > 80% | > 95% |
| Disk Space | > 80% | > 95% |
| Failed Logins (5m) | > 10 | > 20 |

---

## 📡 Monitoring Stack (Recommended)

```yaml
Metrics: Prometheus + Grafana
Tracing: Jaeger
Logging: ELK Stack (Elasticsearch, Logstash, Kibana)
Alerting: AlertManager
Error Tracking: Sentry
Uptime: UptimeRobot
Status Page: Statuspage.io
```

Total monthly cost: ~$100-200

---

## 🚀 Deploy Monitoring Stack

```bash
cd monitoring
docker-compose up -d
```

Access dashboards:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000
- Jaeger: http://localhost:16686
- Kibana: http://localhost:5601
