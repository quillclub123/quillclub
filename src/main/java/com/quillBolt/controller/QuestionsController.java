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
import com.quillBolt.model.ProgramInformation;
import com.quillBolt.model.Questions;
import com.quillBolt.service.QuestionsService;

@Controller
public class QuestionsController {

	@Autowired
	QuestionsService questionsService;
	
	@RequestMapping(value="/add_question", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_question(@RequestParam(value ="questions") String questions,@RequestParam(value="question_image",required = false) MultipartFile question_image){
		Map<String, Object> response = new HashMap<String,Object>();
		Gson gson = new Gson();
		Questions questiondata = gson.fromJson(questions, Questions.class);
		
		response =  questionsService.add_question(questiondata,question_image);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_question", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_quetion(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		String imgdata = request.getParameter("imgdata");
		response =  questionsService.get_quetion(start,length,search,imgdata);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_Deletedquestion", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_Deletedquestion(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		
		response =  questionsService.get_Deletedquestion(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_questionforPaper", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_questionforPaper(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		int school_id = Integer.parseInt(request.getParameter("school_id"));
		int class_id = Integer.parseInt(request.getParameter("class_id"));
		String imgdata = request.getParameter("imgdata");
		response =  questionsService.get_questionforPaper(start,length,search,school_id,class_id,imgdata);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_question", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_question(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = questionsService.delete_question(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "edit_question", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_question(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = questionsService.edit_question(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	
	@RequestMapping(value = "/updateQuestion", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateQuestion(@RequestBody Questions questions){
		Map<String, Object> response =questionsService.updateQuestion(questions);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
}
