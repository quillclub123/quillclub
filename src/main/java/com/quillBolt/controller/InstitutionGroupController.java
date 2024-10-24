package com.quillBolt.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.quillBolt.model.Classes;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.service.InstitutionGroupService;
import com.quillBolt.utils.Utils;

@Controller
public class InstitutionGroupController {

	@Autowired
	InstitutionGroupService inGroupService;
	
	
	@RequestMapping(value="/add_group")
	public ResponseEntity<Map<String, Object>> add_group(@RequestBody InstituitonGroup instituitonGroup){
		Map<String, Object> response = new HashMap<String,Object>();
		response = inGroupService.add_group(instituitonGroup);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/get_group", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_group(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  inGroupService.get_group(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_deletedgroup", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_deletedgroup(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  inGroupService.get_deletedgroup(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_group", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_group(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = inGroupService.delete_group(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "/updateInstitutiondata", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateInstitutiondata(@RequestBody InstituitonGroup instituitonGroup){
		Map<String, Object> response =inGroupService.updateInstitutiondata(instituitonGroup);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
	@RequestMapping(value = "edit_group", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> edit_group(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response = inGroupService.edit_group(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	
	// this method used to display user image
			@RequestMapping(value = "/displaydocument", method = RequestMethod.GET)
			public ResponseEntity<byte[]> getdocumentcourse(HttpServletRequest request) throws IOException {
				String url = request.getParameter("url");
				
				String path = Utils.staticimages;
				HttpHeaders headers = new HttpHeaders();
				InputStream in = null;
				try {
					in = new FileInputStream(path + url);/* ;new FileInputStream(downloadFile); */
				} catch (Exception e) {
					System.out.println(e);
				}
				byte[] media = IOUtils.toByteArray(in);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue());
				ResponseEntity<byte[]> responseEntity = new ResponseEntity(media, headers, HttpStatus.OK);
				return responseEntity;
			}
	@RequestMapping(value = "/your_pdf", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getDocument1(HttpServletRequest request) throws IOException {
	    String url = request.getParameter("url");
	    String path = Utils.staticimages;
	    
	    // Determine the file's content type based on its extension
	    String fileType = Files.probeContentType(Paths.get(path + url));
	    if (fileType == null) {
	        fileType = "application/octet-stream"; // Default binary type if unknown
	    }

	    HttpHeaders headers = new HttpHeaders();
	    InputStream in = null;
	    byte[] media = null;

	    try {
	        in = new FileInputStream(path + url);
	        media = IOUtils.toByteArray(in);
	    } catch (Exception e) {
	        System.out.println(e);
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    } finally {
	        if (in != null) {
	            in.close();
	        }
	    }

	    headers.setCacheControl(CacheControl.noCache().getHeaderValue());
	    headers.setContentType(MediaType.parseMediaType(fileType));

	    return new ResponseEntity<>(media, headers, HttpStatus.OK);
	}

}
