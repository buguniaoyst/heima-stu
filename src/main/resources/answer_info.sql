/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50527
Source Host           : 127.0.0.1:3306
Source Database       : heima

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2017-12-19 11:27:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer_info
-- ----------------------------
DROP TABLE IF EXISTS `answer_info`;
CREATE TABLE `answer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stu_id` int(11) DEFAULT NULL,
  `class_id` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `silu` varchar(10000) DEFAULT NULL,
  `answer` varchar(10000) DEFAULT NULL,
  `test_id` varchar(255) DEFAULT NULL,
  `stu_name` varchar(255) DEFAULT NULL,
  `answer_status` int(11) DEFAULT NULL COMMENT '答案状态：0-未批阅，1-已批阅',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer_info
-- ----------------------------
INSERT INTO `answer_info` VALUES ('19', '129', '280', '10', '第一题的思路', '第一题的答案', '13', '张三', null);
INSERT INTO `answer_info` VALUES ('29', '132', '290', '9', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '14', '陈全艺', '0');
INSERT INTO `answer_info` VALUES ('30', '132', '290', '10', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '14', '陈全艺', '0');
INSERT INTO `answer_info` VALUES ('31', '132', '290', '11', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '@RequestMapping(value = \"showScoreDetail\")\n    @ResponseBody\n    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){\n        TestInfo testInfo = new TestInfo();\n        testInfo.setTestid(testCtrl.getTestId());\n        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);\n        Map<String, Object> resultMap = new HashMap<String, Object>();\n        resultMap.put(\"pagesize\", 50);\n        resultMap.put(\"results\", testInfoList);\n        return resultMap;\n    }\n', '14', '陈全艺', '0');
INSERT INTO `answer_info` VALUES ('38', '131', '290', '9', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', '14', '陈爽', '0');
INSERT INTO `answer_info` VALUES ('39', '131', '290', '10', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', '14', '陈爽', '0');
INSERT INTO `answer_info` VALUES ('40', '131', '290', '11', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', 'package com.heima.test.web;\n\nimport com.github.abel533.mapper.Mapper;\nimport com.heima.test.domain.AnswerInfo;\nimport com.heima.test.domain.TestSource;\nimport com.heima.test.domain.User;\nimport com.heima.test.service.AnswerInfoService;\nimport com.heima.test.service.TestSourceService;\nimport org.apache.commons.lang3.StringUtils;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.RequestParam;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport javax.servlet.http.HttpSession;\nimport java.util.HashMap;\nimport java.util.List;\nimport java.util.Map;\n\n@Controller\n@RequestMapping(value = \"answer\")\npublic class AnswerInfoController {\n\n    @Autowired\n    private AnswerInfoService answerInfoService;\n\n    @Autowired\n    private TestSourceService testSourceService;\n\n    @RequestMapping(value = \"addAnswerInfo\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> addAnswerInfo(@RequestParam(value = \"answerInfo\",required = false)String answerInfo, HttpSession session) {\n        //获取登录用户信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        Map<String, Object> result = new HashMap<>();\n        if (null != loginUser ) {\n            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);\n            result.put(\"result\", flag);\n        }else{\n            result.put(\"result\", false);\n        }\n        return  result;\n    }\n\n    @RequestMapping(value = \"itemTestAnswerList\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> getAnswerInfoList(HttpSession session) {\n\n        Map<String, Object> result = new HashMap<>();\n        //根据不同的用户角色 显示不同的答案信息\n        User loginUser = (User) session.getAttribute(\"loginUser\");\n        List<AnswerInfo> answerInfoList = null;\n        if(null != loginUser && \"管理员\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();\n        }else if (null != loginUser && \"助教\".equals(loginUser.getUsertype())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassid());\n        }\n        result.put(\"pagesize\", 100);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    @RequestMapping(value = \"queryAnswerInfoListByClassId\",method = RequestMethod.GET)\n    @ResponseBody\n    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = null;\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){\n            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());\n        }\n        result.put(\"pagesize\", 10);\n        result.put(\"results\", answerInfoList);\n        return  result;\n    }\n\n\n    /**\n     * 根据classId和testId查询这个班级的这套试卷的答案\n     * @param answerInfo\n     * @return\n     */\n    @RequestMapping(value = \"queryClassAnswerListByClassIdAndTestId\",method = RequestMethod.POST)\n    @ResponseBody\n    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {\n\n        Map<String, Object> result = new HashMap<>();\n        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);\n        //根据testId 查询testSource信息\n        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){\n            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));\n            result.put(\"testSourceInfo\",testSource);\n        }\n        result.put(\"results\", answerInfoList);\n        result.put(\"pagesize\", 20);\n        return  result;\n    }\n\n\n}\n', '14', '陈爽', '0');
INSERT INTO `answer_info` VALUES ('41', '132', '290', '9', 'aaaz啊啊啊在', 'aaaz啊啊啊在', '14', '陈全艺', '0');
INSERT INTO `answer_info` VALUES ('42', '132', '290', '10', 'aaaz啊啊啊在', 'aaaz啊啊啊在', '14', '陈全艺', '0');
INSERT INTO `answer_info` VALUES ('43', '132', '290', '11', 'aaaz啊啊啊在', 'aaaz啊啊啊在', '14', '陈全艺', '0');

-- ----------------------------
-- Table structure for class_info
-- ----------------------------
DROP TABLE IF EXISTS `class_info`;
CREATE TABLE `class_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` varchar(255) DEFAULT NULL,
  `test_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_info
-- ----------------------------
INSERT INTO `class_info` VALUES ('33', '280', '13');
INSERT INTO `class_info` VALUES ('34', '290', '14');

-- ----------------------------
-- Table structure for item_info
-- ----------------------------
DROP TABLE IF EXISTS `item_info`;
CREATE TABLE `item_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_type` varchar(255) DEFAULT NULL,
  `item_type` varchar(255) DEFAULT NULL,
  `item_status` varchar(255) DEFAULT NULL,
  `item_source_id` varchar(255) DEFAULT NULL,
  `item_content` varchar(255) DEFAULT NULL,
  `item_score` double DEFAULT NULL COMMENT '这道题给定的分数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item_info
-- ----------------------------
INSERT INTO `item_info` VALUES ('9', '0', '1', '1', '1101', '使用print方法在控制台打印输出“Hello World”', '20');
INSERT INTO `item_info` VALUES ('10', '0', '1', '1', '1101', '使用for循环打印输出1-100之间的偶数', '20');
INSERT INTO `item_info` VALUES ('11', '0', '1', '1', '1101', 'adssffdsfdsfs', '20');
INSERT INTO `item_info` VALUES ('12', '0', '1', '1', '1101', '哈哈哈哈哈哈', '10');
INSERT INTO `item_info` VALUES ('13', '0', '1', '1', '1101', '测试题', '5');
INSERT INTO `item_info` VALUES ('14', '0', '1', '1', '1101', '测试题第二道', '30');

-- ----------------------------
-- Table structure for score_info
-- ----------------------------
DROP TABLE IF EXISTS `score_info`;
CREATE TABLE `score_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `stu_id` int(11) DEFAULT NULL,
  `item_score` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score_info
-- ----------------------------
INSERT INTO `score_info` VALUES ('1', '10', '129', '20');
INSERT INTO `score_info` VALUES ('2', '10', '129', '20');
INSERT INTO `score_info` VALUES ('3', '9', '131', '20');
INSERT INTO `score_info` VALUES ('4', '10', '131', '20');
INSERT INTO `score_info` VALUES ('5', '11', '131', '20');

-- ----------------------------
-- Table structure for test_source
-- ----------------------------
DROP TABLE IF EXISTS `test_source`;
CREATE TABLE `test_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(255) DEFAULT NULL,
  `test_type` varchar(255) DEFAULT NULL,
  `test_status` varchar(255) DEFAULT NULL,
  `test_items` varchar(255) DEFAULT NULL,
  `test_sources_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_source
-- ----------------------------
INSERT INTO `test_source` VALUES ('10', 'day01-JavaSE环境搭建', '1', '1', '9', '1101');
INSERT INTO `test_source` VALUES ('11', 'day02-JavaSE基础语法', '1', '1', '9,10', '1101');
INSERT INTO `test_source` VALUES ('12', 'asdfwef', '1', '1', '9,10,11', '1101');
INSERT INTO `test_source` VALUES ('13', 'day01-JavaSE基础语法', '1', '1', '10', '1101');
INSERT INTO `test_source` VALUES ('14', 'day02-JavaSE练习', '1', '1', '9,10,11', '1101');

-- ----------------------------
-- Table structure for testctrl
-- ----------------------------
DROP TABLE IF EXISTS `testctrl`;
CREATE TABLE `testctrl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` varchar(255) DEFAULT NULL,
  `class_type` varchar(255) DEFAULT NULL,
  `class_no` varchar(255) DEFAULT NULL,
  `stu_number` varchar(255) DEFAULT NULL,
  `class_test_no` varchar(255) DEFAULT NULL,
  `test_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testctrl
-- ----------------------------
INSERT INTO `testctrl` VALUES ('30', '280', '0', '28', '28', '0', '已关闭');
INSERT INTO `testctrl` VALUES ('31', '290', '0', '29', '22', '0', '开启');

-- ----------------------------
-- Table structure for testinfo
-- ----------------------------
DROP TABLE IF EXISTS `testinfo`;
CREATE TABLE `testinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `q1` varchar(255) DEFAULT NULL,
  `q10` varchar(255) DEFAULT NULL,
  `q11` varchar(255) DEFAULT NULL,
  `q12` varchar(255) DEFAULT NULL,
  `q13` varchar(255) DEFAULT NULL,
  `q14` varchar(255) DEFAULT NULL,
  `q15` varchar(255) DEFAULT NULL,
  `q16` varchar(255) DEFAULT NULL,
  `q17` varchar(255) DEFAULT NULL,
  `q18` varchar(255) DEFAULT NULL,
  `q19` varchar(255) DEFAULT NULL,
  `q2` varchar(255) DEFAULT NULL,
  `q20` varchar(255) DEFAULT NULL,
  `q21` varchar(255) DEFAULT NULL,
  `q22` varchar(255) DEFAULT NULL,
  `q23` varchar(255) DEFAULT NULL,
  `q24` varchar(255) DEFAULT NULL,
  `q3` varchar(255) DEFAULT NULL,
  `q4` varchar(255) DEFAULT NULL,
  `q5` varchar(255) DEFAULT NULL,
  `q6` varchar(255) DEFAULT NULL,
  `q7` varchar(255) DEFAULT NULL,
  `q8` varchar(255) DEFAULT NULL,
  `q9` varchar(255) DEFAULT NULL,
  `total_score` double DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `q25` varchar(255) DEFAULT NULL,
  `q26` varchar(255) DEFAULT NULL,
  `q27` varchar(255) DEFAULT NULL,
  `q28` varchar(255) DEFAULT NULL,
  `q29` varchar(255) DEFAULT NULL,
  `q30` varchar(255) DEFAULT NULL,
  `q31` varchar(255) DEFAULT NULL,
  `q32` varchar(255) DEFAULT NULL,
  `q33` varchar(255) DEFAULT NULL,
  `q34` varchar(255) DEFAULT NULL,
  `q35` varchar(255) DEFAULT NULL,
  `q36` varchar(255) DEFAULT NULL,
  `q37` varchar(255) DEFAULT NULL,
  `q38` varchar(255) DEFAULT NULL,
  `q39` varchar(255) DEFAULT NULL,
  `q40` varchar(255) DEFAULT NULL,
  `testid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of testinfo
-- ----------------------------
INSERT INTO `testinfo` VALUES ('98', 'A', null, null, null, null, null, null, 'C', null, null, null, 'A', null, null, null, null, null, 'D', 'D', null, 'A', null, null, null, '5', '张三', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '280');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `classid` varchar(50) DEFAULT NULL,
  `usertype` varchar(50) DEFAULT NULL,
  `testid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '123', 'admin', '000', '管理员', '000');
INSERT INTO `userinfo` VALUES ('129', '123', '张三', '280', '普通用户', '13');
INSERT INTO `userinfo` VALUES ('130', '123', '李四', '280', '普通用户', '13');
INSERT INTO `userinfo` VALUES ('131', '123', '陈爽', '290', '普通用户', '14');
INSERT INTO `userinfo` VALUES ('132', '123', '陈全艺', '290', '普通用户', '14');
