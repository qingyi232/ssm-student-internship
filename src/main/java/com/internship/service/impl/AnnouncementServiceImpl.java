package com.internship.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.Announcement;
import com.internship.mapper.AnnouncementMapper;
import com.internship.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 系统公告Service实现类
 */
@Service
public class AnnouncementServiceImpl implements AnnouncementService {

    @Autowired
    private AnnouncementMapper announcementMapper;

    @Override
    public Announcement findById(Integer id) {
        return announcementMapper.findById(id);
    }

    @Override
    public PageInfo<Announcement> findAll(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Announcement> list = announcementMapper.findAll();
        return new PageInfo<>(list);
    }

    @Override
    public List<Announcement> findByStatus(Integer status) {
        return announcementMapper.findByStatus(status);
    }

    @Override
    public PageInfo<Announcement> findByStatus(Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Announcement> list = announcementMapper.findByStatus(status);
        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addAnnouncement(Announcement announcement) {
        return announcementMapper.insert(announcement) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateAnnouncement(Announcement announcement) {
        return announcementMapper.update(announcement) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteAnnouncement(Integer id) {
        return announcementMapper.deleteById(id) > 0;
    }

    @Override
    public int count() {
        return announcementMapper.count();
    }
}
