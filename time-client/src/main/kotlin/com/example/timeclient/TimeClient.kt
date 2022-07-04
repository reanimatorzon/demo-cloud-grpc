package com.example.timeclient

import io.grpc.ManagedChannel
import io.grpc.ManagedChannelBuilder
import io.grpc.examples.ClockGrpcKt
import io.grpc.examples.Hello
import kotlinx.coroutines.runBlocking
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

    private final val timeServerServiceHost: String = System.getenv("TIME_SERVER_SERVICE_HOST")
    val timeServerServicePortHttp: String = System.getenv("TIME_SERVER_SERVICE_PORT_HTTP")
    private final val timeServerServicePortGrpc: String = System.getenv("TIME_SERVER_SERVICE_PORT_GRPC")

    val managedChannel: ManagedChannel =
        ManagedChannelBuilder.forAddress(timeServerServiceHost, timeServerServicePortGrpc.toInt()).usePlaintext().build()

    @GetMapping("/beautifulTime")
    fun beautifulTime(): String? = RestTemplate().getForEntity(
        URI.create("http://$timeServerServiceHost:$timeServerServicePortHttp/currentTime"), String::class.java
    ).body + " BEAUTIFUL"

    @GetMapping("/beautifulTimeGrpc")
    fun beautifulTimeGrpc(): String? = runBlocking {
        ClockGrpcKt.ClockCoroutineStub(managedChannel).currentTime(
            Hello.CurrentTimeRequest.getDefaultInstance()
        ).ms + " BEAUTIFUL GRPC"
    }

}