package com.heima.test.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.abel533.entity.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.heima.test.dao.TestRecordsMapper;
import com.heima.test.domain.TestRecords;


@Service
@Transactional
public class TestRecordsService extends  BaseService<TestRecords>{
	
	@Autowired
	private TestRecordsMapper testRecordsMapper;

	private  ObjectMapper mapper = new ObjectMapper();
	

	public List<TestRecords> findRecordsByExample(Integer id) {
		
		List<TestRecords> lists=testRecordsMapper.findRecordsByExample(id);
		
		
		return lists;
	}

	/**
	 * 
	 * @param stuId 
	 * @return
	 */
	public List<Map> showDetailAll(Integer stuId,Integer testId) {
		
		
		List<Map> details=testRecordsMapper.showDetailAll(stuId,testId);
		
		return details;
	}

    public void saveTestRecord(String testRecord) {
        try {
            TestRecords testRecords = mapper.readValue(testRecord, TestRecords.class);
            save(testRecords);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<TestRecords> queryTestRecordGroupByClassIdAndTestId() {
		return testRecordsMapper.queryTestRecordGroupByClassIdAndTestId();
	}

	public List<Map> queryTestRecordsByClassIdAndTestId(Integer classId, Integer testId) {

		return testRecordsMapper.queryTestRecordsByClassIdAndTestId(classId,testId);
	}
}
