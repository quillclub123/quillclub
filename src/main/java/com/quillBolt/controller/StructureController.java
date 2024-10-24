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

import com.quillBolt.model.Structure;
import com.quillBolt.service.StructureService;

@Controller
public class StructureController {

	@Autowired
	StructureService structureService;
	
	@RequestMapping(value="/add_structure", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> add_structure(@RequestBody Structure structure){
		Map<String, Object> resposne = new HashMap<String,Object>();
		resposne = structureService.add_structure(structure);
		return new ResponseEntity<Map<String,Object>>(resposne,HttpStatus.OK);
	}
	@RequestMapping(value="/get_structuredata",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> get_structuredata(HttpServletRequest request ){
		String sno = request.getParameter("sno");
		Map<String, Object> response = structureService.get_structuredata(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
}
