package cn.scnu.springbootfinalhomework2024.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PlayController {

    @RequestMapping("/moviePlay")
    public String moviePlay(Integer id) {
        return "moviePlay";
    }
}
