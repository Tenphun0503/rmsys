package com.tenphun.rmsys.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLIntegrityConstraintViolationException;

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

    /*
    // This method can replace the current ExceptionHandler
    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    public R<String> sqlExceptionHandler(SQLIntegrityConstraintViolationException e){
        if(e.getMessage().contains("Duplicate entry")){
            String[] split = e.getMessage().split(" ");
            String msg = split[2] + " already existed";
            return R.error(msg);
        }
        return R.error("Undefined Exception");
    }*/
}
