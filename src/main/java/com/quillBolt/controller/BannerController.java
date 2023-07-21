package com.quillBolt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.quillBolt.model.Banner;
import com.quillBolt.model.MailTemplate;
import com.quillBolt.model.Questions;
import com.quillBolt.service.BannerService;

@Controller
public class BannerController {

	@Autowired
	BannerService bannerService;
	
	@RequestMapping(value="/add_banner", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_banner(@RequestParam(value="bannerImg") MultipartFile bannerImg){
		Map<String, Object> response = new HashMap<String,Object>();
		response =  bannerService.add_banner(bannerImg);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_banner", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_banner(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  bannerService.get_banner(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_banner", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_banner(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = bannerService.delete_banner(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "/updatbanner", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updatbanner(@RequestBody Banner banner){
		Map<String, Object> response =bannerService.updatbanner(banner);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
}
