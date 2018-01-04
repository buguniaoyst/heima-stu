package com.heima.test.dao;

import com.github.abel533.mapper.Mapper;
import com.heima.test.domain.AnswerInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AnswerInfoDao extends Mapper<AnswerInfo> {
    List<AnswerInfo> queryAnswerInfoGroupByStuidOrderByClassId();

    List<AnswerInfo> queryAnswerInfoListGroupByClassId();

    List<AnswerInfo> queryAnswerInfoListByClassIdGroupByTestId(@Param("classId")String classId);

    List<AnswerInfo> queryClassAnswerListByClassIdAndTestIdGroupByStuId(@Param("classId") String classId, @Param("testId") String testId);
}
