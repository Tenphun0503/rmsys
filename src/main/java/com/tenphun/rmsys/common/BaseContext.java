package com.tenphun.rmsys.common;

/**
 * Tool class based on ThreadLocal to get and save user of the current session
 */
public class BaseContext {
    private BaseContext(){}

    private  static ThreadLocal<Long> threadLocal = new ThreadLocal<>();

    public static void setCurrentId(Long id){
        threadLocal.set(id);
    }

    public static Long getCurrentId(){
        return threadLocal.get();
    }
}
