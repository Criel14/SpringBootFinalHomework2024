package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.Date;

@Data
public class movie {
    private int movie_id;
    private String movie_title;
    private String movie_cover_url;
    private String movie_description;
    private Date release_date;
    private int need_vip;
    private String movie_local_url;
    private String movie_region;
    private String movie_type;
    private double movie_score;
}
