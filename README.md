# FriendCircle

Absolutely — here’s a **powerful, self-contained prompt** you can put in your `README.md` or feed into an AI to generate your full project. It captures **every constraint, decision, tech stack, architecture, and behavior** you’ve locked in:

---

## 🧠 FriendCircle Project Prompt for AI

> **Prompt (README Usage or AI Boot Instruction):**

---

**Build a complete microservices-based backend project named `FriendCircle` based on the following exact requirements. Do not ask any questions. Just build the system as defined below.**

---

### ✅ Project Purpose:

A social platform backend where users can:

* Register, login (JWT-based)
* Add/update/delete their **own addresses**
* Send and accept **friend requests**
* View **friend-only data** (like hobbies)
* **Message** friends (Kafka-based messaging)
* View friend list and message threads
* Receive **notifications** on friend events and messages

---

### ✅ Architecture Constraints:

* **Microservices-based** backend
* Each service is **fully isolated**, independently deployable
* Use **Spring Boot 3.2+**, **Java 17**, **Maven**
* Use **REST for synchronous** service-to-service calls (Feign)
* Use **Kafka for asynchronous** messaging (no RabbitMQ)

---

### ✅ Required Microservices:

| Service Name           | Description                                                            | Database   |
| ---------------------- | ---------------------------------------------------------------------- | ---------- |
| `user-service`         | Handles user registration, login, JWT auth, and profile data           | PostgreSQL |
| `address-service`      | Manages user addresses (CRUD)                                          | PostgreSQL |
| `friendship-service`   | Manages friend requests, acceptances, and friend relationships         | PostgreSQL |
| `hobby-service`        | Stores and retrieves hobby data (accessible only by friends)           | MongoDB    |
| `message-service`      | Kafka-based messaging between users. Stores message threads            | Kafka      |
| `notification-service` | Consumes Kafka events and stores/send notifications                    | Kafka      |
| `gateway-service`      | API Gateway using Spring Cloud Gateway with JWT validation and routing | None       |
| `config-service`       | Spring Cloud Config server with Git-based configuration                | Git-backed |
| `discovery-service`    | Eureka-based service discovery                                         | None       |

---

### ✅ Tech Stack (Strict and Final)

| Purpose                  | Technology                                  |
| ------------------------ | ------------------------------------------- |
| Language                 | Java 17                                     |
| Framework                | Spring Boot 3.2+                            |
| Build Tool               | Maven                                       |
| DB for structured data   | PostgreSQL                                  |
| DB for unstructured data | MongoDB (used only for hobbies)             |
| Caching                  | Redis                                       |
| Messaging                | Apache Kafka                                |
| Dev Environments         | Devfile-based containers                    |
| Containerization         | Docker + Docker Compose                     |
| Configuration Management | Spring Cloud Config                         |
| Service Discovery        | Eureka                                      |
| API Gateway              | Spring Cloud Gateway                        |
| Security/Auth            | Spring Security + JWT                       |
| Logging                  | ELK Stack (Logstash, Elasticsearch, Kibana) |
| Monitoring & Metrics     | Prometheus + Grafana                        |
| Tracing                  | Spring Sleuth + Zipkin                      |
| REST Clients             | Feign                                       |
| GitOps                   | Git-backed config repo                      |

---

### ✅ Kafka Topics

| Topic Name        | Purpose                               |
| ----------------- | ------------------------------------- |
| `friend-requests` | Emitted on friend send/accept actions |
| `user-messages`   | Emitted when users message each other |
| `notifications`   | Internal events for notifications     |

---

### ✅ Required Project Structure (Monorepo)

```
friendcircle/
│
├── common-lib/               # Shared DTOs, Kafka config, utils
├── config-service/
├── discovery-service/
├── gateway-service/
│
├── user-service/
├── address-service/
├── friendship-service/
├── hobby-service/
├── message-service/
├── notification-service/
│
├── docker-compose.yml        # Compose setup for local dev
└── devfile.yaml              # Dev environment configuration
```

---

### ✅ Runtime and Behavior Requirements

* JWT authentication is mandatory for all services (except config and discovery).
* Gateway must validate JWT and forward roles/userId as headers.
* All APIs should be RESTful, versioned (`/api/v1/`), with clear error handling.
* All user-to-user messages and friend events must flow via Kafka only.
* Every service must expose Actuator endpoints (`/actuator/health`, `/metrics`).
* Use Prometheus annotations for scraping metrics.
* Services should register with Eureka at runtime.
* Logging must be JSON-structured and routed to ELK via Logstash.
* Use consistent DTOs and mapper layers across services.

