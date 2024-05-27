package cn.scnu.springbootfinalhomework2024.service;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.mapper.MovieMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class MovieService extends ServiceImpl<MovieMapper, Movie> {
    @Autowired
    private MovieMapper movieMapper;

    // 根据电影地区或电影类型查询电影
    public List<Movie> findMovie(String region, String type) {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        if (region != null) {
            if (region.equals("中国")) {
                queryWrapper.like("movie_region", "中国");
            } else {
                queryWrapper.notIn("movie_region", "中国");
            }
        } else {
            queryWrapper.like("movie_type", type);
        }
        List<Movie> movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }

    //根据电影名称进行查询
    public List<Movie> findMovieByTitle(String query) {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("movie_title", query);
        List<Movie> movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }

    //查询所有电影
    public List<Movie> findAllMovie() {
        QueryWrapper queryWrapper = new QueryWrapper();
        List<Movie> movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }

    // 根据用户是否为vip来查询电影
    public List<Movie> showMovieByVip(Boolean needVip) {
        QueryWrapper queryWrapper = new QueryWrapper();
        List<Movie> movieList = new ArrayList<>();
        if (needVip == true) {
            queryWrapper.eq("need_vip", 1);
            movieList = movieMapper.selectList(queryWrapper);
        } else {
            queryWrapper.eq("need_vip", 0);
            movieList = movieMapper.selectList(queryWrapper);
        }
        return movieList;
    }

    // 根据播放次数排序电影，day如果是7就按照7天的播放总和排序
    public List<Movie> showMovieByCountPlay(int day) {
        List movieList = movieMapper.getMovieByCountPlay(day);
        return movieList;
    }

    // 分页查询
    public Map<String, Object> queryPage(Integer movieId, Integer pageNo, Integer pageSize) {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();

        if (movieId != null) {
            queryWrapper.eq("movieId", movieId);
        }
        int count = movieMapper.selectCount(queryWrapper).intValue();

        Page<Movie> page = new Page<>(pageNo, pageSize);
        Page<Movie> moviePage = movieMapper.selectPage(page, queryWrapper);

        Map<String, Object> map = new HashMap<>();
        map.put("count", count);
        map.put("records", page.getRecords());
        return map;
    }

    // 根据电影地区查询
    public List<Movie> findMovieByRegion(String query) {
        List<Movie> movieList = new ArrayList<>();
        QueryWrapper queryWrapper = new QueryWrapper();
        if ("中国".equals(query)) {
            queryWrapper.like("movie_region", query);
        } else {
            queryWrapper.notIn("movie_region", "中国");
        }
        movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }

    // 根据电影类型查询
    public List<Movie> findMovieByType(String query) {
        List<Movie> movieList = new ArrayList<>();
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.like("movie_type", query);
        movieList = movieMapper.selectList(queryWrapper);

        return movieList;
    }

    // 根据电影名称，电影主创人员，电影地区，电影类型查找电影
    public List<Movie> findMovieByAll(String query) {
        List<Movie> movieList = movieMapper.selectMovieByAll(query);
        movieList = movieList.stream().distinct().collect(Collectors.toList());
        return movieList;
    }

    // 根据评分排序
    public List<Movie> getMoviesSortedByScore() {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("movie_score");
        return movieMapper.selectList(queryWrapper);
    }

    // 根据播放量排序
    public List<Movie> getMoviesSortedByPlayCount() {
        return movieMapper.selectMoviesOrderByPlayCount();
    }

}
