package com.heima.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Date;
import java.util.Properties;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Service
@Transactional
public class UploadService {
    public String uploadZip(MultipartFile file, Integer classId) {
        //用来检测程序运行时间
        long  startTime=System.currentTimeMillis();
        System.out.println("fileName："+file.getOriginalFilename());

        try {
            InputStream in = UploadService.class.getClassLoader().getResourceAsStream("file_upload.properties");
            Properties p = new Properties();
            p.load(in);
            String uploadPath = p.getProperty("upload_dir")+classId+File.separator+System.currentTimeMillis()+File.separator;
            File dir = new File(uploadPath);
            if(!dir.exists()){
                dir.mkdirs();
            }
            String filePath = uploadPath+file.getOriginalFilename();
            //获取输出流
            OutputStream os=new FileOutputStream(filePath);
            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            InputStream is=file.getInputStream();
            int temp;
            //一个一个字节的读取并写入
            while((temp=is.read())!=(-1))
            {
                os.write(temp);
            }
            os.flush();
            os.close();
            is.close();

            return  filePath;

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        long  endTime=System.currentTimeMillis();
        System.out.println("方法一的运行时间："+String.valueOf(endTime-startTime)+"ms");
        return  null;
    }


    public static void main(String[] args) {
        File file = new File("F:\\test\\pro-info\\src\\main\\java\\cn\\itcast\\pro\\action\\PageController.java");
        try {
            String str  = null;
            BufferedReader  br=new BufferedReader(new FileReader(file));
            do{
                str += br.readLine();
            }while(br.read()!=-1);
            System.out.println(str);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
