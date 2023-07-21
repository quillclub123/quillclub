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

import com.quillBolt.model.Classes;
import com.quillBolt.service.ClassesService;

@Controller
public class ClassesController {

	@Autowired
	ClassesService classesService;
	
	@RequestMapping(value="/add_class")
	public ResponseEntity<Map<String, Object>> add_class(@RequestBody Classes classes){
		Map<String, Object> response = new HashMap<String,Object>();
		response = classesService.add_class(classes);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_class")
	public ResponseEntity<Map<String, Object>> get_class(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = classesService.get_class(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_deletedclass")
	public ResponseEntity<Map<String, Object>> get_deletedclass(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = classesService.get_deletedclass(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/edit_class")
	public ResponseEntity<Map<String, Object>> edit_class(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = classesService.edit_class(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_schooldata")
	public ResponseEntity<Map<String, Object>> get_schooldata(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String institutionId = request.getParameter("institutionId");
		response = classesService.get_schooldata(institutionId);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_classdata")
	public ResponseEntity<Map<String, Object>> get_classdata(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String schoolId = request.getParameter("schoolId");
		response = classesService.get_classdata(schoolId);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/delete_class")
	public ResponseEntity<Map<String, Object>> delete_class(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = classesService.delete_class(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
}
