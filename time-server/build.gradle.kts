plugins {
    id("grpc")
    id("jib")
}

group = "com.example"
version = "0.0.4-SNAPSHOT"

jib.to.image = "time-server:$version"

dependencies {
    implementation(project(":proto"))

    implementation("org.springframework.boot:spring-boot-starter-web")
}