package com.tenphun.rmsys.filter;

import com.alibaba.fastjson2.JSON;
import com.tenphun.rmsys.common.BaseContext;
import com.tenphun.rmsys.common.R;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.AntPathMatcher;

import java.io.IOException;

@Slf4j
@WebFilter(filterName = "loginCheckFilter", urlPatterns = "/*")
public class LoginCheckFilter implements Filter {
    public static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();
    // Define uri ignored
    private final String[] uris = new String[]{
            "/employee/login",
            "/employee/logout",
            "/backend/**",
            "/front/**",
    };

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        // 1. get request uri
        String requestURI = request.getRequestURI();

        // 2. determine if uri in the ignored list
        // if not, let it go
        if(check(requestURI)){
            log.info("[INFO] Request {} was ignored", requestURI);
            filterChain.doFilter(request, response);
            return;
        }

        // 2. determine login status
        // if not null, let it go
        Long empId = (Long) request.getSession().getAttribute("employee");
        if(empId!=null){
            log.info("[INFO] Request {} passed login status check", requestURI);
            log.info("[INFO] User Login, user id: {}", empId);
            BaseContext.setCurrentId(empId);
            filterChain.doFilter(request, response);
            return;
        }

        // 4. return no login
        log.info("[INFO] Request {} was refused", requestURI);
        response.getWriter().write(JSON.toJSONString(R.error("NOTLOGIN")));
    }

    public boolean check(String requestURI){
        for (String uri : uris) {
            boolean match = PATH_MATCHER.match(uri, requestURI);
            if(match) return true;
        }
        return false;
    }
}
