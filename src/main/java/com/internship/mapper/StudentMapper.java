package com.internship.mapper;

import com.internship.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 学生信息Mapper接口
 */
public interface StudentMapper {

    Student findById(Integer id);

    Student findByUserId(Integer userId);

    Student findByStudentNo(String studentNo);

    List<Student> findAll();

    List<Student> findByCondition(@Param("name") String name, @Param("studentNo") String studentNo, @Param("major") String major);

    int insert(Student student);

    int update(Student student);

    int deleteById(Integer id);

    int count();
}
