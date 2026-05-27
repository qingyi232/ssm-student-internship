package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.Student;

import java.util.List;

/**
 * 学生信息Service接口
 */
public interface StudentService {

    Student findById(Integer id);

    Student findByUserId(Integer userId);

    PageInfo<Student> findByCondition(String name, String studentNo, String major, int pageNum, int pageSize);

    List<Student> findAll();

    boolean addStudent(Student student);

    boolean updateStudent(Student student);

    boolean deleteStudent(Integer id);

    int count();
}
