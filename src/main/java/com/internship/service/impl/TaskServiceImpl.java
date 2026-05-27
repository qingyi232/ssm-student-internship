package com.internship.service.impl;

import com.internship.entity.InternshipTask;
import com.internship.mapper.InternshipTaskMapper;
import com.internship.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 实习任务Service实现类
 */
@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private InternshipTaskMapper internshipTaskMapper;

    @Override
    public InternshipTask findById(Integer id) {
        return internshipTaskMapper.findById(id);
    }

    @Override
    public List<InternshipTask> findByInternshipId(Integer internshipId) {
        return internshipTaskMapper.findByInternshipId(internshipId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addTask(InternshipTask task) {
        return internshipTaskMapper.insert(task) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateTask(InternshipTask task) {
        return internshipTaskMapper.update(task) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteTask(Integer id) {
        return internshipTaskMapper.deleteById(id) > 0;
    }
}
