FROM tomcat:9.0-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY target/SmartCampusNavigation-1.0.war /usr/local/tomcat/webapps/SmartCampusNavigation.war

EXPOSE 8080

CMD ["catalina.sh", "run"]