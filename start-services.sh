#!/bin/bash

echo "🚀 Starting Centrifugo and NATS services..."

docker compose down

docker compose up -d

sleep 5

echo "📊 Service Status:"
docker compose ps

echo ""
echo "📝 Recent logs:"
docker compose logs --tail=10

echo ""
echo "✅ Services started!"
echo ""
echo "🌐 Access points:"
echo "   • Centrifugo Admin: http://localhost:8000/admin"
echo "   • Centrifugo API:   http://localhost:8000/api"
echo "   • Centrifugo SSE:   http://localhost:8000/connection/uni_sse"
echo "   • NATS Monitoring:  http://localhost:8222"
echo ""
echo "📋 Useful commands:"
echo "   • View logs:        docker-compose logs -f"
echo "   • Stop services:    docker-compose down"
echo "   • Restart:          docker-compose restart"
