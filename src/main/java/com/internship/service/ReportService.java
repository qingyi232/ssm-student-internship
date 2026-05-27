package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.InternshipReport;

import java.util.List;

/**
 * 实习报告Service接口
 */
public interface ReportService {

    InternshipReport findById(Integer id);

    List<InternshipReport> findByInternshipId(Integer internshipId);

    PageInfo<InternshipReport> findByStudentId(Integer studentId, int pageNum, int pageSize);

    PageInfo<InternshipReport> findByCondition(String studentName, Integer status, int pageNum, int pageSize);

    boolean addReport(InternshipReport report);

    boolean updateReport(InternshipReport report);

    boolean reviewReport(Integer id, Integer status, String feedback, Integer score);

    boolean deleteReport(Integer id);

    int count();

    int countByStatus(Integer status);
}
