#a minimal Java 21 runtime-only image (no compiler, no Maven) — small and fast to pull.
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app
COPY target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]