package cn.scnu.springbootfinalhomework2024.controller;


import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.RegisterResponse;
import cn.scnu.springbootfinalhomework2024.entity.User;
import cn.scnu.springbootfinalhomework2024.entity.UserPlaybackHistory;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import cn.scnu.springbootfinalhomework2024.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class IndexController {

    @Autowired
    UserService userService;

    @Autowired
    MovieService movieService;

    User loginedUser = new User();


    List<String> regions = List.of("中国", "国外");
    List<String> types = List.of("comedy", "action", "animation");

    @Autowired
    private RedisTemplate redisTemplate;

    // 空页面
    @RequestMapping("/nonePage")
    public String nonePage() {
        return "nonePage";
    }


    // 首页，若有用户信息，则表示是已登录状态的首页
    @RequestMapping("/index")
    public String index(HttpSession httpSession, Model model) {
        if (httpSession.getAttribute("user") != null) {
            loginedUser = (User) httpSession.getAttribute("user");
            redisTemplate.opsForValue().set("user",loginedUser);
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
        redisTemplate.opsForValue().set("user",null);
        return "redirect:/index";
    }

    // 做注册功能，首先判断手机号是否合法，然后在数据库中查询用户手机号
    // 是否被注册，如果都通过就将信息记录数据库并用httpsession传输用户信息。
    @RequestMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user, Model model, HttpSession httpSession) {
        System.out.println(user);
        if (user.getPhoneNumber().length() != 11) {
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

    // 免费专区
    @RequestMapping("/freeMovie")
    public String freeMovie(HttpSession httpSession ,Model model) {
        if (httpSession.getAttribute("user") != null) {
            loginedUser = (User) httpSession.getAttribute("user");
            redisTemplate.opsForValue().set("user",loginedUser);
            model.addAttribute("user", loginedUser);
        }
        return "freeMovie";
    }
    // 会员专享
    @RequestMapping("/vipMovie")
    public String vipMovie(HttpSession httpSession,Model model) {
        if (httpSession.getAttribute("user") != null) {
            loginedUser = (User) httpSession.getAttribute("user");
            redisTemplate.opsForValue().set("user",loginedUser);
            model.addAttribute("user", loginedUser);
        }
        return "vipMovie";
    }
    //搜索页面
    @RequestMapping("/search")
    public String search() {
        return "search";
    }


    // 前端点击分类，后端查询电影列表
    @RequestMapping("/index/movieList")
    @ResponseBody
    public Map<String, Object> selectMovie(@RequestParam("query") String query,
                                           @RequestParam("page") int page,
                                           @RequestParam("size") int size) {
        Map<String, Object> response = new HashMap<>();
        List<Movie> allMovies = findMovieByQuery(query);
        // 根据页面大小切片
        List<Movie> paginatedMovies = getPaginatedMovies(page, size,allMovies);

        response.put("movies", paginatedMovies);
        response.put("total", Math.ceil((double) allMovies.size() / size));
        return response;
    }

    // 查询Free电影
    @RequestMapping("/freeMovie/movieList")
    @ResponseBody
    public Map<String, Object> selectFreeMovie(@RequestParam("query") String query,
                                           @RequestParam("page") int page,
                                           @RequestParam("size") int size) {
        Map<String, Object> response = new HashMap<>();
        List<Movie> allMovies = findMovieByQuery(query);
        // 去除是VIP的电影
        allMovies.removeIf(movie -> movie.getNeedVip() == 1);
        // 根据页面大小切片
        List<Movie> paginatedMovies = getPaginatedMovies(page, size,allMovies);

        response.put("movies", paginatedMovies);
        response.put("total", Math.ceil((double) allMovies.size() / size));
        return response;
    }

    // 查询Vip电影
    @RequestMapping("/vipMovie/movieList")
    @ResponseBody
    public Map<String, Object> selectVipMovie(@RequestParam("query") String query,
                                               @RequestParam("page") int page,
                                               @RequestParam("size") int size) {
        Map<String, Object> response = new HashMap<>();
        List<Movie> allMovies = findMovieByQuery(query);
        // 去除是VIP的电影
        allMovies.removeIf(movie -> movie.getNeedVip() == 0);
        // 根据页面大小切片
        List<Movie> paginatedMovies = getPaginatedMovies(page, size,allMovies);

        response.put("movies", paginatedMovies);
        response.put("total", Math.ceil((double) allMovies.size() / size));
        response.put("resUser", redisTemplate.opsForValue().get("user"));
        return response;
    }

    private List<Movie> findMovieByQuery(String query) {
        List<Movie> allMovies = new ArrayList<>();
        if (("all").equals(query)) {
            allMovies = movieService.findAllMovie();
        } else {
            // 要更改成判断query来查询
            if (regions.contains(query)) {
                allMovies = movieService.findMovieByRegion(query);
            } else if (types.contains(query)) {
                allMovies = movieService.findMovieByType(query);
            } else {
                allMovies = movieService.findMovieByTitle(query);
            }
        }
        return allMovies;
    }

    private List<Movie> getPaginatedMovies(int page, int size, List<Movie> allMovies) {
        int fromIndex = Math.min(page * size, allMovies.size());
        int toIndex = Math.min((page + 1) * size, allMovies.size());
        return allMovies.subList(fromIndex, toIndex);
    }


    @RequestMapping("/history/movieList")
    @ResponseBody
    public Map<String, Object> findUserHistoryMovie() {
        User user = (User) redisTemplate.opsForValue().get("user");
        int userId = user.getUserId();
        Map<String, Object> response = new HashMap<>();

        List<UserPlaybackHistory> userPlaybackHistoryList = movieService.findUserPlaybackHistoryByUserId(userId);

        List<Movie> movieList = new ArrayList<>();

        for (UserPlaybackHistory userPlaybackHistory : userPlaybackHistoryList) {
            Movie movie = movieService.findMovieById(userPlaybackHistory.getMovieId());
            movieList.add(movie);
        }

        response.put("movieList", movieList);
        response.put("userPlaybackHistoryList", userPlaybackHistoryList);

        return response;
    }

    @RequestMapping("/history")
    public String history(HttpSession httpSession,Model model) {
        if (httpSession.getAttribute("user") != null) {
            loginedUser = (User) httpSession.getAttribute("user");
            redisTemplate.opsForValue().set("user",loginedUser);
            model.addAttribute("user", loginedUser);
        }
        return "history";
    }

}
