package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.Date;

@Data
public class MoviePlayback {
    private int movieId;
    private int playOneDay;
    private Date playDate;
}
