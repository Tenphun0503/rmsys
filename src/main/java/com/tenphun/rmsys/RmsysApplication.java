package com.tenphun.rmsys;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@Slf4j
@SpringBootApplication
@ServletComponentScan
public class RmsysApplication {
    public static void main(String[] args) {
        SpringApplication.run(RmsysApplication.class, args);
        log.info("[INFO] System started successfully...");
    }
}
