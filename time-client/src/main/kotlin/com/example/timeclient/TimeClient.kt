package com.example.timeclient

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.client.RestTemplate
import java.net.URI

@SpringBootApplication
class TimeClient

fun main(args: Array<String>) {
    runApplication<TimeClient>(*args)
}

@RestController
class BeautifulTime {

    val timeServerServiceHost: String = System.getenv("TIME_SERVER_SERVICE_HOST")
    val timeServerServicePort: String = System.getenv("TIME_SERVER_SERVICE_PORT")

    @GetMapping("/beautifulTime")
    fun beautifulTime(): String? = RestTemplate().getForEntity(
        URI.create("http://$timeServerServiceHost:$timeServerServicePort/currentTime"),
        String::class.java
    ).body + " BEAUTIFUL"

}