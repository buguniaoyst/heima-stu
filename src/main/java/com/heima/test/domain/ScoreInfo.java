package com.heima.test.domain;

import javax.persistence.*;

@Entity
@Table(name = "score_info")
public class ScoreInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer stuId;
    private  Integer itemId;
    private Double itemScore;
    private  Integer testId;

    public Integer getTestId() {
        return testId;
    }

    public void setTestId(Integer testId) {
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

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Double getItemScore() {
        return itemScore;
    }

    public void setItemScore(Double itemScore) {
        this.itemScore = itemScore;
    }

    @Override
    public String toString() {
        return "ScoreInfo{" +
                "id=" + id +
                ", stuId=" + stuId +
                ", itemId=" + itemId +
                ", itemScore=" + itemScore +
                ", testId=" + testId +
                '}';
    }
}
