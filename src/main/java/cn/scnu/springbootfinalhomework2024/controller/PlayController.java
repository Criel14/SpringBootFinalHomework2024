package cn.scnu.springbootfinalhomework2024.controller;


import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class PlayController {

    @Autowired
    private MovieService movieService;
    @Autowired
    private RedisTemplate redisTemplate;

    @RequestMapping("/moviePlay")
    public String moviePlay() {
        return "moviePlay";
    }

    @RequestMapping("/moviePlay/movieInfo")
    @ResponseBody
    public Map<String, Object> moviePlayInfo(@RequestParam("movieId") Integer movieId) {
        Map<String , Object> response = new HashMap<>();

        User user = (User) redisTemplate.opsForValue().get("user");
        if(user != null) {
            System.out.println("user: " + user);
            movieService.InsertMovieHistory(user.getUserId(), movieId);
        }

        response.put("resMovie", movieService.findMovieById(movieId));
        response.put("resUser", redisTemplate.opsForValue().get("user"));
        response.put("resDirectors", movieService.getDirectorsById(movieId));
        response.put("resActors", movieService.getActorsById(movieId));
        // 将电影返回给前端
        return response;
    }
}

