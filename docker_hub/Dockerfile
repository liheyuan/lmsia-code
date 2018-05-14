FROM anapsix/alpine-java:8_server-jre

WORKDIR /app

RUN mkdir -p /app/logs

ADD lmsia-abc-server.jar /app

CMD ["java", "-jar", "lmsia-abc-server.jar"]