---

**Generate all services, config files, Dockerfiles, Kafka setup, health checks, metrics, and logs exactly as per the above definition. Do not omit any service or configuration. Do not propose alternatives. Build the complete production-grade codebase with clear separation.**

---
Here is a **complete list of JIRA-style tickets** for your `FriendCircle` microservices-based backend project. These tickets are:

* ✅ **Self-contained** (independent of others as much as possible)
* ✅ **Minimally scoped** (one core concept per task)
* ✅ **Functional** (each delivers a working feature, config, or proof of concept)
* ✅ **Educational** (helps you learn and apply key microservice/backend concepts)

---

## 🧾 EPIC: Platform Setup

---

### 🔹 `FRND-1` – Initialize Monorepo Structure

**Description:** Create folder structure with placeholders for each service, `common-lib`, and `docker-compose.yaml`.
**Goal:** Establish scaffolding to host all services in a clean monorepo.
**Teaches:** Modular architecture setup.

---

### 🔹 `FRND-2` – Setup Spring Cloud Config Server

**Description:** Implement a Spring Boot `config-service` using Spring Cloud Config backed by a local Git repo.
**Goal:** Serve centralized configs to other services.
**Teaches:** Centralized config management.

---

### 🔹 `FRND-3` – Setup Eureka Discovery Service

**Description:** Implement `discovery-service` using Spring Cloud Netflix Eureka.
**Goal:** Allow all services to register and discover each other.
**Teaches:** Service discovery with Eureka.

---

### 🔹 `FRND-4` – Setup Gateway with Spring Cloud Gateway

**Description:** Implement `gateway-service` for routing and JWT-based auth forwarding.
**Goal:** Centralized entry point for all external calls.
**Teaches:** Gateway routing, filters, and JWT handling.

---

## 🧾 EPIC: User Management

---

### 🔹 `FRND-5` – Create user-service base with REST and PostgreSQL

**Description:** Bootstrap `user-service` with Spring Boot, PostgreSQL, JPA, and H2 for testing.
**Goal:** Establish DB connectivity and CRUD skeleton.
**Teaches:** Spring Boot + JPA + PostgreSQL setup.

---

### 🔹 `FRND-6` – Implement User Registration API

**Description:** Create `POST /api/v1/users/register` to register a new user.
**Goal:** Save user with username, email, password (hashed).
**Teaches:** DTOs, mapping, validation.

---

### 🔹 `FRND-7` – Implement JWT-based Login

**Description:** Add `POST /api/v1/auth/login` with JWT token issuance using Spring Security.
**Goal:** Secure the service and return signed JWT.
**Teaches:** JWT setup and Spring Security basics.

---

### 🔹 `FRND-8` – Add Token Validation at Gateway

**Description:** Validate JWT in `gateway-service`, pass `userId` and roles to downstream services.
**Goal:** Enforce security at entry point.
**Teaches:** Filters and JWT propagation.

---

## 🧾 EPIC: Address Management

---

### 🔹 `FRND-9` – Create address-service with PostgreSQL

**Description:** Scaffold `address-service`, DB schema, and basic config.
**Goal:** Isolate address logic in its own service.
**Teaches:** Microservice independence.

---

### 🔹 `FRND-10` – Implement Add Address API

**Description:** `POST /api/v1/addresses` to add a new address for the logged-in user.
**Goal:** Add address linked to authenticated user.
**Teaches:** Auth context + ownership.

---

### 🔹 `FRND-11` – Implement View/Delete Addresses

**Description:** Expose `GET /api/v1/addresses` and `DELETE /api/v1/addresses/{id}`.
**Goal:** Allow user to view and remove own addresses.
**Teaches:** Secure REST patterns.

---

## 🧾 EPIC: Friendship Management

---

### 🔹 `FRND-12` – Create friendship-service with schema

**Description:** Scaffold `friendship-service` with table for friend requests and status.
**Goal:** Base for managing relationships.
**Teaches:** Designing relational join-type tables.

---

### 🔹 `FRND-13` – Send Friend Request

**Description:** `POST /api/v1/friends/request` for sending a friend request.
**Goal:** Store a pending request from one user to another.
**Teaches:** Relationship modeling.

---

### 🔹 `FRND-14` – Accept Friend Request

**Description:** `POST /api/v1/friends/accept` to accept a pending request.
**Goal:** Mark request as accepted.
**Teaches:** Validation and updates.

