# ZK Messenger Infrastructure

A complete real-time messaging infrastructure built with **Centrifugo** and **NATS JetStream** for reliable, scalable messaging applications.

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   NATS Server   │────│  Centrifugo      │────│   Client Apps   │
│   + JetStream   │    │  Real-time Hub   │    │   (WebSocket,   │
│                 │    │                  │    │    SSE, etc.)   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Components

- **🚀 NATS JetStream**: Message streaming platform with persistence and exactly-once delivery
- **📡 Centrifugo**: Real-time messaging server with WebSocket/SSE support
- **🔧 Auto-initialization**: Automatic NATS stream setup on startup
- **🌐 Admin Interface**: Web-based monitoring and management
- **⚙️ ZK Messenger Node**: Core application server (Rust-based)
- **🗄️ MongoDB**: Database with replica set for change streams support

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Bash shell (for scripts)
- GitHub Container Registry access for zk-messenger-node

### Setup

First, authenticate with GitHub Container Registry:

```bash
# Login to GHCR (requires GitHub token with package read permissions)
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
```

### Start Services

```bash
# Start all services
./scripts/start-services.sh

# Or manually with Docker Compose
docker compose up -d
```

### Stop Services

```bash
# Stop services (keep data)
./scripts/stop-services.sh

# Stop services and remove all data
./scripts/stop-services.sh --drop-volumes
```

## 📊 Access Points

Once services are running:

| Service              | URL                                      | Purpose                |
| -------------------- | ---------------------------------------- | ---------------------- |
| **ZK Messenger API** | http://localhost:8080                    | Main application API   |
| **Centrifugo Admin** | http://localhost:8000/admin              | Web admin interface    |
| **Centrifugo API**   | http://localhost:8000/api                | HTTP API endpoint      |
| **Centrifugo SSE**   | http://localhost:8000/connection/uni_sse | Server-Sent Events     |
| **NATS Monitoring**  | http://localhost:8222                    | NATS server monitoring |
| **MongoDB**          | mongodb://localhost:27017                | Database connection    |

## 🔧 Configuration

### NATS JetStream

- **Stream Name**: `EVENTS`
- **Subjects**: `events.>` (all subjects under `events.*`)
- **Storage**: File-based persistence
- **Consumer**: `centrifugo_consumer` (durable)

### Centrifugo

- **Namespaces**: `personal` (for individual user channels)
- **Consumer**: NATS JetStream integration enabled
- **Authentication**: JWT-based with HMAC secret
- **Transports**: WebSocket, SSE, HTTP API

### Reset Everything

```bash
# Complete reset (removes all data)
./scripts/stop-services.sh --drop-volumes
docker system prune -f
./scripts/start-services.sh
```
