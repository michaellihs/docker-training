FROM maven:3.5.3-jdk-8 as build

WORKDIR /build
COPY . . 

RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests



FROM openjdk:8-jre-alpine

RUN adduser -Dh /home/gordon gordon

USER gordon

WORKDIR /app
COPY --from=build /build/target/ddev-0.0.1-SNAPSHOT.jar  app.jar

# This does not work:
# ENTRYPOINT "/usr/bin/java -jar /app/app.jar --spring.profiles.active=postgres"
ENTRYPOINT ["/usr/bin/java", "-jar", "/app/app.jar", "--spring.profiles.active=postgres"]
