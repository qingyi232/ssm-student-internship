package com.internship.mapper;

import com.internship.entity.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 教师信息Mapper接口
 */
public interface TeacherMapper {

    Teacher findById(Integer id);

    Teacher findByUserId(Integer userId);

    Teacher findByTeacherNo(String teacherNo);

    List<Teacher> findAll();

    List<Teacher> findByCondition(@Param("name") String name, @Param("teacherNo") String teacherNo);

    int insert(Teacher teacher);

    int update(Teacher teacher);

    int deleteById(Integer id);

    int count();
}
