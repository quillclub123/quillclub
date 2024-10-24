package com.quillBolt.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.common.EmailMessage;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.Answers;
import com.quillBolt.model.Classes;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Questions;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;

@Service
public class AnswersService {

	@Autowired
	CommonDao commonDao;
	@Autowired
	EmailMessage email;
	public Map<String, Object> add_answer(Answers answers) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			String[] aw = answers.getAnswer().split(" ");
			System.out.println("Length="+aw.length);
			if(aw.length > 90) {
				response.put("status","Failed");
				response.put("message", "You can write only 90 words answer.");
			}else {
				answers.setStatus("Active");
				answers.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(answers);
				if (i>0) {
					String name = answers.getEmail(); 
					 Map<String,String> map = new HashMap<String,String>();
						 map.put("username","##");
						 map.put("password","quillclub"); 
						 boolean a = email.sendEmailMessage("Answer Submition", map, name,i);
					response.put("status","Success");
					response.put("message", "Answer Added Successfuly");
				}else {
					response.put("status","Failure");
					response.put("message", "Something Went Wrong");
			}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Internal Server Error " +e);
		}
		return response;
	}
	public Map<String, Object> get_answer(int start, int length, String search, String name, String class_name, String section, String group_id, String school_id, String createdAt) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map4 = new HashMap<String,Object>();
			if(name != null && !name.isEmpty()) {
				map4.put("name", name);
			}
			if(class_name != null && !class_name.isEmpty()) {
				map4.put("class_name", class_name);
			}
			if(section != null && !section.isEmpty()) {
				map4.put("section", section);
			}
			if(group_id != null && !group_id.isEmpty()) {
				map4.put("group_id", Integer.parseInt(group_id));
			}
			if(school_id != null && !school_id.isEmpty()) {
				map4.put("school_id", Integer.parseInt(school_id));
			}
			if(createdAt != null && !createdAt.isEmpty()) {  
				map4.put("createdAt", createdAt);
			}
			
			
			Map<String,Object> map3 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map3.put("name", search);
				map3.put("answer", search);
			}
			List<Answers> answer = (List<Answers>) commonDao.getDataByMapSearchAnd(map4,map3, new Answers(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map3, new Answers(), "sno", "asc");
			if (answer.size() >0) {
				for(Answers s : answer) {
					Map<String, Object> map = new HashMap<String,Object>();
					Map<String, Object> map1 = new HashMap<String,Object>();
					Map<String, Object> map2 = new HashMap<String,Object>();
					//Map<String, Object> map4 = new HashMap<String,Object>();
					map.put("sno", s.getGroup_id());
					map1.put("sno", s.getSchool_id());
//					map2.put("sno", s.getClass_id());
//					map4.put("sno", s.getSection_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
//					List<Classes> data2 = (List<Classes>)commonDao.getDataByMap(map2, new Classes(), null, null, 0, -1);
//					List<Section> data3 = (List<Section>)commonDao.getDataByMap(map4, new Section(), null, null, 0, -1);
					s.setGroup(data.get(0).getInstitution_group());
					s.setSchool(data1.get(0).getSchool_name());
					//s.setClassName(data2.get(0).getClasses());
					//s.setSection(data3.get(0).getSection_name());
				}
				response.put("data", answer);
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
	public Map<String, Object> get_answerdata(String sno) {
		Map<String,Object> response = new HashMap<String, Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Answers> data = (List<Answers>)commonDao.getDataByMap(map, new Answers(), null, null, 0, -1);
			if(data.size() > 0 ) {
				response.put("data", data);
				response.put("status", "Success");
				response.put("message", "Data fetch successfully");
			}else {
				response.put("status", "Failed");
				response.put("message", "Something went wrong");
			}
			
		}catch(Exception e) {
			
		}
		return response;
	}
	public Map<String, Object> get_shortlisted_students(String group_id, String school_id, String class_name,
			String section) {
		Map<String,Object> response = new HashMap<String, Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("group_id", Integer.parseInt(group_id));
			if(school_id != null && !school_id.isEmpty()) {
				map.put("school_id", Integer.parseInt(school_id));
			}
			if(class_name != null && !class_name.isEmpty()) {
				map.put("class_name", class_name);
			}
			if(!section.equalsIgnoreCase("null") && !section.isEmpty()) {
				map.put("section", section);
			}
			map.put("status", "Active");
			List<Answers> data = (List<Answers>)commonDao.getDataByMap(map, new Answers(), null, null, 0, -1);
			if(data.size() > 0 ) {
				response.put("data", data);
				response.put("status", "Success");
				response.put("message", "Data fetch successfully");
			}else {
				response.put("status", "Failed");
				response.put("message", "Something went wrong");
			}
			
		}catch(Exception e) {
			
		}
		return response;
	}

}
