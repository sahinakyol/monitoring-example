FROM maven:3.9-amazoncorretto-17 as builder

COPY ./pom.xml ./pom.xml

RUN mvn dependency:go-offline -B

COPY ./src ./src

RUN mvn package -DskipTests

FROM amazoncorretto:17-alpine

COPY --from=builder /target/monitoring-example-0.0.1-SNAPSHOT.jar /app/monitoring-example.jar

ENV JAVA_TOOL_OPTIONS_TEMP "-Dcom.sun.management.jmxremote \
                     -Dcom.sun.management.jmxremote.authenticate=false \
                     -Dcom.sun.management.jmxremote.ssl=false \
                     -Dcom.sun.management.jmxremote.local.only=false \
                     -Dcom.sun.management.jmxremote.port=9010 \
                     -Dcom.sun.management.jmxremote.rmi.port=9010 \
                     -Djava.rmi.server.hostname=127.0.0.1"

ENTRYPOINT ["java", "-jar", "-Xmx1G", "-Xms512M", "-XX:+UnlockDiagnosticVMOptions", "-XX:+DebugNonSafepoints", "/app/monitoring-example.jar"]