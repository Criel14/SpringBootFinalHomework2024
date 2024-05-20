package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Movie_playback {
    private int movie_id;
    private int play_one_day;
    private Date play_date;
}
