FROM java:8-jre
MAINTAINER JamesYe yeyalin@seaeverit.com

COPY target/config-service.jar  config-service.jar

CMD ["java", "-Xmx100m", "-jar", "config-service.jar"]

HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://config-service:9999/actuator/health|| exit 1

EXPOSE 9999
