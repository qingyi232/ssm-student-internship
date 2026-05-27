package com.internship.service;

import com.internship.entity.InternshipTask;

import java.util.List;

/**
 * 实习任务Service接口
 */
public interface TaskService {

    InternshipTask findById(Integer id);

    List<InternshipTask> findByInternshipId(Integer internshipId);

    boolean addTask(InternshipTask task);

    boolean updateTask(InternshipTask task);

    boolean deleteTask(Integer id);
}
