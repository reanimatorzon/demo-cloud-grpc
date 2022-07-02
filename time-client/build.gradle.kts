plugins {
    id("kotlin.and.spring")
    id("jib")
}

group = "com.example"
version = "0.0.3-SNAPSHOT"

jib.to.image = "time-client:$version"
