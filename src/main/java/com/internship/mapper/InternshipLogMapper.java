package com.internship.mapper;

import com.internship.entity.InternshipLog;

import java.util.List;

/**
 * 实习日志Mapper接口
 */
public interface InternshipLogMapper {

    InternshipLog findById(Integer id);

    List<InternshipLog> findByInternshipId(Integer internshipId);

    List<InternshipLog> findByStudentId(Integer studentId);

    int insert(InternshipLog log);

    int update(InternshipLog log);

    int deleteById(Integer id);
}
