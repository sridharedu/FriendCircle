## Project Overview

FriendCircle is a social platform backend that allows users to:

* Register and log in using a JWT-based authentication system.
* Manage their personal addresses (add, update, or delete).
* Connect with other users by sending and accepting friend requests.
* View information exclusive to friends, such as hobbies.
* Communicate with friends through a Kafka-based messaging system.
* Access their friend list and view message threads.
* Stay updated with notifications regarding friend-related events and new messages.

## Getting Started

This section guides you through setting up and running the FriendCircle project locally for development and testing.

### Prerequisites

Ensure you have the following software and tools installed on your system:

*   **Java 17:** The core programming language for the backend services.
*   **Maven:** Used for building the project and managing dependencies.
*   **Docker & Docker Compose:** For containerizing and orchestrating the services and infrastructure components.
*   **PostgreSQL:** The relational database used by several microservices.
*   **MongoDB:** The NoSQL database used by the `hobby-service`.
*   **Apache Kafka:** The messaging system for asynchronous communication.
*   **ELK Stack (Elasticsearch, Logstash, Kibana):** For centralized logging.
*   **Prometheus & Grafana:** For monitoring and metrics.
*   **Zipkin:** For distributed tracing.
*   **Git:** For version control and cloning the repository.

### Project Setup

1.  **Clone the Monorepo:**
    The FriendCircle project is structured as a monorepo. To get started, clone the repository to your local machine using Git:
    ```bash
    git clone <repository-url>
    cd friendcircle
    ```
    (Replace `<repository-url>` with the actual URL of the FriendCircle repository).

2.  **Understand Project Structure:**
    The monorepo has the following structure:
    ```
    friendcircle/
    │
    ├── common-lib/               # Shared DTOs, Kafka config, utils
    ├── config-service/           # Spring Cloud Config Server
    ├── discovery-service/        # Eureka Service Discovery
    ├── gateway-service/          # API Gateway
    │
    ├── user-service/             # Handles user registration, auth, profiles
    ├── address-service/          # Manages user addresses
    ├── friendship-service/       # Manages friend requests and relationships
    ├── hobby-service/            # Manages user hobbies (MongoDB)
    ├── message-service/          # Handles Kafka-based messaging
    ├── notification-service/     # Handles notifications from Kafka events
    │
    ├── docker-compose.yml        # Docker Compose setup for local development
    └── devfile.yaml              # Dev environment configuration (Devfile)
    ```

3.  **Configuration Management:**
    *   The `config-service` is a Spring Cloud Config server responsible for providing centralized configuration to all other microservices.
    *   It is backed by a Git repository. Configuration files for each service (e.g., `user-service.yml`, `application.yml`) are stored in this Git repository and served to the respective services upon startup.

4.  **Service Discovery:**
    *   The `discovery-service` uses Netflix Eureka. All other microservices are configured to register themselves with this Eureka server.
    *   This allows services to find and communicate with each other dynamically without hardcoding hostnames and ports.

### Running the Platform

Follow these steps to get the FriendCircle platform running locally. Some steps assume you are setting up the infrastructure manually, while others highlight the use of `docker-compose.yml` for a more automated setup.

1.  **Initialize Monorepo Structure (FRND-1):**
    This initial scaffolding (folder structure) is typically the very first step in project development. If you have cloned an existing repository, this structure should already be in place.

2.  **Setup Spring Cloud Config Server (FRND-2):**
    *   Navigate to the `config-service` directory.
    *   Run the service, typically using Spring Boot Maven plugin: `mvn spring-boot:run` or by building the JAR (`mvn clean install`) and then running `java -jar target/config-service.jar`.
    *   Ensure the Git backend for the config server is properly set up and accessible.

3.  **Setup Eureka Discovery Service (FRND-3):**
    *   Navigate to the `discovery-service` directory.
    *   Run the service: `mvn spring-boot:run` or build and run the JAR.
    *   This service should start up and provide a dashboard (usually at `http://localhost:8761`) where you can see registered services.

4.  **Setup API Gateway (FRND-4):**
    *   Navigate to the `gateway-service` directory.
    *   Run the service: `mvn spring-boot:run` or build and run the JAR.
    *   This service will act as the entry point for all API requests. It will route requests to other services and handle JWT validation.

5.  **Setup Kafka (FRND-19):**
    *   Apache Kafka is essential for messaging between services (`user-messages`, `friend-requests`, `notifications` topics).
    *   It's typically run using Docker. If not using the main `docker-compose.yml` for this, you might have a separate Docker Compose file for Kafka or run it manually. The `README.md` implies Kafka setup is part of the main `docker-compose.yml`.

