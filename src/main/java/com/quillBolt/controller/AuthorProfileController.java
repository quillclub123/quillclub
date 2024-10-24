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

import com.quillBolt.model.AuthorProfileQuestion;
import com.quillBolt.service.AuthorProfileService;

@Controller
public class AuthorProfileController {

	@Autowired
	AuthorProfileService authorProfileService;
	
	@RequestMapping(value="/add_apq", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_apq(@RequestBody AuthorProfileQuestion authorProfileQuestion){
		Map<String, Object> resposne = new HashMap<String,Object>();
		resposne = authorProfileService.add_apq(authorProfileQuestion);
		return new ResponseEntity<Map<String,Object>>(resposne,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_apq",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> get_apq(HttpServletRequest request ){
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		Map<String, Object> response = authorProfileService.get_apq(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_qa",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> get_qa(HttpServletRequest request ){
		String sno = request.getParameter("sno");
		Map<String, Object> response = authorProfileService.get_qa(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
