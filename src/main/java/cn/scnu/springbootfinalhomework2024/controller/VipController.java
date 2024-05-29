package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class VipController {
    @Autowired
    UserService userService;

    //vip页面
    @RequestMapping("/vip")
    public String vip() {
        return "vip";
    }

    @RequestMapping("/isVip")
    @ResponseBody
    public Boolean isVip(HttpSession httpSession) {
        User loginedUser = new User();
        loginedUser = (User) httpSession.getAttribute("user");
        System.out.println(loginedUser);
        return loginedUser != null && loginedUser.getIsVip() == 1;
    }

    @RequestMapping("/paySuccess")
    @ResponseBody
    public Boolean paySuccess(HttpSession httpSession) {
        User loginedUser = new User();
        loginedUser = (User) httpSession.getAttribute("user");
        loginedUser.setIsVip(1);
        httpSession.removeAttribute("user");
        httpSession.setAttribute("user", loginedUser);
        return true;
    }
}