6.  **Setup Databases (PostgreSQL & MongoDB):**
    *   PostgreSQL is required for `user-service`, `address-service`, and `friendship-service`.
    *   MongoDB is required for `hobby-service`.
    *   These databases also typically run in Docker containers and are included in the main `docker-compose.yml`.

7.  **Build and Run Microservices:**
    *   For each microservice (`user-service`, `address-service`, etc.):
        *   Navigate to its directory.
        *   Build the service using Maven: `mvn clean install`. This will create a JAR file in the `target` directory.
        *   Run the service: `java -jar target/<service-name>.jar` or `mvn spring-boot:run`.
        *   Upon startup, each service will connect to the Config Server to fetch its configuration and then register with the Eureka Discovery Service.

8.  **Using `docker-compose.yml` (FRND-31):**
    *   The `docker-compose.yml` file at the root of the monorepo is designed to simplify the local setup significantly. It orchestrates the deployment of all microservices, databases (PostgreSQL, MongoDB), Kafka, the ELK stack, Prometheus, and Grafana.
    *   To start the entire platform, navigate to the root directory of the monorepo and run:
        ```bash
        docker-compose up -d
        ```
    *   This command will download the necessary Docker images (if not already present) and start all the defined services in detached mode.
    *   To stop the services, use `docker-compose down`.

9.  **Accessing the Application:**
    *   Once all services are running (especially the `gateway-service`), the application can be accessed through the API Gateway.
    *   The base URL for API requests will typically be something like: `http://localhost:<gateway-port>/api/v1/...` (e.g., `http://localhost:8080/api/v1/...`, the gateway port is defined in its configuration).

### Development Environment (Devfile)

*   The project includes a `devfile.yaml`. This file is used to define and manage containerized development environments.
*   Tools that support Devfiles can use `devfile.yaml` to provide a consistent and reproducible development setup, including all necessary dependencies and tools, running inside containers.

## Key Learnings

This section highlights the core architectural concepts and technologies employed in the FriendCircle project, offering insights into a modern microservices-based application.

1.  **Microservices Architecture:**
    *   **Concept:** FriendCircle is built as a collection of small, focused, and independently deployable services. Each service handles a specific business capability.
    *   **Benefits:** This approach allows for better scalability (services can be scaled independently), resilience (failure in one service is less likely to affect others), and allows teams to work on different services concurrently. While microservices can support technology diversity, FriendCircle standardizes on Spring Boot and Java 17 for consistency.
    *   **Examples:** `user-service` for user management, `address-service` for addresses, `friendship-service` for social connections, `hobby-service` for user hobbies, `message-service` for messaging, and `notification-service` for user alerts.

2.  **Spring Boot & Java 17:**
    *   **Spring Boot:** It's a framework that significantly simplifies the development of production-grade Spring-based applications. It emphasizes convention over configuration.
    *   **Key Features Used:** Auto-configuration (sensible defaults), standalone deployment (services run as JARs with embedded servers like Tomcat or Netty), and simplified dependency management. The use of Spring Boot 3.2+ is specified.
    *   **Java 17:** The project uses Java 17, a Long-Term Support (LTS) version of Java, providing access to modern language features and performance improvements.

3.  **API Gateway (Spring Cloud Gateway):**
    *   **Purpose:** The `gateway-service` acts as the single entry point for all incoming client requests to the FriendCircle backend.
    *   **Functions:** It handles routing of requests to the appropriate downstream microservices. Crucially, it's responsible for JWT (JSON Web Token) validation, ensuring that requests are authenticated before reaching internal services. It can also perform other cross-cutting concerns like rate limiting or request/response transformation, though not explicitly detailed. It implicitly aids load balancing by routing to available service instances registered with Eureka.

4.  **Service Discovery (Eureka):**
    *   **Problem Solved:** In a microservices environment, service instances can have dynamic IP addresses and ports, especially when scaled or redeployed. Manually configuring these locations is impractical.
    *   **How it Works:** The `discovery-service` (using Netflix Eureka) provides a registry where each microservice instance registers itself upon startup. Other services (or the gateway) can then query Eureka to discover the current location (host and port) of a required service.
    *   **Role:** Enables dynamic communication between services without hardcoding locations.

