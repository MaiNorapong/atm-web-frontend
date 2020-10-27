# build
FROM maven
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn -B dependency:resolve dependency:resolve-plugins
COPY src src
RUN mvn package

# run
FROM openjdk:8-slim
COPY --from=0 /usr/src/app/target/*.jar ./

EXPOSE 8090
CMD java -jar atm-0.0.1-SNAPSHOT.jar
