package com.example.service;

import com.example.domain.User;

import java.util.Map;

public interface UserService {

    public String login(User user);
    public boolean register(User user);

}