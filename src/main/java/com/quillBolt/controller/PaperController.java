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
import com.quillBolt.model.Paper;
import com.quillBolt.service.PaperService;

@Controller
public class PaperController {
	
	@Autowired
	PaperService paperService;

	@RequestMapping(value="/add_paper")
	public ResponseEntity<Map<String, Object>> add_paper(@RequestBody Paper paper){
		Map<String, Object> response = new HashMap<String,Object>();
		response = paperService.add_paper(paper);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/delete_paper")
	public ResponseEntity<Map<String, Object>> delete_paper(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String question_id = request.getParameter("question_id");
		String school_id = request.getParameter("school_id");
		String class_id = request.getParameter("class_id");
		response = paperService.delete_paper(question_id,school_id,class_id);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	
}
