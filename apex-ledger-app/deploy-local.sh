#!/bin/bash

# Quick local deployment for testing

echo "🐳 Starting Apex Ledger with Docker Compose (Local)"
echo "===================================================="
echo ""

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not found. Installing..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo "📦 Building images..."
docker-compose build

echo ""
echo "🚀 Starting services..."
docker-compose up -d

echo ""
echo "⏳ Waiting for services to be ready (20 seconds)..."
sleep 20

echo ""
echo "✅ Apex Ledger is running locally!"
echo ""
echo "📊 Access your app:"
echo "   🎨 Dashboard: http://localhost:3000"
echo "   🔌 API: http://localhost:5000"
echo "   📖 API Docs: http://localhost:5000/api-docs"
echo "   🗄️  Database: localhost:27017 (admin:password123)"
echo ""
echo "📝 Useful commands:"
echo "   View logs:     docker-compose logs -f"
echo "   API logs:      docker-compose logs -f backend"
echo "   Web logs:      docker-compose logs -f frontend"
echo "   DB logs:       docker-compose logs -f mongodb"
echo "   Stop:          docker-compose down"
echo "   Restart:       docker-compose restart"
echo ""
echo "🧪 Test API:"
echo "   curl -X GET http://localhost:5000/api/health"
echo ""
echo "💡 Pro tip: Mount local code for live reloading"
echo "   Edit docker-compose.yml to add volumes for development"
echo ""
