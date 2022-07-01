plugins {
    `java-gradle-plugin`
    `kotlin-dsl`
}

dependencies {
    implementation("gradle.plugin.com.google.cloud.tools:jib-gradle-plugin:3.2.1")

    implementation("org.springframework.boot:spring-boot-gradle-plugin:2.7.0")
    implementation("io.spring.gradle:dependency-management-plugin:1.0.11.RELEASE")
    implementation("org.jetbrains.kotlin:kotlin-gradle-plugin:1.6.21")
    implementation("org.jetbrains.kotlin:kotlin-allopen:1.6.21")
}

repositories {
    mavenCentral()
    gradlePluginPortal()
}
