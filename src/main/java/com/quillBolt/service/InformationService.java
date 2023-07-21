package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.Information;
import com.quillBolt.model.SampleAnswer;
import com.quillBolt.model.SampleQuestion;

@Service
public class InformationService {

	@Autowired
	CommonDao commonDao;
	public Map<String, Object> add_information(Information information) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", information.getSno());
			List<Information> data = (List<Information>)commonDao.getDataByMap(map, new Information(), null, null, 0, -1);
			if(data.size() > 0) {
				
				data.get(0).setSno(information.getSno());
				data.get(0).setInformation(information.getInformation());
				data.get(0).setStatus("Deactive");
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
				response.put("message", "Information updated successfully");
			}else {
				
				information.setStatus("Deactive");
				information.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(information);
				if(i > 0) {
					response.put("status", "Success");
					response.put("message", "Information Added Successfully");
				}else {
					response.put("status", "Failed");
					response.put("message", "Something went wrong");
				}
			}
		}catch(Exception e) {
			response.put("status", "Failure");
			response.put("message", "Something went wrong"+e);
		}
		return response;
	}
	public Map<String, Object> get_information(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("information", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<Information> list = (List<Information>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new Information(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new Information(), "sno", "asc");
			
			if(list.size()>0) {
				response.put("data", list);
				response.put("recordsFiltered", count);
				response.put("recordsTotal", count);
				response.put("status", "Success");
			}else {
				response.put("data", new ArrayList());
				response.put("recordsFiltered", 0);
				response.put("recordsTotal", 0);
				response.put("status","Failed");
				return response;
			}
		} catch (Exception e) {
			response.put("data", new ArrayList());
			response.put("recordsFiltered", 0);
			response.put("recordsTotal", 0);
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}
	public Map<String, Object> edit_info(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Information> list = (List<Information>) commonDao.getDataByMap(map, new Information(), null, null, 0, -1);
			
			if(list.size()>0) {
				response.put("status","Success");
				response.put("data",list);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
	public Map<String, Object> updateInfo(Information information) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", information.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(information, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "Information", search);
			if (id > 0) {
				response.put("status", "Success");
				return response;
			}
			response.put("Failure", "Success");
			return response;
		} catch (Exception e) {
			response.put("Failed", "Internal Server Error");
			e.printStackTrace();
			return response;
		}
	}
	public Map<String, Object> delete_info(String sno) {
		Map<String, Object> response = new HashMap<String,Object>(); 
		try {
			
				commonDao.delete(new Information(), sno);
				response.put("status","Success");
				response.put("message", "Data Deleted Successfully");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failure");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
	

}
