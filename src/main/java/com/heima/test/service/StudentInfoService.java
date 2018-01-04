package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.StudentInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Service
@Transactional
public class StudentInfoService extends  BaseService<StudentInfo>{
    /**
     * 根据姓名  学号  密码  查询学员信息
     * @param studentInfo
     * @return
     */
    public List<StudentInfo> queryStudentInfoByExample(StudentInfo studentInfo) {
        Example example = new Example(StudentInfo.class);
        example.createCriteria().andEqualTo("studentName", studentInfo.getStudentName())
                .andEqualTo("studentNo", studentInfo.getStudentNo())
                .andEqualTo("password", studentInfo.getPassword());
        return getMapper().selectByExample(example);
    }
}
