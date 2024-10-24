package com.quillBolt.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Utils {

	// public static String staticimages = "C:/temp/";
	//public static String staticimages = "C:/temp/";
	 public static String staticimages = "/var/lib/tomcat9/webapps/uploads/";

	DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

	public String uploadImage(MultipartFile file) {
		String str = "";
		if (!file.isEmpty()) {
			str = file.getOriginalFilename();
			System.out.println(str);
			String[] str1 = str.split("\\.");
			int length = str1.length;
			str = str1[0] + dateFormat.format(new Date()) + "." + str1[length - 1];
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
	public static String generateRandomPassword(int len) {
		// ASCII range � alphanumeric (0-9, a-z, A-Z)
		final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		SecureRandom random = new SecureRandom();
		StringBuilder sb = new StringBuilder();

		// each iteration of the loop randomly chooses a character from the given
		// ASCII range and appends it to the `StringBuilder` instance

		for (int i = 0; i < len; i++) {
			int randomIndex = random.nextInt(chars.length());
			sb.append(chars.charAt(randomIndex));
		}

		return sb.toString();
	}
}
