package com.internship.mapper;

import com.internship.entity.InternshipTask;

import java.util.List;

/**
 * 实习任务Mapper接口
 */
public interface InternshipTaskMapper {

    InternshipTask findById(Integer id);

    List<InternshipTask> findByInternshipId(Integer internshipId);

    int insert(InternshipTask task);

    int update(InternshipTask task);

    int deleteById(Integer id);

    int count();
}
