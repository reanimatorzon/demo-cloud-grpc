package com.example.timeserver

import io.grpc.examples.*
import org.lognet.springboot.grpc.GRpcService
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import java.time.Instant
import java.time.LocalDateTime
import java.util.*

@SpringBootApplication
class TimeServer

fun main(args: Array<String>) {
    runApplication<TimeServer>(*args)
}

@RestController
class CurrentTime {

    @GetMapping("/currentTime")
    fun currentTime(): LocalDateTime = LocalDateTime.ofInstant(
        Instant.ofEpochMilli(
            System.currentTimeMillis()
        ),
        TimeZone.getDefault().toZoneId()
    )

}

@GRpcService
class TimeGrpc: ClockGrpcKt.ClockCoroutineImplBase() {

    override suspend fun currentTime(request: Hello.CurrentTimeRequest): Hello.CurrentTimeResponse =
        Hello.CurrentTimeResponse.newBuilder()
            .setMs(System.currentTimeMillis().toString())
            .build()
}