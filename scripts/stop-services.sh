#!/bin/bash

# Stop Centrifugo and NATS services
echo "🛑 Stopping Centrifugo and NATS services..."

# Parse command line arguments
DROP_VOLUMES=false
while [[ $# -gt 0 ]]; do
    case $1 in
    --drop-volumes | -v)
        DROP_VOLUMES=true
        shift
        ;;
    --help | -h)
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --drop-volumes, -v    Remove all volumes (data will be lost!)"
        echo "  --help, -h           Show this help message"
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
    esac
done

# Stop services
echo "📊 Current service status:"
docker compose ps

echo ""
echo "🛑 Stopping services..."
docker compose down

if [ "$DROP_VOLUMES" = true ]; then
    echo ""
    echo "⚠️  Dropping volumes (data will be lost)..."
    docker compose down --volumes
    echo "🗑️  Volumes removed"
fi

echo ""
echo "📊 Final status:"
docker compose ps

echo ""
echo "✅ Services stopped!"
echo ""
echo "📋 Useful commands:"
echo "   • Start services:     ./start-services.sh"
echo "   • View logs:          docker compose logs"
echo "   • Clean everything:   docker compose down --volumes --rmi all"
