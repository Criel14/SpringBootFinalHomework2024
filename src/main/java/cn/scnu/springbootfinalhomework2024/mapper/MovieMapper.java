package cn.scnu.springbootfinalhomework2024.mapper;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MovieMapper extends BaseMapper<Movie> {
}
