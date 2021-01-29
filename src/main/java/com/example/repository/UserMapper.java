package com.example.repository;

import com.example.domain.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    public int createUser(User user);
    public User getUserByAccountId(String account_id);
    public User getUserById(Long id);
    public String getNicknameById(Long id);

}