5.  **Centralized Configuration (Spring Cloud Config):**
    *   **Problem Solved:** Managing configuration properties (e.g., database URLs, external API keys) for numerous microservices can be complex and error-prone if each service has its own local configuration files.
    *   **How it Works:** The `config-service` centralizes the management of these properties. In FriendCircle, it's backed by a Git repository, meaning configurations are version-controlled. Microservices connect to the Config Server on startup to fetch their respective configurations.
    *   **Benefits:** Ensures consistency across services, allows for easier management of configurations across different environments (dev, test, prod), and supports dynamic configuration updates (though the latter requires specific setup).

6.  **Asynchronous Communication (Apache Kafka):**
    *   **Purpose:** Used for decoupling services and managing event-driven communication. Instead of direct synchronous calls for all interactions, some events are published to Kafka and processed asynchronously. This improves resilience and responsiveness.
    *   **Key Kafka Concepts:**
        *   **Topics:** Named channels for messages (e.g., `friend-requests`, `user-messages`, `notifications` in FriendCircle).
        *   **Producers:** Services that publish messages to Kafka topics.
        *   **Consumers:** Services that subscribe to Kafka topics to process messages.
    *   **Services Involved:** `message-service` consumes from `user-messages` and likely produces to it (or another topic for message persistence/events). `notification-service` consumes from `friend-requests` and `user-messages` to generate notifications. Other services produce events to these topics (e.g., `friendship-service` might produce to `friend-requests`).

7.  **Security (Spring Security + JWT):**
    *   **Authentication:** User login is handled by the `user-service`, which issues a JWT upon successful authentication. This token is then sent by the client with subsequent requests.
    *   **Authorization & Validation:** The `gateway-service` is responsible for validating the JWT on incoming requests. If valid, it can extract user information (like `userId` and roles) and pass it as headers to downstream services. These services can then use this information to enforce authorization rules (e.g., ensuring a user can only access their own data).

8.  **Database Technologies:**
    *   **PostgreSQL:** A powerful open-source relational database. In FriendCircle, it's used for services requiring structured data and ACID compliance, such as `user-service` (user profiles, credentials), `address-service` (user addresses), and `friendship-service` (friendship statuses and relationships).
    *   **MongoDB:** An open-source NoSQL document database. It's used by the `hobby-service` to store user hobbies. Document databases are often chosen for their flexibility in handling unstructured or semi-structured data and for ease of scalability for certain use cases.
    *   **Rationale:** The choice reflects a polyglot persistence approach, using the database best suited for the data's nature and access patterns (structured relational data vs. flexible schema for hobbies).

9.  **Containerization (Docker & Docker Compose):**
    *   **Docker:** Each microservice is intended to be packaged as a Docker container. This ensures that the service and its dependencies are bundled together, providing consistency from development to production environments. Dockerfiles for each service (`FRND-30`) define how these images are built.
    *   **Docker Compose:** The `docker-compose.yml` file (`FRND-31`) is used to define and run the multi-container FriendCircle application locally. It orchestrates the startup of all microservices, databases (PostgreSQL, MongoDB), Kafka, and the observability stack (ELK, Prometheus, Grafana, Zipkin), making local development and testing much simpler.

10. **Observability:**
    A crucial aspect of managing microservices, providing insights into the system's health and behavior.
    *   **Logging (ELK Stack):** Services are configured for JSON-structured logging (via Logback, `FRND-28`). These logs are collected by Logstash, stored in Elasticsearch, and visualized in Kibana (`FRND-29`). This allows for centralized log analysis and troubleshooting.
    *   **Metrics (Prometheus & Grafana):** Each service exposes metrics via Spring Boot Actuator endpoints (`/actuator/metrics`, `FRND-25`). Prometheus scrapes these metrics, and Grafana is used to create dashboards for visualizing them (`FRND-26`), helping to monitor performance and system health.
    *   **Tracing (Spring Cloud Sleuth & Zipkin):** Spring Cloud Sleuth adds trace and span IDs to logs. These are exported to Zipkin (`FRND-27`), which provides a visual representation of how requests flow through the distributed system, helping to identify bottlenecks and understand service dependencies.

11. **REST APIs & Feign Clients:**
    *   **REST APIs:** Services expose their functionalities via RESTful APIs (Representational State Transfer). This is the standard for synchronous communication in FriendCircle, with APIs versioned (e.g., `/api/v1/`).
    *   **Feign Clients:** To simplify making HTTP requests from one service to another, Spring Cloud OpenFeign is used. Feign allows developers to define declarative REST clients using interfaces, reducing boilerplate code for service-to-service calls.

