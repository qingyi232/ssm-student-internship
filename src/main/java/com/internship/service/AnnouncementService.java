package com.internship.service;

import com.github.pagehelper.PageInfo;
import com.internship.entity.Announcement;

import java.util.List;

/**
 * 系统公告Service接口
 */
public interface AnnouncementService {

    Announcement findById(Integer id);

    PageInfo<Announcement> findAll(int pageNum, int pageSize);

    List<Announcement> findByStatus(Integer status);

    PageInfo<Announcement> findByStatus(Integer status, int pageNum, int pageSize);

    boolean addAnnouncement(Announcement announcement);

    boolean updateAnnouncement(Announcement announcement);

    boolean deleteAnnouncement(Integer id);

    int count();
}
