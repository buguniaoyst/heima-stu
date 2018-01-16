package com.heima.test.domain;

import javax.persistence.*;

@Entity
@Table(name = "item_info")
public class ItemInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String classType;
    /**
     * 题型：0-编程题  1-单选题  2-多选题
     */
    private String itemType;
    private String itemSourceId;
    private String itemStatus;
    private String itemContent;
    private  Double itemScore;
    private String itemAnswer;
    private String videoPath;
    private String picPath;
    private String itemAnswerOption;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public String getItemSourceId() {
        return itemSourceId;
    }

    public void setItemSourceId(String itemSourceId) {
        this.itemSourceId = itemSourceId;
    }

    public String getItemStatus() {
        return itemStatus;
    }

    public void setItemStatus(String itemStatus) {
        this.itemStatus = itemStatus;
    }

    public String getItemContent() {
        return itemContent;
    }

    public void setItemContent(String itemContent) {
        this.itemContent = itemContent;
    }

    public Double getItemScore() {
        return itemScore;
    }

    public void setItemScore(Double itemScore) {
        this.itemScore = itemScore;
    }

    public String getItemAnswer() {
        return itemAnswer;
    }

    public void setItemAnswer(String itemAnswer) {
        this.itemAnswer = itemAnswer;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }

    public String getItemAnswerOption() {
        return itemAnswerOption;
    }

    public void setItemAnswerOption(String itemAnswerOption) {
        this.itemAnswerOption = itemAnswerOption;
    }


    @Override
    public String toString() {
        return "ItemInfo{" +
                "id=" + id +
                ", classType='" + classType + '\'' +
                ", itemType='" + itemType + '\'' +
                ", itemSourceId='" + itemSourceId + '\'' +
                ", itemStatus='" + itemStatus + '\'' +
                ", itemContent='" + itemContent + '\'' +
                ", itemScore=" + itemScore +
                ", itemAnswer='" + itemAnswer + '\'' +
                ", videoPath='" + videoPath + '\'' +
                ", picPath='" + picPath + '\'' +
                ", itemAnswerOption='" + itemAnswerOption + '\'' +
                '}';
    }
}