12. **DevOps & GitOps:**
    *   **`devfile.yaml`:** This file supports standardized, container-based development environments. It helps ensure consistency in development setups across different machines or for new developers.
    *   **GitOps:** The use of a Git-backed repository for the `config-service` is a GitOps principle. Configuration is treated as code—versioned, auditable, and managed through Git workflows.

## Do's and Don'ts

This section provides general advice and best practices based on the FriendCircle project's design and common microservice principles.

### Do's
*   **Maintain Service Independence:** Ensure each microservice (`user-service`, `address-service`, etc.) is fully isolated and can be deployed, scaled, and updated independently of others. This is a core principle from the "Architecture Constraints."
*   **Use Asynchronous Communication for Events:** Leverage Apache Kafka for all user-to-user messages and friend events (e.g., sending friend requests, new messages). This decouples services, improves resilience, and aligns with the "Architecture Constraints" and defined Kafka topics (`friend-requests`, `user-messages`).
*   **Centralize Configuration:** Always use the `config-service` (Spring Cloud Config) to manage and distribute configuration properties to all microservices. This ensures consistency and manageability.
*   **Register with Service Discovery:** All microservices must register with the `discovery-service` (Eureka) upon startup. This allows services to locate each other dynamically.
*   **Secure Services:** Implement JWT-based authentication for all services (except `config-service` and `discovery-service`). Ensure the `gateway-service` validates JWTs and forwards necessary user context (like `userId` and roles) as headers.
*   **Implement Comprehensive Logging:** Adhere to the requirement for JSON-structured logging. This format is essential for effective aggregation and analysis in the ELK Stack (Logstash, Elasticsearch, Kibana).
*   **Expose Health and Metrics:** All services must expose Spring Boot Actuator endpoints like `/actuator/health` and `/actuator/metrics`. These should be scraped by Prometheus for monitoring with Grafana.
*   **Use Docker for Consistent Environments:** Utilize Docker to containerize each service and `docker-compose.yml` to orchestrate the entire platform locally. This promotes consistency between development and production.
*   **Define Clear API Contracts:** Design RESTful APIs with versioning (e.g., `/api/v1/`) and implement clear, consistent error handling mechanisms.
*   **Utilize `common-lib` for Shared Code:** Place shared Data Transfer Objects (DTOs), Kafka configurations, and common utility classes in the `common-lib` module to avoid code duplication and maintain consistency across services.
*   **Follow Defined Tech Stack:** Strictly adhere to the technologies specified in the "Tech Stack (Strict and Final)" section of the `README.md` (Java 17, Spring Boot 3.2+, PostgreSQL, MongoDB, Kafka, etc.) to ensure project consistency and leverage collective expertise.
*   **Write Unit and Integration Tests:** Although not explicitly detailed for every JIRA ticket, thorough testing (unit tests for individual components and integration tests for service interactions) is crucial for building a production-grade system.
*   **Keep Services Focused:** Ensure each microservice has a well-defined, single responsibility aligned with its domain (e.g., `user-service` handles all aspects of users, `hobby-service` exclusively manages hobbies).

### Don'ts
*   **Avoid Synchronous Calls for Non-Critical Paths:** Do not use synchronous REST calls (even with Feign) for operations that can be handled asynchronously. For example, if a service emits an event that another service consumes, Kafka is preferred over a direct REST call if an immediate response isn't required by the caller. This improves resilience against temporary service unavailability.
*   **Don't Embed Configuration:** Never hardcode configuration values (like database credentials, queue names, or external URLs) directly within the microservices. Always retrieve them from the `config-service`.
*   **Don't Bypass the API Gateway:** External clients or end-users must not call individual microservices directly. All incoming traffic should be routed through the `gateway-service` to enforce security policies and centralize request handling.
*   **Avoid Tight Coupling Between Services:** Services should interact only through their well-defined APIs (REST or Kafka messages). Avoid direct database sharing between services, as this creates tight coupling and makes independent evolution difficult. (The `hobby-service` with MongoDB is a specific, isolated use case).
*   **Don't Neglect Security:** Do not take shortcuts with security. Ensure JWTs are correctly implemented, validated, and transmitted securely (e.g., over HTTPS). Be mindful of protecting sensitive data both in transit and at rest.
*   **Don't Let `common-lib` Become a Monolith:** While `common-lib` is useful for genuinely shared code like DTOs and static utils, avoid placing business logic or components that tie services too closely together within it. This can inadvertently lead to a distributed monolith.
*   **Don't Mix Kafka and REST for the Same Logical Flow (if avoidable):** The `README.md` clearly states that "All user-to-user messages and friend events must flow via Kafka only." Adhere to this for the specified flows to maintain clarity and the benefits of asynchronous processing.
*   **Don't Forget About Observability:** Do not treat logging, metrics, and tracing as afterthoughts. Implement them from the start as they are critical for debugging, monitoring, and understanding the behavior of a distributed microservices system.
*   **Don't Introduce New Technologies Randomly:** The project has a "Tech Stack (Strict and Final)." Avoid introducing alternative databases, messaging systems, or frameworks without strong justification and formal agreement, as this can increase complexity and operational overhead.

