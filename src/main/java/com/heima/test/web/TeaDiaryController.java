package com.heima.test.web;

import com.heima.test.domain.TeaDiary;
import com.heima.test.domain.User;
import com.heima.test.service.TeaDiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("diary")
public class TeaDiaryController {


    //注入TeaDiaryService
    @Autowired
    private TeaDiaryService teaDiaryService;



    @RequestMapping(value = "addTeaDiary",method = RequestMethod.POST)
    public String addTeaDiary(TeaDiary teaDiary, HttpSession session) {

        //从session中获取登录信息
        User user = (User) session.getAttribute("loginUser");
        if(null == user){
            return "redirect:/rest/login";
        }

        teaDiary.setDate(new Date());
        teaDiary.setDiaryNo("000");
        teaDiary.setUserName(user.getUsername());
        teaDiaryService.save(teaDiary);
        return  "redirect:/rest/tea_stu/tea_diary_list";
    }


}
