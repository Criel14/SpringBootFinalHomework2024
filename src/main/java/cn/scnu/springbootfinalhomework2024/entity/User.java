package cn.scnu.springbootfinalhomework2024.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

@Data
public class User {
    private int userId;
    private String username;
    private String password;
    private String phoneNumber;
    private String image;
    private int isVip;
}
