package com.example.interceptor;

import com.example.domain.User;
import com.example.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("Authorization");
        if ( token == null || ("".equals(token) && token.isEmpty()) ) { // 토큰이 없는경우
            throw new Exception();
        }
        if ( token.length() < 10 ){
            throw new Exception();
        }

        else if  (!token.startsWith("Bearer ")){ // 토큰이 Bearer 인증타입을 지키지않고 전송이 될때
            throw new Exception();
        }
        else { //FIX 정수현 :: header Authorization을 가지고 있는 경우 valid를 체크한다.
            if ( jwtUtil.isExpired(token) ) {
                throw new Exception();
            }
            return true;
        }
    }
}
