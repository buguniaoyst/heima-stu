package com.heima.test.domain;

import javax.persistence.*;

@Entity
@Table(name = "answer_info")
public class AnswerInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;//答案实体类主键id
    private Integer stuId;//学员id
    private String classId;//班级id
    private Integer itemId;//题目id
    private  String silu;//做题思路
    private  String answer;//答案
    private  String testId;
    private  String testName;
    private  String stuName;
    private  Integer answerStatus;//答案状态   未批阅-0，已批阅-1
    private Double score;
    private String zipPath;

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getSilu() {
        return silu;
    }

    public void setSilu(String silu) {
        this.silu = silu;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Integer getAnswerStatus() {
        return answerStatus;
    }

    public void setAnswerStatus(Integer answerStatus) {
        this.answerStatus = answerStatus;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public String getZipPath() {
        return zipPath;
    }

    public void setZipPath(String zipPath) {
        this.zipPath = zipPath;
    }

    @Override
    public String toString() {
        return "AnswerInfo{" +
                "id=" + id +
                ", stuId=" + stuId +
                ", classId='" + classId + '\'' +
                ", itemId=" + itemId +
                ", silu='" + silu + '\'' +
                ", answer='" + answer + '\'' +
                ", testId='" + testId + '\'' +
                ", testName='" + testName + '\'' +
                ", stuName='" + stuName + '\'' +
                ", answerStatus=" + answerStatus +
                ", score=" + score +
                ", zipPath='" + zipPath + '\'' +
                '}';
    }
}
