package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.Teacher;

import java.util.List;

/**
 * 教师信息Service接口
 */
public interface TeacherService {

    Teacher findById(Integer id);

    Teacher findByUserId(Integer userId);

    PageInfo<Teacher> findByCondition(String name, String teacherNo, int pageNum, int pageSize);

    List<Teacher> findAll();

    boolean addTeacher(Teacher teacher);

    boolean updateTeacher(Teacher teacher);

    boolean deleteTeacher(Integer id);

    int count();
}
