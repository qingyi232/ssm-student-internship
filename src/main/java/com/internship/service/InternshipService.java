package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.Internship;

import java.util.List;

/**
 * 实习记录Service接口
 */
public interface InternshipService {

    Internship findById(Integer id);

    PageInfo<Internship> findByCondition(String studentName, String companyName, Integer status, int pageNum, int pageSize);

    List<Internship> findByStudentId(Integer studentId);

    List<Internship> findByTeacherId(Integer teacherId);

    boolean addInternship(Internship internship);

    boolean updateInternship(Internship internship);

    boolean deleteInternship(Integer id);

    int count();

    int countByStatus(Integer status);
}
