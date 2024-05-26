package cn.scnu.springbootfinalhomework2024.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExcelController {

    @RequestMapping("/testExcel")
    public String testExcel() {
        return "testExcel";
    }
}
