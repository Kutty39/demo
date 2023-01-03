#
# Build stage
#
FROM maven:3.5-jdk-8 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package -Dmaven.test.skip

#
# Package stage
#
FROM azul/zulu-openjdk-alpine:8
COPY --from=build /usr/src/app/target/demo-0.0.1-SNAPSHOT.jar app.jar
VOLUME /tmp
EXPOSE 8080
ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
