package com.example.service;

import com.example.domain.User;
import com.example.repository.UserMapper;
import com.example.util.JwtUtil;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;


    @Autowired
    private JwtUtil jwtUtil;


    @Override
    public boolean register(User user) {
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        return userMapper.createUser(user) == 1;
    }

    @Override
    public Map<String, Object> login(User user) {
        User selectUser = userMapper.getUserByAccountId(user.getAccount_id()); // 받아온 매개변수 user의 id로 User를 가져옴
        if (selectUser != null && BCrypt.checkpw(user.getPassword(), selectUser.getPassword())) { // 비밀번호 검사
            //비밀번호 검사를 통과할 경우 token을 반환해줌
            String token = jwtUtil.generate(selectUser.getId());
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("userId", user.getAccount_id());
            map.put("token",token);
            return map; //Map에 유저아이디와 token을 담아서 반환. token만 보내도 상관은 없음.
        }
        else
            return null;
    }

}