## Future Enhancements

This section outlines potential ways the FriendCircle platform could be extended with new features and technical improvements.

1.  **Advanced User Profiles:**
    *   Allow users to enrich their profiles with details such as profile pictures, biographical summaries, a broader range of interests beyond hobbies, and links to their other social media presences.
    *   Implement a user status indicator (e.g., online, offline, away, do not disturb).

2.  **Content Sharing:**
    *   Introduce functionality for users to create and share various types of content, such as text posts, images, or videos, either with their friend circle or publicly.
    *   This might necessitate new microservices like a `post-service` to manage textual content and a `media-service` for handling uploads and storage of images/videos.

3.  **Groups/Communities:**
    *   Enable users to form or join groups centered around shared interests, hobbies, or affiliations.
    *   Provide features for group-specific messaging, content sharing, and membership management.

4.  **Real-time Notifications:**
    *   While Kafka is used for asynchronous event notifications, the `notification-service` could be enhanced to deliver these notifications to clients in real-time.
    *   Technologies like WebSockets or Server-Sent Events (SSE) could be integrated to push updates instantly to active user sessions.

5.  **Enhanced Search Functionality:**
    *   Develop a comprehensive search capability allowing users to find other users, specific content posts, or groups within the platform.
    *   For advanced search features (e.g., full-text search, faceted search), integrating a dedicated search engine like Elasticsearch could be beneficial.

6.  **Improved Security Measures:**
    *   **Two-Factor Authentication (2FA):** Add an extra layer of security for user logins.
    *   **OAuth2 Integration:** Allow users to register/login via third-party identity providers or grant access to their FriendCircle data to trusted external applications.
    *   **API Rate Limiting:** Implement rate limiting at the API Gateway or individual service level to prevent abuse and ensure fair usage.
    *   **Granular Permissions:** Develop a more fine-grained access control system if certain user roles or content types require specific permissions.

7.  **Scalability and Performance Optimizations:**
    *   **Advanced Caching:** Expand the use of caching (e.g., with Redis) for frequently accessed data like user profiles, friend lists, or popular content to reduce database load and improve response times.
    *   **Database Scaling:** For services experiencing high data volume or traffic, explore database replication for read scalability and sharding for distributing data across multiple database instances.
    *   **Kafka Consumer Scaling:** Optimize Kafka consumer group configurations and partitioning strategies to ensure efficient message processing as the load increases.

8.  **Full-fledged CI/CD Pipeline:**
    *   Establish a complete Continuous Integration/Continuous Deployment (CI/CD) pipeline to automate the build, testing (unit, integration, contract), and deployment processes for all microservices.
    *   Integrate with CI/CD tools such as Jenkins, GitLab CI, GitHub Actions, or similar platforms.

9.  **User Analytics:**
    *   Implement tracking and analysis of user behavior and platform engagement (e.g., active users, popular features, content trends).
    *   This might involve a new `analytics-service` to collect, process, and store analytics data, potentially integrating with data visualization tools.

10. **Gamification:**
    *   Introduce elements like points, badges, achievements, or leaderboards to incentivize user interaction, content contribution, and community engagement.

11. **Internationalization (i18n) and Localization (l10n):**
    *   Adapt the platform to support multiple languages and regional preferences, including UI text, date/time formats, and cultural conventions.

12. **Data Archival and Deletion Policies:**
    *   Define and implement strategies for managing the lifecycle of user-generated data, especially for messages, notifications, and old content. This includes policies for data archival (moving older, less accessed data to cheaper storage) and secure deletion.
    *   Ensure compliance with data privacy regulations like GDPR, including processes for handling user data deletion requests.

13. **A/B Testing Framework:**
    *   Integrate a framework that allows for A/B testing or canary releasing of new features to a small subset of users before a full-scale rollout. This helps in gathering feedback and making data-driven decisions.
