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

import com.quillBolt.model.DraftStory;
import com.quillBolt.model.DraftStoryIdea;
import com.quillBolt.model.Story;
import com.quillBolt.model.StoryIdea;
import com.quillBolt.service.StoryService;

@Controller
public class StoryController {

	@Autowired
	StoryService storyService;
	

	@RequestMapping(value="/add_story")
	public ResponseEntity<Map<String, Object>> add_story(@RequestBody Story story){
		Map<String, Object> response = new HashMap<String,Object>();
		response = storyService.add_story(story);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/add_draftstory")
	public ResponseEntity<Map<String, Object>> add_draftstory(@RequestBody DraftStory story){
		Map<String, Object> response = new HashMap<String,Object>();
		response = storyService.add_draftstory(story);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_story")
	public ResponseEntity<Map<String, Object>> get_story(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = storyService.get_story(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_draftstory")
	public ResponseEntity<Map<String, Object>> get_draftstory(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		String student_id = request.getParameter("student_id");
		response = storyService.get_draftstory(student_id,sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
