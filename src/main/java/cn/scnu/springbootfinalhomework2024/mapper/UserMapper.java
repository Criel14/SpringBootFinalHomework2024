package cn.scnu.springbootfinalhomework2024.mapper;

import cn.scnu.springbootfinalhomework2024.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {

}

