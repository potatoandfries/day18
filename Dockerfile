#Build Stage
FROM maven:3-eclipse-temurin-21 AS builder

LABEL MAINTAINER="BORI0001@e.ntu.edu.sg"
LABEL APPLICATION="Healthcheck Application"
#Working/target Directory
WORKDIR /usr/app

ARG APP_DIR=/app
WORKDIR ${APP_DIR}

# Copy all the required /app
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .

COPY src src
COPY .mvn .mvn
#Build the App
RUN mvn package -Dmaven.test.skip=true


#Publish Stage
FROM openjdk:21-jdk

ARG APP_DIR=/app
WORKDIR ${APP_DIR}

ENV PORT=8080
EXPOSE ${PORT}

COPY --from=builder /app/target/d18.lecture-0.0.1-SNAPSHOT.jar healthcheck.jar 
#first is where the app is stored* second is what is what it will be called as a container*

ENTRYPOINT SERVER_PORT=${PORT} java -jar healthcheck.jar

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD curl -s -f http://localhost:${PORT}/healthz || exit 1