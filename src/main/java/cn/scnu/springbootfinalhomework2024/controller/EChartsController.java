package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EChartsController {


    @Autowired
    MovieService movieService;
    //测试ECharts
    @RequestMapping("/testECharts")
    public String testECharts() {
        return "testECharts";
    }


    @RequestMapping("/movie-data")
    @ResponseBody
    public Map<String, Object> getMovieData(){
        List<Movie> movieList = movieService.findAllMovie();
        Map<String , Object> map = new HashMap<>();
        List<String> categoryList = new ArrayList<>(List.of("动作片","科幻片","动画片"));
        List<Integer> valueList = new ArrayList<>(List.of(0,0,0));
        for(Movie movie : movieList) {
            if (movie.getMovieType().equals("action")) valueList.set(0, valueList.get(0) + 1);
            else if (movie.getMovieType().equals("comedy")) valueList.set(1, valueList.get(1) + 1);
            else valueList.set(2, valueList.get(2) + 1);
        }
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("categories",categoryList);
        dataMap.put("values",valueList);
        System.out.println(dataMap);
        return dataMap;
    }
}
