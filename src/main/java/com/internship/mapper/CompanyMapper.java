package com.internship.mapper;

import com.internship.entity.Company;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 实习企业Mapper接口
 */
public interface CompanyMapper {

    Company findById(Integer id);

    List<Company> findAll();

    List<Company> findByCondition(@Param("name") String name, @Param("status") Integer status);

    int insert(Company company);

    int update(Company company);

    int deleteById(Integer id);

    int count();
}
