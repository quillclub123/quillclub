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

import com.quillBolt.model.DraftedReflections;
import com.quillBolt.model.Reflections;
import com.quillBolt.model.StoryIdea;
import com.quillBolt.service.ReflectionsService;

@Controller
public class ReflectionsController {

	@Autowired
	ReflectionsService reflectionsService;
	
	@RequestMapping(value="/add_reflection")
	public ResponseEntity<Map<String, Object>> add_reflection(@RequestBody Reflections reflections){
		Map<String, Object> response = new HashMap<String,Object>();
		response = reflectionsService.add_reflection(reflections);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/add_draftreflection")
	public ResponseEntity<Map<String, Object>> add_draftreflection(@RequestBody DraftedReflections storyIdea){
		Map<String, Object> response = new HashMap<String,Object>();
		response = reflectionsService.add_draftreflection(storyIdea);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_reflectiondata")
	public ResponseEntity<Map<String, Object>> get_reflection(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = reflectionsService.get_reflection(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_reflection")
	public ResponseEntity<Map<String, Object>> get_draftreflection(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		String student_id = request.getParameter("student_id");
		response = reflectionsService.get_draftreflection(student_id,sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
