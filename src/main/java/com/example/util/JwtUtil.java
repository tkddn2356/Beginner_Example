package com.example.util;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtUtil {


    @Value("${JWT_SECRET_KEY}")
    private String myKey;

    private Key key;

    public String generate(Long id) { // TOKEN 생성
        key = Keys.hmacShaKeyFor((myKey+myKey).getBytes());
        //FIX 정수현 ::  token은 로그인한 아이디보단 id키 값이 더 좋을 것 같습니다.
        // header
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");

        // payload
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("sub", "accessToken");
        payloads.put("id", id);
        payloads.put("exp", DateUtil.addHoursToJavaUtilDate(new Date(), 24));

        // Generate token
        String token = Jwts.builder()
                .setHeader(headers)
                .setClaims(payloads)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
        return token;
    }

    public boolean isExpired(String header){ // TOKEN VALID CHECK
        String authToken = header.substring(7); // "Bearer " 제거
        Claims claims  = Jwts.parser().setSigningKey(this.key).parseClaimsJws(authToken).getBody();
        Date exp = claims .get("exp", Date.class);
        Date now = new Date();
        if( exp.getTime() < now.getTime()){
            return true;
        }
        else
            return false;
    }

    //token에서 id를 추출하는 method :: 정수현
    public Long getTokenById(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); // request 추출
        String header = request.getHeader("Authorization"); // header추출
        String authToken = header.substring(7); // "Bearer " 제거
        String[] strings = authToken.split("\\.");
        Map<String,Object> payloads = null;
        try {
            payloads = new ObjectMapper().readValue(new String(Base64.decodeBase64(strings[1])), Map.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        Long id = Long.valueOf(String.valueOf( payloads.get("id")));
        return id;
//        payload부분은 서명으로 푸는것이 아닌 decoding으로 하면 된다.
//        https://m.blog.naver.com/PostView.nhn?blogId=ithink3366&logNo=221371733904&proxyReferer=https:%2F%2Fwww.google.com%2F
    }
    //FIX 정수현 :: DELETE DATABASE LOGIC TO ACCESS TOKEN
    //          :: UserMapper 접근 로직
}
