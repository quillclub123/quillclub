package com.quillBolt.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quillBolt.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService  loginService;
	
	@RequestMapping(value="/check_login",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> checklogin(HttpServletRequest request){
		String student_id = request.getParameter("student_id");
		String password = request.getParameter("password");
		Map<String, Object> response = loginService.checklogin(student_id,password);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
}
