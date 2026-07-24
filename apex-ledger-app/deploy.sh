#!/bin/bash

# Apex Ledger Docker Deployment Script

echo "🚀 Starting Apex Ledger deployment..."

# Load environment variables
if [ ! -f .env ]; then
  echo "❌ .env file not found. Creating from template..."
  cp .env.example .env
  echo "⚠️  Please update .env with your credentials"
  exit 1
fi

echo "📦 Building Docker images..."
docker-compose build

echo "🔧 Starting services..."
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 10

echo "✅ Apex Ledger is running!"
echo ""
echo "📊 Dashboard: http://localhost:3000"
echo "🔌 API: http://localhost:5000/api/health"
echo "💾 Database: localhost:27017"
echo ""
echo "View logs: docker-compose logs -f"
