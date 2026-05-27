package com.internship.entity;

import java.util.Date;

/**
 * 系统公告实体类
 */
public class Announcement {
    private Integer id;
    private String title;
    private String content;
    private Integer publisherId;
    private Integer status;
    private Date createTime;
    private Date updateTime;

    /** 用于展示的发布者姓名（非数据库字段） */
    private transient String publisherName;

    public Announcement() {
    }

    public Announcement(Integer id, String title, String content, Integer publisherId,
                        Integer status, Date createTime, Date updateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.publisherId = publisherId;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    @Override
    public String toString() {
        return "Announcement{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", publisherId=" + publisherId +
                ", status=" + status +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", publisherName='" + publisherName + '\'' +
                '}';
    }
}
