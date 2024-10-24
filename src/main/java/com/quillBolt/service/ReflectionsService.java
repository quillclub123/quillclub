package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.DraftedReflections;
import com.quillBolt.model.Reflections;
import com.quillBolt.model.Reflections;

@Service
public class ReflectionsService {

	@Autowired
	CommonDao commonDao;
	
	public Map<String, Object> add_reflection(Reflections reflections) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", reflections.getStudent_id());
			List<Reflections> data = (List<Reflections>) commonDao.getDataByMap(map, new Reflections(), null, null, 0, -1);
			if (data.size() > 0) {
				if (reflections.getStudent_id() != null && !reflections.getStudent_id().isEmpty()) {
					data.get(0).setStudent_id(reflections.getStudent_id());
				}
				if (reflections.getReflection() != null && !reflections.getReflection().isEmpty()) {
					data.get(0).setReflection(reflections.getReflection());
				}
				commonDao.updateDataToDb(data.get(0));
				Map<String, Object> mapp = new HashMap<String, Object>();
				mapp.put("student_id", reflections.getStudent_id());
				List<DraftedReflections> dsi = (List<DraftedReflections>) commonDao.getDataByMap(mapp, new DraftedReflections(), null, null, 0, -1);
				if(dsi.size() > 0) {
					dsi.get(0).setStatus("Deactive");
					commonDao.updateDataToDb(dsi.get(0));
				}
				response.put("status", "Success");
				response.put("message", "Reflections Updated Successfully");
			} else {

				reflections.setStatus("Active");
				reflections.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(reflections);
				if (i > 0) {
					Map<String, Object> mapp = new HashMap<String, Object>();
					mapp.put("student_id", reflections.getStudent_id());
					List<DraftedReflections> dsi = (List<DraftedReflections>) commonDao.getDataByMap(mapp, new DraftedReflections(), null, null, 0, -1);
					if(dsi.size() > 0) {
						dsi.get(0).setStatus("Deactive");
						commonDao.updateDataToDb(dsi.get(0));
					}else {
						DraftedReflections dd = new DraftedReflections();
						dd.setGroup_id(reflections.getGroup_id());
						dd.setSchool_id(reflections.getSchool_id());
						dd.setStudent_id(reflections.getStudent_id());
						dd.setReflection(reflections.getReflection());
						dd.setStatus("Active");
						dd.setCreatedAt(new Date());
						
						commonDao.addDataToDb(dd);	
					}
					response.put("status", "Success");
					response.put("message", "Reflections Added Successfully");
				} else {
					response.put("status", "Failure");
					response.put("message", "Something Went Wrong");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Something Went Wrong " + e);
		}
		return response;
	}

	public Map<String, Object> add_draftreflection(DraftedReflections reflections) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", reflections.getStudent_id());
			List<DraftedReflections> data = (List<DraftedReflections>) commonDao.getDataByMap(map, new DraftedReflections(), null, null, 0, -1);
			if (data.size() > 0) {
				if (reflections.getStudent_id() != null && !reflections.getStudent_id().isEmpty()) {
					data.get(0).setStudent_id(reflections.getStudent_id());
				}
				
				if (reflections.getReflection() != null && !reflections.getReflection().isEmpty()) {
					data.get(0).setReflection(reflections.getReflection());
				}
				data.get(0).setStatus("Active");
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
			} else {
				reflections.setStatus("Active");
				reflections.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(reflections);
				if (i > 0) {
					response.put("status", "Success");
				} else {
					response.put("status", "Failure");
					response.put("message", "Something Went Wrong");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Something Went Wrong " + e);
		}
		return response;
	}
	
	public Map<String, Object> get_reflection(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			List<Reflections> classes = (List<Reflections>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new Reflections(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new Reflections(), "sno", "asc");
			if (classes.size()>0) {
				response.put("data", classes);
				response.put("recordsFiltered", count);
				response.put("recordsTotal", count);
				response.put("status", "Success");
			}else {
				response.put("data", new ArrayList());
				response.put("recordsFiltered", 0);
				response.put("recordsTotal", 0);
				response.put("status","Failed");
			}
		} catch (Exception e) {
			response.put("data", new ArrayList());
			response.put("recordsFiltered", 0);
			response.put("recordsTotal", 0);
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
		}
		return response;
	}

	public Map<String, Object> get_draftreflection(String student_id, String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			map.put("status", "Active");
			List<DraftedReflections> data = (List<DraftedReflections>) commonDao.getDataByMap(map, new DraftedReflections(), null, null, 0, -1);
			if (data.size()>0) {
				response.put("data", data);
				response.put("status", "Success");
			}else {
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("student_id", student_id);
				List<Reflections> si = (List<Reflections>) commonDao.getDataByMap(map1, new Reflections(), null, null, 0, -1);
				response.put("data", si);
				response.put("status", "Success");
			}
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
		}
		return response;
	}
}
