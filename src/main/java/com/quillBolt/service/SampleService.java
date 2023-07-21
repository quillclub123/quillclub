package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.SampleAnswer;
import com.quillBolt.model.SampleQuestion;
import com.quillBolt.utils.Utils;

@Service
public class SampleService {

	@Autowired
	CommonDao commonDao;
	
	public Map<String, Object> add_samplequestion(SampleQuestion questiondata, MultipartFile question_image) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			Utils utils = new Utils();
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", questiondata.getSno());
			List<SampleQuestion> data = (List<SampleQuestion>)commonDao.getDataByMap(map, new SampleQuestion(), null, null, 0, -1);
			if(data.size() > 0) {
				if(question_image != null && !question_image.isEmpty()) {
					String qimg = utils.uploadImage(question_image);
					data.get(0).setQuestion_image(qimg);
				}
				data.get(0).setSno(questiondata.getSno());
				data.get(0).setQuestion(questiondata.getQuestion());
				data.get(0).setStatus("Deactive");
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
				response.put("message", "Sample Question updated successfully");
			}else {
				if(question_image != null && !question_image.isEmpty()) {
					String qimg = utils.uploadImage(question_image);
					questiondata.setQuestion_image(qimg);
				}
				questiondata.setStatus("Deactive");
				questiondata.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(questiondata);
				if(i > 0) {
					response.put("status", "Success");
					response.put("message", "Sample Question Added Successfully");
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

	public Map<String, Object> add_sampleAnswer(SampleAnswer sampleAnswer) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", sampleAnswer.getSno());
			List<SampleAnswer> data = (List<SampleAnswer>)commonDao.getDataByMap(map, new SampleAnswer(), null, null, 0, -1);
			if(data.size() > 0) {
				
				data.get(0).setSno(sampleAnswer.getSno());
				data.get(0).setAnswer(sampleAnswer.getAnswer());
				data.get(0).setStatus("Deactive");
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
				response.put("message", "Sample Answer updated successfully");
			}else {
				
				sampleAnswer.setStatus("Deactive");
				sampleAnswer.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(sampleAnswer);
				if(i > 0) {
					response.put("status", "Success");
					response.put("message", "Sample Answer Added Successfully");
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

	public Map<String, Object> get_sampleAnswer(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("institution_group", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<SampleAnswer> list = (List<SampleAnswer>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new SampleAnswer(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new SampleAnswer(), "sno", "asc");
			
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

	public Map<String, Object> get_sampleQuestion(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("institution_group", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<SampleQuestion> list = (List<SampleQuestion>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new SampleQuestion(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new SampleQuestion(), "sno", "asc");
			
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

	public Map<String, Object> edit_sampleQ(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<SampleQuestion> list = (List<SampleQuestion>) commonDao.getDataByMap(map, new SampleQuestion(), null, null, 0, -1);
			
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

	public Map<String, Object> edit_sampleA(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<SampleAnswer> list = (List<SampleAnswer>) commonDao.getDataByMap(map, new SampleAnswer(), null, null, 0, -1);
			
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
	

	public Map<String, Object> updateSampleQ(SampleQuestion sampleQuestion) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", sampleQuestion.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(sampleQuestion, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "SampleQuestion", search);
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
	
	public Map<String, Object> updateSampleA(SampleAnswer sampleAnswer) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", sampleAnswer.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(sampleAnswer, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "SampleAnswer", search);
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

	public Map<String, Object> delete_sampleQ(String sno) {
		Map<String, Object> response = new HashMap<String,Object>(); 
		try {
			
				commonDao.delete(new SampleQuestion(), sno);
				response.put("status","Success");
				response.put("message", "Data Deleted Successfully");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Falure");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> delete_sampleA(String sno) {
		Map<String, Object> response = new HashMap<String,Object>(); 
		try {
			
			commonDao.delete(new SampleAnswer(), sno);
			response.put("status","Success");
			response.put("message", "Data Deleted Successfully");
		
		
	} catch (Exception e) {
		e.printStackTrace();
		response.put("status","Falure");
		response.put("message", "Something Went Wrong " +e);
	}
	return response;
	}

}
