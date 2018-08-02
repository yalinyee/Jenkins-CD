FROM java:8-jre
MAINTAINER JamesYe yeyalin@seaeverit.com

COPY target/discovery-service.jar  discovery-service.jar

CMD ["java", "-Xmx100m", "-jar", "discovery-service.jar"]

HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://discovery-service:8061/actuator/health || exit 1

EXPOSE 8061
