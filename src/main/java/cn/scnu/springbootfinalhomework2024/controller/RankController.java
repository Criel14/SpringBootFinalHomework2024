package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
public class RankController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private RedisTemplate redisTemplate;


    @RequestMapping("/rank")
    public String rank(HttpSession httpSession, Model model) {
        if(redisTemplate.opsForValue().get("user") != null)
        {
            model.addAttribute("user", redisTemplate.opsForValue().get("user"));
        }
        return "rank";
    }

    // 前端点击榜单，后端返回排好序的电影列表
    @RequestMapping("/rank/movieList")
    @ResponseBody
    public List<Movie> selectMovie(@RequestParam("query") String query) {
        System.out.println(query);
        List<Movie> response = new ArrayList<>();
        if (Objects.equals(query, "score")) {
            response = movieService.getMoviesSortedByScore();
        } else if (Objects.equals(query, "all")) {
            response = movieService.findAllMovie();
        } else {
            response = movieService.showMovieByCountPlay(getDayBasedOnQuery(query));
        }
        return response;
    }

    // 根据query返回天数
    private int getDayBasedOnQuery(String query) {
        int day;
        if (Objects.equals(query, "week")) {
            day = 7;
        } else if (Objects.equals(query, "month")) {
            day = 30;
        } else {
            day = Integer.MAX_VALUE;
        }
        return day;
    }

}
