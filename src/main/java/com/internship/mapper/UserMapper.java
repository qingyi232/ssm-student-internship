package com.internship.mapper;

import com.internship.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 系统用户Mapper接口
 */
public interface UserMapper {

    User findByUsername(String username);

    User findById(Integer id);

    List<User> findAll();

    List<User> findByRole(Integer role);

    int insert(User user);

    int update(User user);

    int deleteById(Integer id);

    int updatePassword(@Param("id") Integer id, @Param("password") String password);

    int count();

    int countByRole(Integer role);
}
