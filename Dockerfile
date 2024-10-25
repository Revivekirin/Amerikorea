FROM openjdk:17-jdk-slim
LABEL authors="kimjihe"

WORKDIR /app

COPY build/libs/*.jar app.jar
COPY build/resources/main/ /app/resources/
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 8080

ENTRYPOINT ["wait-for-it.sh", "mysql:3306", "--", "java", "-jar", "app.jar"]
