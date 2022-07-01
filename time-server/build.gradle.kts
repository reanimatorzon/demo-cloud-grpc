plugins {
    id("kotlin-and-spring")
    id("jib")
}

group = "com.example"
version = "0.0.2-SNAPSHOT"

jib.to.image = "time-server:$version"
