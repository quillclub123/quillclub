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

import com.quillBolt.model.Information;
import com.quillBolt.model.SampleAnswer;
import com.quillBolt.model.SampleQuestion;
import com.quillBolt.service.InformationService;

@Controller
public class InformationController {

	@Autowired
	InformationService informationService;
	@RequestMapping(value="/add_information")
	public ResponseEntity<Map<String, Object>> add_information(@RequestBody Information information){
		Map<String, Object> response = new HashMap<String,Object>();
		response = informationService.add_information(information);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_information", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_information(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  informationService.get_information(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value = "edit_info", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_info(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = informationService.edit_info(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	
	@RequestMapping(value = "/updateInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateSampleQ(@RequestBody Information information){
		Map<String, Object> response =informationService.updateInfo(information);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_info", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_info(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = informationService.delete_info(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
}
