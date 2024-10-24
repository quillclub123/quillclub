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

import com.quillBolt.model.ProfileQuestions;
import com.quillBolt.service.ProfileQuestionService;

@Controller
public class ProfileQuestionController {

	@Autowired
	ProfileQuestionService profileQuestionService;
	
	@RequestMapping(value="/add_profile_question", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_profile_question(@RequestBody ProfileQuestions question){
		Map<String, Object> resposne = new HashMap<String,Object>();
		resposne = profileQuestionService.add_profile_question(question);
		return new ResponseEntity<Map<String,Object>>(resposne,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_profile_questions", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_profile_questions(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  profileQuestionService.get_profile_questions(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_question_list", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_question_list(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response =  profileQuestionService.get_question_list(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	
}
