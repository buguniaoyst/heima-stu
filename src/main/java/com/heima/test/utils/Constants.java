package com.heima.test.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Constants {
	
	public  static String FDFS_SERVER;

	static {
		//加载fastdfs的配置信息
        InputStream inputStream = Constants.class.getClassLoader().getResourceAsStream("fdfs_client.properties");
        Properties properties = new Properties();
        try {
            properties.load(inputStream);
            FDFS_SERVER = properties.getProperty("tracker_server");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }






}
