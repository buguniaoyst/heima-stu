package com.heima.test.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.abel533.entity.Example;
import com.heima.test.dao.AnswerInfoDao;
import com.heima.test.domain.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class AnswerInfoService extends  BaseService<AnswerInfo> {

    @Autowired
    private AnswerInfoDao answerInfoDao;

    @Autowired
    private TestRecordsService testRecordsService;

    private ObjectMapper mapper = new ObjectMapper();

    public Boolean addAnswerInfo(String answerInfo,StudentInfo loginStu) {
        System.out.println(answerInfo);
        try {
            List<AnswerInfo> answerInfoList = mapper.readValue(answerInfo, new TypeReference<List<AnswerInfo>>() {});
            System.out.println(answerInfoList);
            if (null != answerInfoList && answerInfoList.size()>0){
                AnswerInfo as = answerInfoList.get(0);
                for(AnswerInfo answer:answerInfoList){
                    answer.setTestId(loginStu.getTestId()+"");
                    answer.setStuName(loginStu.getStudentName());
                    answer.setAnswerStatus(0);
                    save(answer);
                }

                TestRecords testRecords = new TestRecords();
                testRecords.setClassId(Integer.valueOf(as.getClassId()));
                testRecords.setUserId(as.getStuId());
                testRecords.setTestId(Integer.valueOf(as.getTestId()));
                testRecords.setPiyueStatus(0);
                testRecords.setTestDate(new Date());
                testRecordsService.save(testRecords);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    public List<AnswerInfo> queryAllOrderByClassid() {
        return  answerInfoDao.queryAnswerInfoGroupByStuidOrderByClassId();
    }

    public List<AnswerInfo> queryAnswerInfoListGroupByClassId() {
        return answerInfoDao.queryAnswerInfoListGroupByClassId();
    }

    public List<AnswerInfo> queryAnswerInfoListByClassId(String classId) {
        List<AnswerInfo> answerInfoList = answerInfoDao.queryAnswerInfoListByClassIdGroupByTestId(classId);
        return  answerInfoList;

    }

    public List<AnswerInfo> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {
        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId()) && StringUtils.isNotBlank(answerInfo.getTestId())){
//            Example example = new Example(AnswerInfo.class);
//            example.createCriteria().andEqualTo("classId", answerInfo.getClassId())
//                    .andEqualTo("testId", answerInfo.getTestId());

            List<AnswerInfo> answerInfoList = answerInfoDao.queryClassAnswerListByClassIdAndTestIdGroupByStuId(answerInfo.getClassId(), answerInfo.getTestId());

            return answerInfoList;
        }
        return  null;
    }

    public List<AnswerInfo> queryAnswerInfoListByClassIdAndTestIdAndStuId(Integer classId, Integer testId, Integer stuId) {
        Example example = new Example(AnswerInfo.class);
        example.createCriteria().andEqualTo("classId", classId)
                .andEqualTo("testId", testId)
                .andEqualTo("stuId", stuId);
        return this.getMapper().selectByExample(example);

    }

    public void updateAnswerInfoByStuIdAndItemId(ScoreInfo scinf) {
        Example example = new Example(AnswerInfo.class);
        example.createCriteria().andEqualTo("stuId", scinf.getStuId())
                .andEqualTo("itemId", scinf.getItemId());
        AnswerInfo answerInfo = new AnswerInfo();
        answerInfo.setAnswerStatus(1);
        answerInfo.setScore(scinf.getItemScore());
        this.getMapper().updateByExampleSelective(answerInfo, example);
    }
}
