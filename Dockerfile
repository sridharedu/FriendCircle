# Dockerfile for FriendCircle Config Service
FROM openjdk:17-jdk-slim
VOLUME /tmp
EXPOSE 8888
WORKDIR /opt/app
COPY target/config-service-0.0.1-SNAPSHOT.jar app.jar
COPY config-repo ./config-repo
ENTRYPOINT ["java", "-jar", "app.jar"]
