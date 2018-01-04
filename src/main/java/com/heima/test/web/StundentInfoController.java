package com.heima.test.web;

import com.heima.test.domain.StudentInfo;
import com.heima.test.domain.TestCtrl;
import com.heima.test.domain.User;
import com.heima.test.service.StudentInfoService;
import com.heima.test.service.TestService;
import com.heima.test.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Controller
@RequestMapping("student")
public class StundentInfoController  {

    @Autowired
    private UserService userService;

    @Autowired
    private StudentInfoService studentInfoService;

    @Autowired
    private TestService testService;


    /**
     * 学员登录
     *
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ModelAndView login(StudentInfo studentInfo, HttpSession session) {

        if (StringUtils.isBlank(studentInfo.getStudentName()) || StringUtils.isBlank(studentInfo.getPassword()) || StringUtils.isBlank(studentInfo.getPassword())) {
            return new ModelAndView("login","message","请输入正确的用户名,密码和学号");
        }

        //查询
        List<StudentInfo> stundentInfos = studentInfoService.queryStudentInfoByExample(studentInfo);
        if (null != stundentInfos && stundentInfos.size() > 0) {
            StudentInfo loginStu = stundentInfos.get(0);
            session.setAttribute("loginStu",loginStu);
            //重定向到学员首页
            return new ModelAndView("redirect:/rest/stu_home");
        }else{
            return new ModelAndView("login","message","请输入正确的用户名和密码");
        }

    }


    @RequestMapping(value = "updateStudentPassword",method = RequestMethod.POST)
    @ResponseBody
    public Boolean updateStudentPassword(String password,HttpSession session) {
        //获取登录学员信息
        StudentInfo studentInfo = (StudentInfo) session.getAttribute("loginStu");
        if(null == studentInfo || StringUtils.isBlank(password)){
          return  false;
        }

        studentInfo.setPassword(password);
        studentInfoService.getMapper().updateByPrimaryKeySelective(studentInfo);

        return true;
    }




}
