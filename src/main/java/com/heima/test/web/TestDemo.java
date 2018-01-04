package com.heima.test.web;


import com.heima.test.utils.CommonUtils;

import java.io.InputStream;
import java.util.Properties;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
public class TestDemo {

    public static void main(String[] args) {
        System.out.println();
        StringBuffer stringBuffer = new StringBuffer();
        InputStream in1 = CommonUtils.class.getClassLoader().getResourceAsStream("answer/primary-answer.properties");
        Properties pro1 = new Properties();
        InputStream in2 = CommonUtils.class.getClassLoader().getResourceAsStream("answer/senior-answer.properties");
        Properties pro2 = new Properties();

    }


}
