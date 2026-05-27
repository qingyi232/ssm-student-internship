package com.internship.mapper;

import com.internship.entity.InternshipReport;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 实习报告Mapper接口
 */
public interface InternshipReportMapper {

    InternshipReport findById(Integer id);

    List<InternshipReport> findByInternshipId(Integer internshipId);

    List<InternshipReport> findByStudentId(Integer studentId);

    List<InternshipReport> findByCondition(@Param("studentName") String studentName, @Param("status") Integer status);

    int insert(InternshipReport report);

    int update(InternshipReport report);

    int deleteById(Integer id);

    int count();

    int countByStatus(Integer status);
}
