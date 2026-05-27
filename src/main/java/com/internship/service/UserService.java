package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.User;

import java.util.List;

/**
 * 系统用户Service接口
 */
public interface UserService {

    User login(String username, String password);

    User findById(Integer id);

    List<User> findAll();

    PageInfo<User> findByRole(Integer role, int pageNum, int pageSize);

    boolean addUser(User user);

    boolean updateUser(User user);

    boolean deleteUser(Integer id);

    boolean updatePassword(Integer id, String oldPassword, String newPassword);

    int count();

    int countByRole(Integer role);
}
