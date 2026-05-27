package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.Company;
import com.internship.mapper.CompanyMapper;
import com.internship.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 实习企业Service实现类
 */
@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private CompanyMapper companyMapper;

    @Override
    public Company findById(Integer id) {
        return companyMapper.findById(id);
    }

    @Override
    public PageInfo<Company> findByCondition(String name, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Company> list = companyMapper.findByCondition(name, status);
        return new PageInfo<>(list);
    }

    @Override
    public List<Company> findAll() {
        return companyMapper.findAll();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addCompany(Company company) {
        return companyMapper.insert(company) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateCompany(Company company) {
        return companyMapper.update(company) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteCompany(Integer id) {
        return companyMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return companyMapper.count();
    }
}
