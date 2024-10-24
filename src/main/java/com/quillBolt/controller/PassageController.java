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

import com.quillBolt.model.DraftPassage;
import com.quillBolt.model.Passage;
import com.quillBolt.service.PassageService;

@Controller
public class PassageController {

	@Autowired
	PassageService passageService;
	
	@RequestMapping(value="/add_passage")
	public ResponseEntity<Map<String, Object>> add_passage(@RequestBody Passage passage){
		Map<String, Object> response = new HashMap<String,Object>();
		response = passageService.add_passage(passage);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/add_draftpassage")
	public ResponseEntity<Map<String, Object>> add_draftpassage(@RequestBody DraftPassage passage){
		Map<String, Object> response = new HashMap<String,Object>();
		response = passageService.add_draftpassage(passage);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_passage")
	public ResponseEntity<Map<String, Object>> get_passage(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		String student_id = request.getParameter("student_id");
		response = passageService.get_passage(sno,student_id);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
