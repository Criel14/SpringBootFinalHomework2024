package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.PagedData;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SearchController {
    @Autowired
    private MovieService movieService;

    @RequestMapping("/search/movieList")
    @ResponseBody
    public Map<String, Object> selectMovie(
            @RequestParam("query") String query,
            @RequestParam("page") int page,
            @RequestParam("size") int size) {
        Map<String, Object> response = new HashMap<>();
        List<Movie> allMovies = movieService.queryMovie(query);

        int fromIndex = Math.min(page * size, allMovies.size());
        int toIndex = Math.min((page + 1) * size, allMovies.size());
        List<Movie> paginatedMovies = allMovies.subList(fromIndex, toIndex);

        response.put("movies", paginatedMovies);
        response.put("total", Math.ceil((double)allMovies.size() / size));

        return response;
    }

}
