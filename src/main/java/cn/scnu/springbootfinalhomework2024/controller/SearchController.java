package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.PagedData;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class SearchController {
    @Autowired
    private MovieService movieService;

    @PostMapping("/search/movieList")
    public ResponseEntity<List<Movie>> SelectMovie(@RequestParam("query") String query) {
        List<Movie> movieList = new ArrayList<>();

        System.out.println("------\n");
        System.out.println(query);

        movieList = movieService.queryMovie(query);

        return new ResponseEntity<>(movieList, HttpStatus.OK);
    }

    @RequestMapping("/movies")
    public ResponseEntity<PagedData<Movie>> getMovies(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize) {
        PagedData<Movie> pagedData = movieService.getMovies(page, pageSize);
        return ResponseEntity.ok(pagedData);
    }
}
