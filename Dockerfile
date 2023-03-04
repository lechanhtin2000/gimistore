#
# Build stage
#
FROM maven:3.9.0-amazoncorretto-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:17-ea-slim
COPY --from=build /home/app/target/gimistore-0.0.1-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8099
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]