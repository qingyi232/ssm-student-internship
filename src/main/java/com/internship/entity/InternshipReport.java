package com.internship.entity;

import java.util.Date;

/**
 * 实习报告实体类
 * status: 0-待审核, 1-已通过, 2-已驳回
 */
public class InternshipReport {
    private Integer id;
    private Integer internshipId;
    private Integer studentId;
    private String title;
    private String content;
    private String filePath;
    private Integer status;
    private String feedback;
    private Integer score;
    private Date submitTime;
    private Date reviewTime;
    private Date createTime;

    /** 用于展示的学生姓名（非数据库字段） */
    private transient String studentName;

    public InternshipReport() {
    }

    public InternshipReport(Integer id, Integer internshipId, Integer studentId, String title,
                            String content, String filePath, Integer status, String feedback,
                            Integer score, Date submitTime, Date reviewTime, Date createTime) {
        this.id = id;
        this.internshipId = internshipId;
        this.studentId = studentId;
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.status = status;
        this.feedback = feedback;
        this.score = score;
        this.submitTime = submitTime;
        this.reviewTime = reviewTime;
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

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Date getReviewTime() {
        return reviewTime;
    }

    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    @Override
    public String toString() {
        return "InternshipReport{" +
                "id=" + id +
                ", internshipId=" + internshipId +
                ", studentId=" + studentId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", filePath='" + filePath + '\'' +
                ", status=" + status +
                ", feedback='" + feedback + '\'' +
                ", score=" + score +
                ", submitTime=" + submitTime +
                ", reviewTime=" + reviewTime +
                ", createTime=" + createTime +
                ", studentName='" + studentName + '\'' +
                '}';
    }
}
