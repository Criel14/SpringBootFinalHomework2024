package cn.scnu.springbootfinalhomework2024.mapper;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.entity.MoviePlayback;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MoviePlaybackMapper extends BaseMapper<MoviePlayback> {
}
