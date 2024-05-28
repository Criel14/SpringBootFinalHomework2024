package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class VipController {

    //vip页面
    @RequestMapping("/vip")
    public String vip() {
        return "vip";
    }

    @RequestMapping("/isVip")
    @ResponseBody
    public Boolean isVip(HttpSession httpSession) {
        User loginedUser = new User();
        return loginedUser.getIsVip() == 1;
    }
}
