package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.DraftStory;
import com.quillBolt.model.DraftStoryIdea;
import com.quillBolt.model.Story;
import com.quillBolt.model.StoryIdea;

@Service
public class StoryService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_story(Story story) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", story.getStudent_id());
			List<Story> data = (List<Story>) commonDao.getDataByMap(map, new Story(), null, null, 0, -1);
			if (data.size() > 0) {
				if (story.getTitle() != null && !story.getTitle().isEmpty()) {
					data.get(0).setTitle(story.getTitle());
				}
				if (story.getBlurb() != null && !story.getBlurb().isEmpty()) {
					data.get(0).setBlurb(story.getBlurb());
				}
				if (story.getFull_story() != null && !story.getFull_story().isEmpty()) {
					data.get(0).setFull_story(story.getFull_story());
				}
				
				commonDao.updateDataToDb(data.get(0));
				Map<String, Object> mapp = new HashMap<String, Object>();
				mapp.put("student_id", story.getStudent_id());
				List<DraftStory> dat = (List<DraftStory>) commonDao.getDataByMap(mapp, new DraftStory(), null, null, 0, -1);
				if(dat.size() > 0) {
					dat.get(0).setStatus("Deactive");
					commonDao.updateDataToDb(dat.get(0));
				}
				response.put("status", "Success");
				response.put("message", "Story Updated Successfully");
			} else {

				story.setStatus("Active");
				story.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(story);
				if (i > 0) {
					Map<String, Object> mapp = new HashMap<String, Object>();
					mapp.put("student_id", story.getStudent_id());
					List<DraftStory> dat = (List<DraftStory>) commonDao.getDataByMap(mapp, new DraftStory(), null, null, 0, -1);
					if(dat.size() > 0) {
						dat.get(0).setStatus("Deactive");
						commonDao.updateDataToDb(dat.get(0));
					}else {
						DraftStory aas = new DraftStory();
						aas.setStudent_id(story.getStudent_id());
						aas.setTitle(story.getTitle());
						aas.setBlurb(story.getBlurb());
						aas.setFull_story(story.getFull_story());
						aas.setStatus("Active");
						aas.setCreatedAt(new Date());
						commonDao.addDataToDb(aas);
					}
					response.put("status", "Success");
					response.put("message", "Story Added Successfully");
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

	public Map<String, Object> add_draftstory(DraftStory story) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", story.getStudent_id());
			List<DraftStory> data = (List<DraftStory>) commonDao.getDataByMap(map, new DraftStory(), null, null, 0, -1);
			if (data.size() > 0) {
				if (story.getTitle() != null && !story.getTitle().isEmpty()) {
					data.get(0).setTitle(story.getTitle());
				}
				if (story.getBlurb() != null && !story.getBlurb().isEmpty()) {
					data.get(0).setBlurb(story.getBlurb());
				}
				if (story.getFull_story() != null && !story.getFull_story().isEmpty()) {
					data.get(0).setFull_story(story.getFull_story());
				}
				
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
			} else {

				story.setStatus("Active");
				story.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(story);
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

	public Map<String, Object> get_story(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			List<Story> classes = (List<Story>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new Story(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new Story(), "sno", "asc");
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

	public Map<String, Object> get_draftstory(String student_id, String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			map.put("status", "Active");
			List<DraftStory> data = (List<DraftStory>) commonDao.getDataByMap(map, new DraftStory(), null, null, 0, -1);
			if (data.size()>0) {
				response.put("data", data);
				response.put("status", "Success");
			}else {
				Map<String,Object> mapp = new HashMap<String,Object>();
				mapp.put("student_id", student_id);
				List<Story> stry = (List<Story>) commonDao.getDataByMap(mapp, new Story(), null, null, 0, -1);
				response.put("data", stry);
				response.put("status", "Success");
			}
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
		}
		return response;
	}
}
