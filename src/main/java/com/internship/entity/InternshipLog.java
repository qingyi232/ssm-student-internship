package com.internship.entity;

import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
 * 实习日志实体类
 */
public class InternshipLog {
    private Integer id;
    private Integer internshipId;
    private Integer studentId;
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date logDate;
    private Date createTime;

    public InternshipLog() {
    }

    public InternshipLog(Integer id, Integer internshipId, Integer studentId, String title,
                         String content, Date logDate, Date createTime) {
        this.id = id;
        this.internshipId = internshipId;
        this.studentId = studentId;
        this.title = title;
        this.content = content;
        this.logDate = logDate;
        this.createTime = createTime;
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

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
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

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "InternshipLog{" +
                "id=" + id +
                ", internshipId=" + internshipId +
                ", studentId=" + studentId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", logDate=" + logDate +
                ", createTime=" + createTime +
                '}';
    }
}
