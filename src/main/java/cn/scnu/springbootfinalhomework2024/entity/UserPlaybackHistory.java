package cn.scnu.springbootfinalhomework2024.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserPlaybackHistory {
    private int userId;
    @TableId(value = "movie_id", type = IdType.AUTO)
    private int movieId;
    private LocalDateTime viewingTimestamp;
}
