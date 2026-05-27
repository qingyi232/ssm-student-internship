package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.InternshipLog;
import com.internship.mapper.InternshipLogMapper;
import com.internship.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 实习日志Service实现类
 */
@Service
public class LogServiceImpl implements LogService {

    @Autowired
    private InternshipLogMapper internshipLogMapper;

    @Override
    public InternshipLog findById(Integer id) {
        return internshipLogMapper.findById(id);
    }

    @Override
    public List<InternshipLog> findByInternshipId(Integer internshipId) {
        return internshipLogMapper.findByInternshipId(internshipId);
    }

    @Override
    public PageInfo<InternshipLog> findByStudentId(Integer studentId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<InternshipLog> list = internshipLogMapper.findByStudentId(studentId);
        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addLog(InternshipLog log) {
        return internshipLogMapper.insert(log) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateLog(InternshipLog log) {
        return internshipLogMapper.update(log) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteLog(Integer id) {
        return internshipLogMapper.deleteById(id) > 0;
    }
}
