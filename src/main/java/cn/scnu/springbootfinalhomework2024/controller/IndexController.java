package cn.scnu.springbootfinalhomework2024.controller;


import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    UserService userService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String login(User user, Model model){
        System.out.println(user);
        User LoginUser = userService.ConFirmLogin(user);
        if(LoginUser == null) return "index";
        else{
            model.addAttribute("user",LoginUser);
            return "index";
        }
    }

    @RequestMapping("/register")
    public String register(User user,Model model){
        String str = userService.register(user);
        if(str == "注册成功"){
            model.addAttribute("success","注册成功");
        }
        return "index";
    }

}
