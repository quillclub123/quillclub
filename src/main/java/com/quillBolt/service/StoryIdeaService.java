package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.Banner;
import com.quillBolt.model.Classes;
import com.quillBolt.model.DraftStoryIdea;
import com.quillBolt.model.StoryIdea;

@Service
public class StoryIdeaService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_storyidea(StoryIdea storyIdea) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", storyIdea.getStudent_id());
			List<StoryIdea> data = (List<StoryIdea>) commonDao.getDataByMap(map, new StoryIdea(), null, null, 0, -1);
			if (data.size() > 0) {
				if (storyIdea.getStudent_id() != null && !storyIdea.getStudent_id().isEmpty()) {
					data.get(0).setStudent_id(storyIdea.getStudent_id());
				}
				if (storyIdea.getTitle() != null && !storyIdea.getTitle().isEmpty()) {
					data.get(0).setTitle(storyIdea.getTitle());
				}
//				if (storyIdea.getBlurb() != null && !storyIdea.getBlurb().isEmpty()) {
//					data.get(0).setBlurb(storyIdea.getBlurb());
//				}
				if (storyIdea.getStory_idea() != null && !storyIdea.getStory_idea().isEmpty()) {
					data.get(0).setStory_idea(storyIdea.getStory_idea());
				}
				commonDao.updateDataToDb(data.get(0));
				Map<String, Object> mapp = new HashMap<String, Object>();
				mapp.put("student_id", storyIdea.getStudent_id());
				List<DraftStoryIdea> dsi = (List<DraftStoryIdea>) commonDao.getDataByMap(mapp, new DraftStoryIdea(), null, null, 0, -1);
				if(dsi.size() > 0) {
					dsi.get(0).setStatus("Deactive");
					commonDao.updateDataToDb(dsi.get(0));
				}
				response.put("status", "Success");
				response.put("message", "Story Idea Updated Successfully");
			} else {

				storyIdea.setStatus("Active");
				storyIdea.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(storyIdea);
				if (i > 0) {
					Map<String, Object> mapp = new HashMap<String, Object>();
					mapp.put("student_id", storyIdea.getStudent_id());
					List<DraftStoryIdea> dsi = (List<DraftStoryIdea>) commonDao.getDataByMap(mapp, new DraftStoryIdea(), null, null, 0, -1);
					if(dsi.size() > 0) {
						dsi.get(0).setStatus("Deactive");
						commonDao.updateDataToDb(dsi.get(0));
					}else {
						DraftStoryIdea aas = new DraftStoryIdea();
						aas.setStudent_id(storyIdea.getStudent_id());
						aas.setTitle(storyIdea.getTitle());
						aas.setStory_idea(storyIdea.getStory_idea());
						aas.setStatus("Active");
						aas.setCreatedAt(new Date());
						commonDao.addDataToDb(aas);
					}
					response.put("status", "Success");
					response.put("message", "Story Idea Added Successfully");
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

	public Map<String, Object> add_draftstoryidea(DraftStoryIdea storyIdea) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", storyIdea.getStudent_id());
			List<DraftStoryIdea> data = (List<DraftStoryIdea>) commonDao.getDataByMap(map, new DraftStoryIdea(), null, null, 0, -1);
			if (data.size() > 0) {
				if (storyIdea.getStudent_id() != null && !storyIdea.getStudent_id().isEmpty()) {
					data.get(0).setStudent_id(storyIdea.getStudent_id());
				}
				if (storyIdea.getTitle() != null && !storyIdea.getTitle().isEmpty()) {
					data.get(0).setTitle(storyIdea.getTitle());
				}
//				if (storyIdea.getBlurb() != null && !storyIdea.getBlurb().isEmpty()) {
//					data.get(0).setBlurb(storyIdea.getBlurb());
//				}
				if (storyIdea.getStory_idea() != null && !storyIdea.getStory_idea().isEmpty()) {
					data.get(0).setStory_idea(storyIdea.getStory_idea());
				}
				data.get(0).setStatus("Active");
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
			} else {
				storyIdea.setStatus("Active");
				storyIdea.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(storyIdea);
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
	
	public Map<String, Object> get_storyidea(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			List<StoryIdea> classes = (List<StoryIdea>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new StoryIdea(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new StoryIdea(), "sno", "asc");
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

	public Map<String, Object> get_draftstoryidea(String student_id, String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			map.put("status", "Active");
			List<DraftStoryIdea> data = (List<DraftStoryIdea>) commonDao.getDataByMap(map, new DraftStoryIdea(), null, null, 0, -1);
			if (data.size()>0) {
				response.put("data", data);
				response.put("status", "Success");
			}else {
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("student_id", student_id);
				List<StoryIdea> si = (List<StoryIdea>) commonDao.getDataByMap(map1, new StoryIdea(), null, null, 0, -1);
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
