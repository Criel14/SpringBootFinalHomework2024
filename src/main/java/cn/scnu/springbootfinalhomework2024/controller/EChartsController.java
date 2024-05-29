package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.MoviePlayback;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class EChartsController {


    @Autowired
    MovieService movieService;
    //测试ECharts
    @RequestMapping("/testECharts")
    public String testECharts() {
        return "testECharts";
    }

    // 生成index的电影类型的柱状图
    @RequestMapping("/showMovieTypeChart")
    @ResponseBody
    public Map<String, Object> getMovieTypeChart(){
        List<Movie> movieList = movieService.findAllMovie();
        List<String> categoryList = new ArrayList<>(List.of("动作片","科幻片","动画片"));
        List<Integer> valueList = new ArrayList<>(List.of(0,0,0));
        for(Movie movie : movieList) {
            if (movie.getMovieType().equals("action")) valueList.set(0, valueList.get(0) + 1);
            else if (movie.getMovieType().equals("comedy")) valueList.set(1, valueList.get(1) + 1);
            else valueList.set(2, valueList.get(2) + 1);
        }
        Map<String,Object> dataMap = getOption("电影类型表格","电影数量",categoryList,valueList,"bar");
        return dataMap;
    }

    // 生成index的电影地区的饼状图
    @RequestMapping("/showMovieRegionChart")
    @ResponseBody
    public Map<String, Object> getMovieRegionChart(){
        List<Movie> movieList = movieService.findAllMovie();
        List<String> categoryList = new ArrayList<>();
        List<Integer> valueList = new ArrayList<>();
        for(Movie movie : movieList) {
            if (!categoryList.contains(movie.getMovieRegion())) {
                categoryList.add(movie.getMovieRegion());
                valueList.add(1);
            }else{
                valueList.set(categoryList.indexOf(movie.getMovieRegion()), valueList.get(categoryList.indexOf(movie.getMovieRegion())) + 1);
            }
        }
        List<Object> dataList = new ArrayList<>();
        for(int i = 0; i < categoryList.size(); i++) {
            Map<String,Object> dataMap = new HashMap<>();
            dataMap.put("name",categoryList.get(i));
            dataMap.put("value",valueList.get(i));
            dataList.add(dataMap);
        }
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("text","电影地区分布");
        dataMap.put("type","pie");
        dataMap.put("values",dataList);
        System.out.println(dataMap);
        return dataMap;
    }

    // 生成电影播放页面的播放数据的折线图
    @RequestMapping("/showMovieShowData")
    @ResponseBody
    public Map<String, Object> showMovieShowData(@RequestParam String movieId){
        System.out.println(movieId);
        List<MoviePlayback> moviePlaybackList = movieService.findMoviePlaybackByMovieId(movieId);
        List<Date> dateList = new ArrayList();
        List<Integer> valueList = new ArrayList();
        for(MoviePlayback moviePlayback : moviePlaybackList) {
            dateList.add(moviePlayback.getPlayDate());
            valueList.add(moviePlayback.getPlayOneDay());
        }
        Collections.sort(dateList);
        List<String> categoryList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Date date : dateList) {
            categoryList.add(sdf.format(date));
        }
        System.out.println(categoryList);
        Map<String,Object> dataMap = getOption("电影播放量表格","播放量",categoryList,valueList,"line");
        return dataMap;
    }


    public Map<String,Object> getOption(String text,String legend,List<String> categories,List<Integer> values,String type) {
        Map<String,Object> optionMap = new HashMap<>();
        List<String> legendList = new ArrayList<>(List.of(legend));
        optionMap.put("text",text);
        optionMap.put("legend",legendList);
        optionMap.put("categories",categories);
        optionMap.put("values",values);
        optionMap.put("type",type);

        return optionMap;
    }
}
