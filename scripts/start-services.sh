#!/bin/bash

echo "🚀 Starting all the services..."

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
echo "   • Node: http://localhost:8080"
echo "   • Centrifugo: http://localhost:8000"
echo "   • Monitor: http://localhost:8090"
echo ""
echo "📋 Useful commands:"
echo "   • View logs:        docker-compose logs -f"
echo "   • Stop services:    docker-compose down"
echo "   • Restart:          docker-compose restart"
