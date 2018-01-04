package com.heima.test.web;

import com.heima.test.service.ScoreInfoService;
import com.heima.test.service.TestRecordsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("score")
public class ScoreInfoController {

    @Autowired
    private ScoreInfoService scoreInfoService;

    @Autowired
    private TestRecordsService  testRecordsService;


    @RequestMapping(value = "submitScoreInfo",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> submitScore(@RequestParam(value = "scoreInfos") String scoreInfo,@RequestParam("testRecord")String testRecord) {
        Map<String, Object> result = new HashMap<>();
        try {
            //保存分数信息
            scoreInfoService.submitScoreInfos(scoreInfo);

            //保存testRecord
            testRecordsService.saveTestRecord(testRecord);

            result.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result", false);
        }
        return result;
    }


}
