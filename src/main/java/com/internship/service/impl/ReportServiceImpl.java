package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.InternshipReport;
import com.internship.mapper.InternshipReportMapper;
import com.internship.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 实习报告Service实现类
 */
@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private InternshipReportMapper internshipReportMapper;

    @Override
    public InternshipReport findById(Integer id) {
        return internshipReportMapper.findById(id);
    }

    @Override
    public List<InternshipReport> findByInternshipId(Integer internshipId) {
        return internshipReportMapper.findByInternshipId(internshipId);
    }

    @Override
    public PageInfo<InternshipReport> findByStudentId(Integer studentId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<InternshipReport> list = internshipReportMapper.findByStudentId(studentId);
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<InternshipReport> findByCondition(String studentName, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<InternshipReport> list = internshipReportMapper.findByCondition(studentName, status);
        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addReport(InternshipReport report) {
        return internshipReportMapper.insert(report) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateReport(InternshipReport report) {
        return internshipReportMapper.update(report) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean reviewReport(Integer id, Integer status, String feedback, Integer score) {
        InternshipReport report = internshipReportMapper.findById(id);
        if (report == null) {
            return false;
        }
        report.setStatus(status);
        report.setFeedback(feedback);
        report.setScore(score);
        report.setReviewTime(new Date());
        return internshipReportMapper.update(report) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteReport(Integer id) {
        return internshipReportMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return internshipReportMapper.count();
    }

    @Override
    public int countByStatus(Integer status) {
        return internshipReportMapper.countByStatus(status);
    }
}
