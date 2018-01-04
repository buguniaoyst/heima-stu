package com.heima.test.dao;

import java.util.List;
import java.util.Map;

import com.github.abel533.mapper.Mapper;
import org.apache.ibatis.annotations.Param;

import com.heima.test.domain.TestRecords;

public interface TestRecordsMapper extends Mapper<TestRecords> {

	List<TestRecords> findRecordsByExample(Integer id);

	List<Map> showDetailAll(@Param("stuId") Integer stuId, @Param("testId") Integer testId);

    List<TestRecords> queryTestRecordGroupByClassIdAndTestId();

	List<Map> queryTestRecordsByClassIdAndTestId(@Param("classId") Integer classId, @Param("testId") Integer testId);
}
