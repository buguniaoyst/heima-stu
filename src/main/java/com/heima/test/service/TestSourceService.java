package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.StudentInfo;
import com.heima.test.domain.TestSource;
import com.heima.test.domain.User;
import com.heima.test.web.StundentInfoController;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TestSourceService  extends  BaseService<TestSource>{
    public TestSource queryByTestId(String testId) {
        Example example = new Example(TestSource.class);
        example.createCriteria().andEqualTo("id", testId);
        List<TestSource> testSourceList = this.getMapper().selectByExample(example);
        if(null != testSourceList && testSourceList.size()>0){
            return testSourceList.get(0);
        }
        return  null;
    }

    public TestSource selectTestSourceByTestId(StudentInfo studentInfo) {
        return queryByTestId(studentInfo.getTestId() + "");
    }

    public TestSource getTestSourceById(Integer id) {
        return this.getMapper().selectByPrimaryKey(id);
    }

    public TestSource queryTestSoueceByTestId(Integer testId) {
        Example example = new Example(TestSource.class);
        example.createCriteria().andEqualTo("id", testId);
        List<TestSource> testSources = this.getMapper().selectByExample(example);
        if (null != testSources && testSources.size() > 0) {
            return testSources.get(0);
        }else {
            return  null;
        }

    }
}
