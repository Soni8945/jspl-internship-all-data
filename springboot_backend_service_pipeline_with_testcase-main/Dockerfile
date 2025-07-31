# Use Maven image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests
RUN mvn test

# Use a lightweight JDK image to run the app
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/springprj-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8090

ENTRYPOINT ["java", "-jar", "app.jar"]
