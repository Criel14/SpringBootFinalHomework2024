package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MovieController {
//
//    @Autowired
//    private MovieService movieService;
//
//    @GetMapping("/play/{id}")
//    public String playMovie(@PathVariable Long id, Model model) {
//        Movie movie = movieService.getMovieById(id);
//        model.addAttribute("movie", movie);
//        return "moviePlay";
//    }
//
//    @GetMapping("/{id}")
//    @ResponseBody
//    public Movie getMovieData(@PathVariable Long id) {
//        return movieService.getMovieById(id);
//    }


}
