FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY Src ./Src
COPY WebContent ./WebContent

RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=build /app/target/SmartCampusNavigation-1.0.war \
    /usr/local/tomcat/webapps/SmartCampusNavigation.war

EXPOSE 8080

CMD ["catalina.sh", "run"]