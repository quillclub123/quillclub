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

import com.quillBolt.model.DraftStoryIdea;
import com.quillBolt.model.StoryIdea;
import com.quillBolt.service.StoryIdeaService;

@Controller
public class StoryIdeaController {

	@Autowired
	StoryIdeaService storyIdeaService;
	
	@RequestMapping(value="/add_storyidea")
	public ResponseEntity<Map<String, Object>> add_storyidea(@RequestBody StoryIdea storyIdea){
		Map<String, Object> response = new HashMap<String,Object>();
		response = storyIdeaService.add_storyidea(storyIdea);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/add_draftstoryidea")
	public ResponseEntity<Map<String, Object>> add_draftstoryidea(@RequestBody DraftStoryIdea storyIdea){
		Map<String, Object> response = new HashMap<String,Object>();
		response = storyIdeaService.add_draftstoryidea(storyIdea);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_storyIdea")
	public ResponseEntity<Map<String, Object>> get_storyidea(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = storyIdeaService.get_storyidea(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_storyidea")
	public ResponseEntity<Map<String, Object>> get_draftstoryidea(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		String student_id = request.getParameter("student_id");
		response = storyIdeaService.get_draftstoryidea(student_id,sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
