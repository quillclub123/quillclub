package com.quillBolt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.quillBolt.service.SelectedService;

@Controller
public class SelectedController {

	@Autowired
	SelectedService selectedService;
	
	@RequestMapping(value="/add_selected_students", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_selected_students(@RequestParam(value="group_id") String group_id,@RequestParam(value="school_id") String school_id,@RequestParam(value="attechment") MultipartFile attechment){
		Map<String, Object> response = new HashMap<String,Object>();
		response =  selectedService.add_selected_students(group_id,school_id,attechment);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_selected_students", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_selected_students(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		String group_id = request.getParameter("group_id");
		String school_id = request.getParameter("school_id");
		response =  selectedService.get_selected_students(start,length,search,group_id,school_id);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/update_status", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> update_status(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		String boxstatus = request.getParameter("boxstatus");
		response =  selectedService.update_status(sno,boxstatus);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/upload_pdf", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> upload_pdf(@RequestParam(value="pdf") MultipartFile pdf,@RequestParam(value="sno") String sno,@RequestParam(value="type") String type){
		Map<String, Object> response = new HashMap<String,Object>();
		response =  selectedService.upload_pdf(pdf,sno,type);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_reviewed_pdf", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_reviewed_pdf(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String group_id = request.getParameter("group_id");
		String school_id = request.getParameter("school_id");
		response =  selectedService.get_reviewed_pdf(group_id,school_id);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
