FROM alpine:3.15

RUN set -ex && \
    apk add --no-cache --no-progress openjdk11-jre-headless wget && \
    apk del wget
    
RUN ./gradlew assemble

ENTRYPOINT ["java", "-Xms512m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

ADD target/tracker-server.jar tracker-server.jar
ADD conf/traccar.xml traccar.xml

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
