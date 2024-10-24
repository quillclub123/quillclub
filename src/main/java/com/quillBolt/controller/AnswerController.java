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

import com.quillBolt.model.Answers;
import com.quillBolt.model.Schools;
import com.quillBolt.service.AnswersService;

@Controller
public class AnswerController {
	
	@Autowired
	AnswersService answersService;
	@RequestMapping(value="/add_answer", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_answer(@RequestBody Answers answers){
		Map<String, Object> response = new HashMap<String,Object>();
		response = answersService.add_answer(answers);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_answer", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_answer(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		String name = request.getParameter("name");
		String class_name = request.getParameter("class_name");
		String section = request.getParameter("section");
		String group_id = request.getParameter("group_id");
		String school_id = request.getParameter("school_id");
		String createdAt = request.getParameter("createdAt");
		response = answersService.get_answer(start,length,search,name,class_name,section,group_id,school_id,createdAt);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_answerdata", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_answerdata(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		;
		String sno = request.getParameter("sno");
		response = answersService.get_answerdata(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_shortlisted_students", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_shortlisted_students(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		;
		String group_id = request.getParameter("group_id");
		String school_id = request.getParameter("school_id");
		String class_name = request.getParameter("class_name");
		String section = request.getParameter("section");
		response = answersService.get_shortlisted_students(group_id,school_id,class_name,section);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
