package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.InternshipLog;

import java.util.List;

/**
 * 实习日志Service接口
 */
public interface LogService {

    InternshipLog findById(Integer id);

    List<InternshipLog> findByInternshipId(Integer internshipId);

    PageInfo<InternshipLog> findByStudentId(Integer studentId, int pageNum, int pageSize);

    boolean addLog(InternshipLog log);

    boolean updateLog(InternshipLog log);

    boolean deleteLog(Integer id);
}
