package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.Internship;
import com.internship.mapper.InternshipMapper;
import com.internship.service.InternshipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 实习记录Service实现类
 */
@Service
public class InternshipServiceImpl implements InternshipService {

    @Autowired
    private InternshipMapper internshipMapper;

    @Override
    public Internship findById(Integer id) {
        return internshipMapper.findById(id);
    }

    @Override
    public PageInfo<Internship> findByCondition(String studentName, String companyName, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Internship> list = internshipMapper.findByCondition(studentName, companyName, status);
        return new PageInfo<>(list);
    }

    @Override
    public List<Internship> findByStudentId(Integer studentId) {
        return internshipMapper.findByStudentId(studentId);
    }

    @Override
    public List<Internship> findByTeacherId(Integer teacherId) {
        return internshipMapper.findByTeacherId(teacherId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addInternship(Internship internship) {
        return internshipMapper.insert(internship) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateInternship(Internship internship) {
        return internshipMapper.update(internship) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteInternship(Integer id) {
        return internshipMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return internshipMapper.count();
    }

    @Override
    public int countByStatus(Integer status) {
        return internshipMapper.countByStatus(status);
    }
}
