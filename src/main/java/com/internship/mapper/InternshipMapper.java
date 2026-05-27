package com.internship.mapper;

import com.internship.entity.Internship;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 实习记录Mapper接口
 */
public interface InternshipMapper {

    Internship findById(Integer id);

    List<Internship> findAll();

    List<Internship> findByStudentId(Integer studentId);

    List<Internship> findByTeacherId(Integer teacherId);

    List<Internship> findByCondition(@Param("studentName") String studentName, @Param("companyName") String companyName, @Param("status") Integer status);

    int insert(Internship internship);

    int update(Internship internship);

    int deleteById(Integer id);

    int count();

    int countByStatus(Integer status);
}
