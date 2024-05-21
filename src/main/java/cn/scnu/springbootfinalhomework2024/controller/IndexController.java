package cn.scnu.springbootfinalhomework2024.controller;


import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @Autowired
    UserService userService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String login(User user, Model model) {
        System.out.println(user);
        User loginUser = userService.confirmLogin(user);
        if (loginUser != null) {
            model.addAttribute("user", loginUser);
        }
        return "index";
    }

    @RequestMapping("/register")
    public String register(User user, Model model) {
        String str = userService.register(user);
        if ("注册成功".equals(str)) {
            model.addAttribute("success", "注册成功");
        }
        return "index";
    }

}
