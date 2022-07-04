plugins {
    id("grpc")
    id("jib")
}

group = "com.example"
version = "0.0.4-SNAPSHOT"

jib.to.image = "time-client:$version"

dependencies {
    implementation(project(":proto"))
    implementation("io.grpc:grpc-netty:1.47.0")

    implementation("org.springframework.boot:spring-boot-starter-web")
}