package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.Date;

@Data
public class movie {
    private int movie_id;
    private String movie_title;
    private String movie_description;
    private Date release_date;
    private int need_vip;
    private String movie_link;
    private String movie_region;
    private String movie_genre;
    private double movie_ratings;
}
