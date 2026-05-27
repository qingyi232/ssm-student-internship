package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.Teacher;
import com.internship.mapper.TeacherMapper;
import com.internship.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 教师信息Service实现类
 */
@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public Teacher findById(Integer id) {
        return teacherMapper.findById(id);
    }

    @Override
    public Teacher findByUserId(Integer userId) {
        return teacherMapper.findByUserId(userId);
    }

    @Override
    public PageInfo<Teacher> findByCondition(String name, String teacherNo, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Teacher> list = teacherMapper.findByCondition(name, teacherNo);
        return new PageInfo<>(list);
    }

    @Override
    public List<Teacher> findAll() {
        return teacherMapper.findAll();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addTeacher(Teacher teacher) {
        return teacherMapper.insert(teacher) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateTeacher(Teacher teacher) {
        return teacherMapper.update(teacher) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteTeacher(Integer id) {
        return teacherMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return teacherMapper.count();
    }
}
