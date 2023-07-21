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
import com.quillBolt.model.Questions;
import com.quillBolt.model.SampleAnswer;
import com.quillBolt.model.SampleQuestion;
import com.quillBolt.model.Schools;
import com.quillBolt.service.SampleService;

@Controller
public class SampleController {

	@Autowired
	SampleService sampleService;
	@RequestMapping(value="/add_samplequestion", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_samplequestion(@RequestParam(value ="questions") String questions,@RequestParam(value="question_image",required = false) MultipartFile question_image){
		Map<String, Object> response = new HashMap<String,Object>();
		Gson gson = new Gson();
		SampleQuestion questiondata = gson.fromJson(questions, SampleQuestion.class);
		
		response =  sampleService.add_samplequestion(questiondata,question_image);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/add_sampleAnswer")
	public ResponseEntity<Map<String, Object>> add_sampleAnswer(@RequestBody SampleAnswer sampleAnswer){
		Map<String, Object> response = new HashMap<String,Object>();
		response = sampleService.add_sampleAnswer(sampleAnswer);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_sampleQuestion", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_sampleQuestion(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  sampleService.get_sampleQuestion(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_sampleAnswer", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_sampleAnswer(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  sampleService.get_sampleAnswer(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "edit_sampleQ", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_sampleQ(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = sampleService.edit_sampleQ(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "edit_sampleA", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_sampleA(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = sampleService.edit_sampleA(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	
	@RequestMapping(value = "/updateSampleQ", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateSampleQ(@RequestBody SampleQuestion sampleQuestion){
		Map<String, Object> response =sampleService.updateSampleQ(sampleQuestion);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/updateSampleA", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateSampleA(@RequestBody SampleAnswer sampleAnswer){
		Map<String, Object> response =sampleService.updateSampleA(sampleAnswer);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_sampleQ", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_sampleQ(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = sampleService.delete_sampleQ(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "delete_sampleA", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_sampleA(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = sampleService.delete_sampleA(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	
	
	
}
