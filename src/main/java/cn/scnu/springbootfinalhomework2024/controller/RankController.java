package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RankController {

    @Autowired
    private MovieService movieService;

    @RequestMapping("/rank")
    public String rank() {
        return "rank";
    }

    // 前端点击榜单，后端返回排好序的电影列表
    @RequestMapping("/rank/movieList")
    @ResponseBody
    public List<Movie> selectMovie(@RequestParam("query") String query) {
        System.out.println(query);

        // 先找全部测试一下
        List<Movie> response = movieService.findAllMovie();
        return response;
    }

}
