package com.tenphun.rmsys.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public R<String> exceptionHandler(Exception e){
        log.error("[INFO] Unexpected exception occurred");
        log.error("[INFO] {}", e.getMessage());
        return R.error("System busy, try later");
    }

    @ExceptionHandler(BusinessException.class)
    public R<String> businessExceptionHandler(BusinessException e){
        log.error("[INFO] Business exception occurred");
        log.error("[INFO] {}", e.getMessage());
        return R.error(e.getMessage());
    }
}
