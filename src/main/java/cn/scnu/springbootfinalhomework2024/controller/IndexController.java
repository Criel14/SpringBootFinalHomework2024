package cn.scnu.springbootfinalhomework2024.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @RequestMapping("/index") //hjx是傻逼
    public String index() {
        return "index";
    }

}
