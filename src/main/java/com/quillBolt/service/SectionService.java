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
import com.quillBolt.model.Answers;
import com.quillBolt.model.Classes;
import com.quillBolt.model.DeletedAnswer;
import com.quillBolt.model.DeletedClasses;
import com.quillBolt.model.DeletedGroup;
import com.quillBolt.model.DeletedPaper;
import com.quillBolt.model.DeletedQuestionPaper;
import com.quillBolt.model.DeletedSchools;
import com.quillBolt.model.DeletedSection;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Paper;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;

@Service
public class SectionService {

	@Autowired
	CommonDao commonDao;
	
	public Map<String,Object> add_section(Section section){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			if(section.getSno() >0) {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno", section.getSno());
				List<Section> sections = (List<Section>) commonDao.getDataByMap(map, new Section(), null, null, 0, -1);
				if(sections.size() >0) {
					if(section.getInstitution_group_id() >0) {
						sections.get(0).setInstitution_group_id(section.getInstitution_group_id());
					}
					if(section.getSchool_id() >0) {
						sections.get(0).setSchool_id(section.getSchool_id());
					}
					if(section.getClass_id() >0) {
						sections.get(0).setClass_id(section.getClass_id());
					}
					if(!section.getSection_name().equals("")) {
						sections.get(0).setSection_name(section.getSection_name());
					}
					sections.get(0).setUpdatedAt(new Date());
					commonDao.updateDataToDb(sections.get(0));
					response.put("status","Success");
					response.put("message", "Section Updated Successfully");
				}
			}else {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("section_name", section.getSection_name());
				List<Section> data = (List<Section>) commonDao.getDataByMap(map, new Section(), null, null, 0, -1);
				if(data.size() >0) {
					response.put("status","Already_Exist");
					response.put("message", "Section Already Exist");
				}else {
					section.setStatus("Active");
					section.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(section);
					if(i>0) {
						response.put("status","Success");
						response.put("message", "Section Added Successfully");
					}else {
						response.put("status","Failure");
						response.put("message", "Something Went Wrong");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
	
	
	public Map<String, Object> get_section(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map3 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map3.put("section_name", search);
				map3.put("status", search);
			}
			List<Section> section = (List<Section>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map3, new Section(), "sno", "asc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map3, new Section(), "sno", "asc");
			if (section.size() >0) {
				response.put("data", section);
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
	public Map<String, Object> get_deletedsection(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map3 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map3.put("section_name", search);
				map3.put("school_name", search);
				map3.put("status", search);
			}
			List<DeletedSection> section = (List<DeletedSection>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map3, new DeletedSection(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map3, new DeletedSection(), "sno", "asc");
			if (section.size() >0) {
				for(DeletedSection c : section) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", c.getInstitution_group_id());
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", c.getSchool_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					if(data.size() > 0) {
						c.setInstitution_group(data.get(0).getInstitution_group());
					}else {
						Map<String, Object> map2 = new HashMap<String,Object>();
						map2.put("group_id", c.getInstitution_group_id());
						List<DeletedGroup> data2 = (List<DeletedGroup>)commonDao.getDataByMap(map2, new DeletedGroup(), null, null, 0, -1);
						if(data2.size() > 0) {
							c.setInstitution_group(data2.get(0).getInstitution_group());
						}
					}
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
					if(data1.size() > 0) {
						c.setSchool_name(data1.get(0).getSchool_name());
					}else {
						Map<String, Object> map2 = new HashMap<String,Object>();
						map2.put("school_id", c.getSchool_id());
						List<DeletedSchools> data2 = (List<DeletedSchools>)commonDao.getDataByMap(map2, new DeletedSchools(), null, null, 0, -1);
						if(data2.size() > 0) {
							c.setSchool_name(data2.get(0).getSchool_name());
						}
					}
					
					Map<String, Object> map2 = new HashMap<String,Object>();
					map2.put("sno", c.getClass_id());
					List<Classes> data2 = (List<Classes>)commonDao.getDataByMap(map2, new Classes(), null, null, 0, -1);
					if(data2.size() > 0) {
						c.setClass_name(data2.get(0).getClasses());
					}else {
						Map<String, Object> map4 = new HashMap<String,Object>();
						map4.put("school_id", c.getSchool_id());
						List<DeletedClasses> data3 = (List<DeletedClasses>)commonDao.getDataByMap(map4, new DeletedClasses(), null, null, 0, -1);
						if(data3.size() > 0) {
							c.setClass_name(data3.get(0).getClasses());
						}
					}
					
				}
				
				response.put("data", section);
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
	
	public Map<String, Object> delete_section(String sno){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Section> section =(List<Section>)commonDao.getDataByMap(map, new Section(), null, null, 0, -1);
			if(section.size() > 0) {
				DeletedSection ds = new DeletedSection();
					ds.setSection_id(section.get(0).getSno());
					ds.setSection_name(section.get(0).getSection_name());
					ds.setStatus(section.get(0).getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
			}
			commonDao.delete(new Section(), sno);
			response.put("status","Success");
			response.put("message", "Sections Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}


	public Map<String, Object> edit_section(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Section> section = (List<Section>) commonDao.getDataByMap(map, new Section(), null, null, 0, -1);
			if (section.size() >0) {
				response.put("status","Success");
				response.put("message", "Sections Fetched Successfully");
				response.put("data", section);
			}else {
				response.put("status","Failure");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}


	public Map<String, Object> getSectiondata(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("class_id", Integer.parseInt(sno));
			List<Section> section = (List<Section>) commonDao.getDataByMap(map, new Section(), null, null, 0, -1);
			if (section.size() >0) {
				response.put("status","Success");
				response.put("message", "Sections Fetched Successfully");
				response.put("data", section);
			}else {
				response.put("status","Failure");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}


	public Map<String, Object> updateSection(Section section) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", section.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(section, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "Section", search);
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

}
