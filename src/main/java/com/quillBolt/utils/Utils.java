package com.quillBolt.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Utils {

	//public static String staticimages = "C:/temp/";
	//public static String staticimages = "c:/temp/lemniscate/";
	public static String staticimages = "/var/lib/tomcat8/webapps/uploads/";


	DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	
	public String uploadImage(MultipartFile file) {
	String str = "";
	if (!file.isEmpty()) {
	str = file.getOriginalFilename();
	System.out.println(str);
	String[] str1 = str.split("\\.");
	int length=str1.length;
	str = str1[0] + dateFormat.format(new Date()) + "." + str1[length-1];
	str = str.trim();

	try {
	System.out.println(file.getBytes());
	byte[] bytes = file.getBytes();
	File serverFile = new File(Utils.staticimages + str);
	BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
	stream.write(bytes);
	stream.close();
	} catch (Exception e) {
	System.out.println(e);
	}
	}
	return str;
	}
}