---

### 🔹 `FRND-15` – Get Friend List

**Description:** `GET /api/v1/friends` to return all approved friends of the logged-in user.
**Goal:** Retrieve list of confirmed friends.
**Teaches:** Relationship queries.

---

## 🧾 EPIC: Hobbies & Privacy

---

### 🔹 `FRND-16` – Create hobby-service with MongoDB

**Description:** Scaffold `hobby-service` using MongoDB to store user hobby info.
**Goal:** Separate hobby data store.
**Teaches:** NoSQL integration.

---

### 🔹 `FRND-17` – Save & Retrieve Own Hobbies

**Description:** Add endpoints `POST /hobbies` and `GET /hobbies/me`.
**Goal:** Users manage their own hobbies.
**Teaches:** MongoDB usage and filters.

---

### 🔹 `FRND-18` – View Friend’s Hobbies (only if friends)

**Description:** `GET /hobbies/{userId}` available only to friends.
**Goal:** Enforce access control.
**Teaches:** Cross-service checks.

---

## 🧾 EPIC: Messaging & Kafka

---

### 🔹 `FRND-19` – Setup Kafka locally with Docker Compose

**Description:** Configure Kafka, create topics: `user-messages`, `friend-requests`, `notifications`.
**Goal:** Enable Kafka for all services.
**Teaches:** Kafka setup.

---

### 🔹 `FRND-20` – Create message-service and consume/produce messages

**Description:** Scaffold `message-service`, consume `user-messages`, expose thread API.
**Goal:** Store and retrieve message threads.
**Teaches:** Kafka Producer/Consumer, stateful logic.

---

### 🔹 `FRND-21` – Send Message to Friend (Kafka)

**Description:** `POST /messages/send` produces message to Kafka.
**Goal:** Decouple message flow from persistence.
**Teaches:** Async event production.

---

### 🔹 `FRND-22` – View Message Thread

**Description:** `GET /messages/thread/{friendId}` returns chat history.
**Goal:** Filter messages between 2 users.
**Teaches:** Kafka-backed data retrieval.

---

## 🧾 EPIC: Notifications (Kafka Event Listeners)

---

### 🔹 `FRND-23` – Scaffold notification-service

**Description:** Consume Kafka topics: `friend-requests`, `user-messages`.
**Goal:** Log and store notifications.
**Teaches:** Event-based systems.

---

### 🔹 `FRND-24` – Show Notifications to User

**Description:** `GET /notifications` shows all notifications for current user.
**Goal:** User-facing inbox of events.
**Teaches:** Event logs.

---

## 🧾 EPIC: Observability & Monitoring

---

### 🔹 `FRND-25` – Add Spring Actuator to All Services

**Description:** Enable `/actuator/health` and `/actuator/metrics`.
**Goal:** Basic service health endpoints.
**Teaches:** Observability starters.

---

### 🔹 `FRND-26` – Integrate Prometheus + Grafana

**Description:** Add Prometheus scraping and dashboard with Grafana.
**Goal:** View live service metrics.
**Teaches:** Metrics, dashboards.

---

### 🔹 `FRND-27` – Integrate Sleuth + Zipkin for Distributed Tracing

**Description:** Enable Sleuth and export traces to Zipkin.
**Goal:** View request flow across services.
**Teaches:** Tracing microservices.

---

## 🧾 EPIC: Logging & DevOps

---

### 🔹 `FRND-28` – Setup Logback with JSON format for ELK

**Description:** All logs should be in JSON structured format.
**Goal:** Feed into Logstash.
**Teaches:** Logging best practices.

---

### 🔹 `FRND-29` – Integrate ELK Stack (Local)

**Description:** Set up Logstash, Elasticsearch, Kibana in Docker Compose.
**Goal:** Centralize and visualize logs.
**Teaches:** Centralized logging.

---

### 🔹 `FRND-30` – Build Dockerfiles for Each Service

**Description:** Add working Dockerfile to each microservice.
**Goal:** Enable container-based deployment.
**Teaches:** Dockerization.

---

### 🔹 `FRND-31` – Write docker-compose.yml for Local Orchestration

**Description:** Single file to spin up all services + Kafka + DBs + observability stack.
**Goal:** Local dev environment setup.
**Teaches:** System integration via Docker Compose.

---

Would you like me to generate this as an actual **`.csv` or `.md` JIRA ticket file**, or insert this directly into your project scaffold?




