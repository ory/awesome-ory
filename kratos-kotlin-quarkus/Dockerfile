FROM maven:3.9.16-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml .
COPY src src
RUN --mount=type=cache,target=/root/.m2 mvn -B -q package -DskipTests

FROM eclipse-temurin:21.0.13_9-jre
WORKDIR /app
COPY --from=build /src/target/quarkus-app/ ./
EXPOSE 8080
USER 1001
CMD ["java", "-jar", "quarkus-run.jar"]
