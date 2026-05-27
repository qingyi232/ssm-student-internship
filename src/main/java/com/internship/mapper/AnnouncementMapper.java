package com.internship.mapper;

import com.internship.entity.Announcement;

import java.util.List;

/**
 * 系统公告Mapper接口
 */
public interface AnnouncementMapper {

    Announcement findById(Integer id);

    List<Announcement> findAll();

    List<Announcement> findByStatus(Integer status);

    int insert(Announcement announcement);

    int update(Announcement announcement);

    int deleteById(Integer id);

    int count();
}
