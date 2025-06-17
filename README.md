# FriendCircle – Microservices-Based Social Platform Backend

A social platform backend enabling users to manage profiles, addresses, friendships, and communicate through a modern microservices architecture.

## Modules:
- `user-service`: User registration, login, JWT-based authentication
- `address-service`: Address management and CRUD operations
- `friendship-service`: Friend requests and relationship management
- `hobby-service`: Hobby data storage and friend-only access
- `message-service`: Kafka-based messaging between users
- `notification-service`: Event-driven notifications
- `gateway-service`: API Gateway with JWT validation and routing
- `config-service`: Centralized configuration management
- `discovery-service`: Service discovery via Eureka
- `common-lib`: Shared utilities and DTOs

## Tech Stack:
- Java 17
- Spring Boot 3.2+
- Spring Cloud (Gateway, Config, Eureka)
- Apache Kafka
- PostgreSQL
- MongoDB
- Redis
- Docker & Docker Compose
- ELK Stack
- Prometheus & Grafana

## Getting Started:
1. Ensure Docker and Java 17 are installed
2. Clone the repository
3. Run all services via docker-compose:
   ```bash
   docker-compose up -d
   ```
4. Access the API Gateway at http://localhost:8080

## Development:
- Each service is independently deployable
- Uses Maven for dependency management
- Follows REST principles with versioned APIs
- Implements JWT-based security
- Includes comprehensive monitoring and logging