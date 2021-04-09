FROM ubuntu:18.04

# copy test files over to ensure deploy worked
RUN mkdir -p /opt/test/src/main/java/org/gradle/example/simple/
COPY HelloWorld.java /opt/test/src/main/java/org/gradle/example/simple/HelloWorld.java
COPY build.gradle /opt/test/build.gradle

# install java components
RUN apt-get update
RUN apt-get -y install openjdk-11-jdk
RUN apt-get -y install openjdk-11-jre
RUN apt-get -y install gradle
ENV JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64/"

# install C components
RUN apt-get -y install gcc g++ vim

# run a test build
WORKDIR /opt/test/
RUN gradle build
RUN java -version
RUN java -cp build/classes/java/main/ org.gradle.example.simple.HelloWorld
