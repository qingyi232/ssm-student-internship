package com.internship.entity;

import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
 * 实习任务实体类
 * status: 0-未开始, 1-进行中, 2-已完成
 */
public class InternshipTask {
    private Integer id;
    private Integer internshipId;
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date deadline;
    private Integer status;
    private Date createTime;
    private Date updateTime;

    private String internshipLabel;

    public InternshipTask() {
    }

    public InternshipTask(Integer id, Integer internshipId, String title, String content,
                          Date deadline, Integer status, Date createTime, Date updateTime) {
        this.id = id;
        this.internshipId = internshipId;
        this.title = title;
        this.content = content;
        this.deadline = deadline;
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

    public Integer getInternshipId() {
        return internshipId;
    }

    public void setInternshipId(Integer internshipId) {
        this.internshipId = internshipId;
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

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
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

    public String getInternshipLabel() {
        return internshipLabel;
    }

    public void setInternshipLabel(String internshipLabel) {
        this.internshipLabel = internshipLabel;
    }

    @Override
    public String toString() {
        return "InternshipTask{" +
                "id=" + id +
                ", internshipId=" + internshipId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", deadline=" + deadline +
                ", status=" + status +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", internshipLabel='" + internshipLabel + '\'' +
                '}';
    }
}
