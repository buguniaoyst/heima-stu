package com.heima.test.web;

import com.heima.test.domain.*;
import com.heima.test.service.*;
import com.heima.test.utils.CommonUtils;
import com.heima.test.utils.ScoreUtils;

import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sun.misc.Request;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("records")
public class TestRecordsController {



    @Autowired
    private TestRecordsService testRecordsService;




    @RequestMapping(value = "scoreList")
    @ResponseBody
    public Map<String, Object> getFinishedTest(HttpSession session, HttpServletRequest request){

    	
    	//获取用户登陆用户
    	 StudentInfo  studentInfo = (StudentInfo) session.getAttribute("loginStu");
       Map<String, Object> resultMap = new HashMap<String, Object>();
    	 if (studentInfo!=null) {
    		  List<TestRecords>	 lists=testRecordsService.findRecordsByExample(studentInfo.getId());
    		  if (lists!=null) {
    			  resultMap.put("pagesize", lists.size());
     	         resultMap.put("results", lists);
			}
    	 }
    
        return resultMap;
    }

    @RequestMapping(value = "showDetailAll")
    @ResponseBody
    public List<Map> showScoreDetail(Integer stuId,Integer testId,HttpSession session, HttpServletRequest request){
    	
    	 StudentInfo user = (StudentInfo) session.getAttribute("loginStu");
    	 
    	 if (user!=null) {
    		 Integer id = user.getId();
    		 if (id.equals(stuId)) {
    			 
    			List<Map> setails=testRecordsService.showDetailAll(stuId,testId);
    			 
				return setails;
			}
		}else{
			
			
			return null;
		}
    	

    	return null;
    }


    @RequestMapping(value = "queryTestRecordGroupByClassIdAndTestId",method = RequestMethod.GET)
    @ResponseBody
	public Map<String, Object> queryTestRecordGroupByClassIdAndTestId() {
		List<TestRecords> testRecordsList = testRecordsService.queryTestRecordGroupByClassIdAndTestId();
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", 20);
        result.put("results", testRecordsList);
        return  result;
	}

	@RequestMapping(value = "queryTestRecordsByClassIdAndTestId",method = RequestMethod.GET)
    @ResponseBody
	public List<Map> queryTestRecordsByClassIdAndTestId(TestRecords testRecords){
        List<Map> result=  testRecordsService.queryTestRecordsByClassIdAndTestId(testRecords.getClassId(), testRecords.getTestId());
        return result;
    }



}
