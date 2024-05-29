package cn.scnu.springbootfinalhomework2024.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

@Data
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId("user_id")
    private int userId;
    private String username;
    private String password;
    private String phoneNumber;
    private String image;
    private int isVip;
}
