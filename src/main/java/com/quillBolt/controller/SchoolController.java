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
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Schools;
import com.quillBolt.service.SchoolService;

@Controller
public class SchoolController {

	@Autowired
	SchoolService schoolService;
	
	
//	@RequestMapping(value="/add_school", method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> add_school(@RequestParam(value ="schooldata") String schooldata,@RequestParam(value="logo") MultipartFile logo){
//		Map<String, Object> response = new HashMap<String,Object>();
//		Gson gson = new Gson();
//		Schools school = gson.fromJson(schooldata, Schools.class);
//		response =  schoolService.add_school(school,logo);
//		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
//	}
	
	@RequestMapping(value="/add_school")
	public ResponseEntity<Map<String, Object>> add_school(@RequestBody Schools schools){
		Map<String, Object> response = new HashMap<String,Object>();
		response = schoolService.add_school(schools);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/update_school", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> update_school(@RequestParam(value ="schooldata") String schooldata,@RequestParam(value="logo",required = false) MultipartFile logo){
		Map<String, Object> response = new HashMap<String,Object>();
		Gson gson = new Gson();
		Schools school = gson.fromJson(schooldata, Schools.class);
		response =  schoolService.update_school(school,logo);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/get_school", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_school(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = schoolService.get_schools(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_deletedschool", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_deletedschool(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = schoolService.get_deletedschool(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value = "/updateschooldata", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateschooldata(@RequestBody Schools school){
		Map<String, Object> response =schoolService.updateschooldata(school);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	@RequestMapping(value="/edit_school", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_school(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = schoolService.edit_school(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/delete_school", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_school(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = schoolService.delete_school(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_schoolOptional", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_schoolOptional(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = schoolService.get_schoolOptional(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
