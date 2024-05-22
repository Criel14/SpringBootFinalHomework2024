package cn.scnu.springbootfinalhomework2024.service;

import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.mapper.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    @Autowired
    UserMapper userMapper;

    public User confirmLogin(User user) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("phone_number", user.getPhoneNumber());
        queryWrapper.eq("password", user.getPassword());
        List<User> userList = userMapper.selectList(queryWrapper);
        return userList.size() == 0 ? null : userList.get(0);
    }

    public String register(User user) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("phone_number", user.getPhoneNumber());
        List<User> UserList = userMapper.selectList(queryWrapper);
        if(UserList.size() == 0){
            userMapper.insert(user);
            return "注册成功";
        }
        else{
            return "该手机号已被注册";
        }
    }
}
