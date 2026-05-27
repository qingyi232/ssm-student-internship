package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.Student;
import com.internship.mapper.StudentMapper;
import com.internship.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 学生信息Service实现类
 */
@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student findById(Integer id) {
        return studentMapper.findById(id);
    }

    @Override
    public Student findByUserId(Integer userId) {
        return studentMapper.findByUserId(userId);
    }

    @Override
    public PageInfo<Student> findByCondition(String name, String studentNo, String major, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Student> list = studentMapper.findByCondition(name, studentNo, major);
        return new PageInfo<>(list);
    }

    @Override
    public List<Student> findAll() {
        return studentMapper.findAll();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addStudent(Student student) {
        return studentMapper.insert(student) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateStudent(Student student) {
        return studentMapper.update(student) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteStudent(Integer id) {
        return studentMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return studentMapper.count();
    }
}
