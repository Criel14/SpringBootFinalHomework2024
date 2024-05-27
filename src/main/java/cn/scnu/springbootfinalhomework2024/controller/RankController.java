package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

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
        List<Movie> response = new ArrayList<>();
        if (Objects.equals(query, "score")) {
            response = movieService.getMoviesSortedByScore();
        } else if (Objects.equals(query, "all")) {
            response = movieService.findAllMovie();
        } else {
            // 周榜和月榜还没做
            int day = 0;
            if(Objects.equals(query, "week")) day = 7;
            else if (Objects.equals(query, "month")) day =30;
            else day = Integer.MAX_VALUE;
            response = movieService.showMovieByCountPlay(day);
        }

        return response;
    }

}
