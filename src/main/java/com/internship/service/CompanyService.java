package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.Company;

import java.util.List;

/**
 * 实习企业Service接口
 */
public interface CompanyService {

    Company findById(Integer id);

    PageInfo<Company> findByCondition(String name, Integer status, int pageNum, int pageSize);

    List<Company> findAll();

    boolean addCompany(Company company);

    boolean updateCompany(Company company);

    boolean deleteCompany(Integer id);

    int count();
}
