package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

@Data
public class User {
    private int user_id;
    private String username;
    private String password;
    private int is_vip;
}
