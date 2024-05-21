package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserPlaybackHistory {
    private int userId;
    private int movieId;
    private LocalDateTime viewingTimestamp;
}
