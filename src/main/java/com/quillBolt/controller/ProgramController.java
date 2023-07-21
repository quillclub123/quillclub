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
import com.quillBolt.model.ProgramInformation;
import com.quillBolt.service.ProgramService;

@Controller
public class ProgramController {

	@Autowired
	ProgramService programService;
	@RequestMapping(value="/add_program", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_program(@RequestParam(value ="programdata") String programdata,@RequestParam(value="logo",required = false) MultipartFile logo){
		Map<String, Object> response = new HashMap<String,Object>();
		Gson gson = new Gson();
		System.out.println("programdata="+programdata);
		ProgramInformation programInformation = gson.fromJson(programdata, ProgramInformation.class);
		System.out.println(programInformation.getSchool_id());
		response =  programService.add_program(programInformation,logo);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_program", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_program(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  programService.get_program(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_Deleted_program", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_Deleted_program(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  programService.get_Deleted_program(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/updateprogram", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateprogram(@RequestBody ProgramInformation programInformation){
		Map<String, Object> response =programService.updateprogram(programInformation);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "edit_program", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_program(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = programService.edit_program(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "delete_program", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_program(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = programService.delete_program(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
}
