package cn.scnu.springbootfinalhomework2024.service;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.mapper.MovieMapper;
import cn.scnu.springbootfinalhomework2024.mapper.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieService extends ServiceImpl<MovieMapper, Movie> {
    @Autowired
    private MovieMapper movieMapper;

    public List<Movie> findMovie(String region, String type) {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        if(region != null) {
            queryWrapper.eq("movie_region", region);
        }
        else{
            queryWrapper.eq("movie_type", type);
        }

        List<Movie> movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }

    public List<Movie> queryMovie(String query) {
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("movie_title", query);
        List<Movie> movieList = movieMapper.selectList(queryWrapper);
        return movieList;
    }
}
