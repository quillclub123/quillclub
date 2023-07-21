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

import com.quillBolt.model.ProgramInformation;
import com.quillBolt.model.Section;
import com.quillBolt.service.SectionService;

@Controller
public class SectionController {

	@Autowired
	SectionService sectionService;
	
	@RequestMapping(value="/add_section", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_section(@RequestBody Section section){
		Map<String, Object> response = new HashMap<String,Object>();
		response = sectionService.add_section(section);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_section", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_section(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = sectionService.get_section(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_deletedsection", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_deletedsection(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response = sectionService.get_deletedsection(start, length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/edit_section", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_section(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = sectionService.edit_section(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/delete_section")
	public ResponseEntity<Map<String, Object>> delete_section(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = sectionService.delete_section(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/getSectiondata")
	public ResponseEntity<Map<String, Object>> getSectiondata(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = sectionService.getSectiondata(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/updateSection", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateSection(@RequestBody Section section){
		Map<String, Object> response =sectionService.updateSection(section);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	
}
