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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    UserService userService;

    @Autowired
    MovieService movieService;

    User loginedUser = new User();


    List<String> regions = List.of("中国","国外");
    List<String> types = List.of("comedy", "action", "animation");

    // 首页，若有用户信息，则表示是已登录状态的首页
    @RequestMapping("/index")
    public String index(HttpSession httpSession , Model model) {
        if(httpSession.getAttribute("user") != null){
            loginedUser = (User) httpSession.getAttribute("user");
            model.addAttribute("user", loginedUser);
        }

        return "index";
    }

    //做登录功能，在确认用户在数据库后用httpsession传给首页
    @RequestMapping("/login")
    public String login(User user, Model model, HttpSession httpSession) {
        System.out.println(user);
        User loginUser = userService.confirmLogin(user);
        httpSession.setAttribute("user", loginUser);
        return "redirect:/index";
    }

    // 做退出功能，将httpsession中的登录信息移除
    @RequestMapping("/logout")
    public String logout(HttpSession httpSession, Model model) {
        httpSession.removeAttribute("user");
        return "redirect:/index";
    }

    // 做注册功能，首先判断手机号是否合法，然后在数据库中查询用户手机号
    // 是否被注册，如果都通过就将信息记录数据库并用httpsession传输用户信息。
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

    //搜索页面
    @RequestMapping("/search")
    public String search() {
        return "search";
    }


    // 前端点击分类，后端查询电影列表
    @RequestMapping("/index/movieList")
    @ResponseBody
    public Map<String, Object> selectMovie(
            @RequestParam("query") String query,
            @RequestParam("page") int page,
            @RequestParam("size") int size) {
        Map<String, Object> response = new HashMap<>();
        List<Movie> allMovies = new ArrayList<>();
        System.out.println(query);
        if(("").equals(query)){
            allMovies = movieService.findAllMovie();
        }
        else{
            // 要更改成判断query来查询
            if(regions.contains(query)){
                allMovies = movieService.findMovieByRegion(query);
        } else if (types.contains(query)) {
                allMovies = movieService.findMovieByType(query);
            }
            else{
                allMovies = movieService.findMovieByTitle(query);
            }
        }
        System.out.println(allMovies);
        int fromIndex = Math.min(page * size, allMovies.size());
        int toIndex = Math.min((page + 1) * size, allMovies.size());
        List<Movie> paginatedMovies = allMovies.subList(fromIndex, toIndex);

        response.put("movies", paginatedMovies);
        response.put("total", Math.ceil((double) allMovies.size() / size));
        System.out.println(response.get("total"));
        return response;
    }


    //查询vip电影
    @RequestMapping("/index/selectVipMovie")
    public String selectVipMovie(HttpSession httpSession, Model model) {
        List<Movie> movieList = movieService.showMovieByVip(true);
        httpSession.setAttribute("vipMovieList", movieList);
        return "index";
    }

    //查询免费电影
    @RequestMapping("/index/selectFreeMovie")
    public String selectFreeMovie(HttpSession httpSession, Model model) {
        List<Movie> movieList = movieService.showMovieByVip(false);
        httpSession.setAttribute("vipMovieList", movieList);
        return "index";
    }


}
