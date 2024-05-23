package cn.scnu.springbootfinalhomework2024.controller;


import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.RegisterResponse;
import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import cn.scnu.springbootfinalhomework2024.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    UserService userService;

    @Autowired
    MovieService movieService;

    User loginedUser = new User();

    List<String> regions = List.of("domestic","foreign");
    List<String> types = List.of("comedy","action","animation");

    @RequestMapping("/index")
    public String index(HttpSession httpSession,Model model,String category) {
        if(httpSession.getAttribute("user")!=null){
            model.addAttribute("user", httpSession.getAttribute("user"));
        }
        if(httpSession.getAttribute("movieList")!=null){
            model.addAttribute("movieList", httpSession.getAttribute("movieList"));
        }
        else{
            List<Movie> movieList = movieService.findAllMovie();
            model.addAttribute("movieList", movieList);
        }
        return "index";
    }

    @RequestMapping("/login")
    public String login(User user, Model model,HttpSession httpSession) {
//        if(httpSession.getAttribute("user")!=null){
//            model.addAttribute("user", httpSession.getAttribute("user"));
//            return "index";
//        }
        System.out.println(user);
        User loginUser = userService.confirmLogin(user);
        httpSession.setAttribute("user", loginUser);
        return "redirect:/index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession, Model model){
        httpSession.removeAttribute("user");
        return "redirect:/index";
    }

    @RequestMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user, Model model, HttpSession httpSession) {
        System.out.println(user);
        if (user.getPhoneNumber().length() != 1) {
            return ResponseEntity.badRequest().body(new RegisterResponse(false, "手机号长度不正确！"));
        }
        String str = userService.register(user);
        if (str.equals("注册成功")) {
            User loginUser = userService.confirmLogin(user);
            httpSession.setAttribute("user", loginUser);
            return ResponseEntity.ok(new RegisterResponse(true, "注册成功！"));
        } else {
            return ResponseEntity.badRequest().body(new RegisterResponse(false, "手机号码已被注册！"));
        }
    }

    @RequestMapping("/search")
    public String search() {
        return "search";
    }


    @RequestMapping( "/index/movieList")
    public String SelectMovie(HttpSession httpSession, Model model, @RequestParam("category") String category) {
        List<Movie> movieList = new ArrayList<>();
        if (regions.contains(category)) {
            movieList = movieService.findMovie(category, null);
        } else {
            movieList = movieService.findMovie(null, category);
        }
        System.out.println(movieList);
        model.addAttribute("movieList", movieList);
        httpSession.setAttribute("movieList", movieList);
        return "index";
    }

    @RequestMapping("/index/selectVipMovie")
    public String selectVipMovie(HttpSession httpSession, Model model){
        List<Movie> movieList = movieService.showMovieByVip(true);
        httpSession.setAttribute("vipMovieList", movieList);
        return "index";
    }

    @RequestMapping("/index/selectFreeMovie")
    public String selectFreeMovie(HttpSession httpSession, Model model){
        List<Movie> movieList = movieService.showMovieByVip(false);
        httpSession.setAttribute("vipMovieList", movieList);
        return "index";
    }
}
