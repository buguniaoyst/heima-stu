package com.heima.test.web;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.heima.test.domain.StudentInfo;
import com.heima.test.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.heima.test.utils.Constants;
import com.heima.test.utils.FastDFSTool;

import javax.servlet.http.HttpSession;

@Controller
public class UploadController {

    @Autowired
	private UploadService uploadService;

	@RequestMapping(value="/uploadVideo.do")
	@ResponseBody
	public Map<String, String> uploadVideo(MultipartFile mf) throws FileNotFoundException, IOException, Exception{
		
		// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
		String uploadFile = FastDFSTool.uploadFile(mf.getBytes(),
				mf.getOriginalFilename());
		// 返回json格式的字符串（图片的绝对网络存放地址）
		Map<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("videoPath", Constants.FDFS_SERVER + uploadFile);
		return hashMap;
	}

	@RequestMapping(value="/uploadPic.do")
	@ResponseBody
	public Map<String, String> uploadPic(MultipartFile mp) throws FileNotFoundException, IOException, Exception{

		// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
		String uploadFile = FastDFSTool.uploadFile(mp.getBytes(),
                mp.getOriginalFilename());
		// 返回json格式的字符串（图片的绝对网络存放地址）
		Map<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("picPath", Constants.FDFS_SERVER + uploadFile);
		return hashMap;
	}


	@RequestMapping(value="/uploadZip.do")
	@ResponseBody
	public Map<String, Object> uploadZip(MultipartFile fileUpload, HttpSession session) throws FileNotFoundException, IOException, Exception{
		StudentInfo studentInfo = (StudentInfo) session.getAttribute("loginStu");
		Integer classId = studentInfo.getClassId();
		String filePath = uploadService.uploadZip(fileUpload,classId);
        Map<String, Object> result = new HashMap<>();
        result.put("zipPath", filePath);
        result.put("status", true);
        return result;
	}
	
	
	
//	@RequestMapping(value="/upload/uploadPics.do")
//	@ResponseBody
//	public List<Object> uploadPics(@RequestParam MultipartFile[] mfs) throws FileNotFoundException, IOException, Exception{
//		List<Object> paths = new ArrayList<Object>();
//		// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
//		for (MultipartFile mf : mfs) {
//			
//			String uploadFile = FastDFSTool.uploadFile(mf.getBytes(),
//					mf.getOriginalFilename());
//			// 返回json格式的字符串（图片的绝对网络存放地址）
//			 paths.add(Constants.FDFS_SERVER + uploadFile);
//		}
//		return paths;
//	}
//	
//	@RequestMapping(value="/upload/uploadFck.do")
//	@ResponseBody
//	public HashMap<String, Object> uploadFck(HttpServletRequest request,HttpServletResponse response) throws FileNotFoundException, IOException, Exception{
//		// 将request强转为spring提供的MultipartRequest
//		MultipartRequest mr = (MultipartRequest) request;
//
//		// 获得MultipartRequest里面的所有文件
//		Set<Entry<String, MultipartFile>> entrySet = mr.getFileMap().entrySet();
//
//		for (Entry<String, MultipartFile> entry : entrySet) {
//			MultipartFile mpf = entry.getValue();
//			// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
//			String uploadFile = FastDFSTool.uploadFile(mpf.getBytes(),
//					mpf.getOriginalFilename());
//			// 返回json格式的字符串（图片的绝对网络存放地址）
//			HashMap<String, Object> hashMap = new HashMap<String, Object>();
//
//			// error和url名字都是固定死的
//			hashMap.put("error", 0);
//			hashMap.put("url", Constants.FDFS_SERVER + uploadFile);
//			return hashMap;
//		}
//		return null;
//	}

}
