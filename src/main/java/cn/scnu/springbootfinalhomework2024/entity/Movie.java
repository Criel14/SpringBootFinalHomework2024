package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Movie {
    private int movieId;
    private String movieTitle;
    private String movieCoverUrl;
    private String movieDescription;
    private Date releaseDate;
    private int needVip;
    private String movieLocalUrl;
    private String movieRegion;
    private String movieType;
    private double movieScore;
}
