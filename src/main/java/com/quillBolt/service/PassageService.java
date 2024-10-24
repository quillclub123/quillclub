package com.quillBolt.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.DraftPassage;
import com.quillBolt.model.DraftedReflections;
import com.quillBolt.model.Passage;

@Service
public class PassageService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_passage(Passage passage) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("student_id", passage.getStudent_id());
				List<Passage> data = (List<Passage>) commonDao.getDataByMap(map, new Passage(), null, null, 0, -1);
				if (data.size() > 0) {
					if (passage.getPassage() != null) {
						data.get(0).setPassage(passage.getPassage());
					}
					commonDao.updateDataToDb(data.get(0));
					Map<String, Object> mapp = new HashMap<String, Object>();
					mapp.put("student_id", passage.getStudent_id());
					List<DraftPassage> dsi = (List<DraftPassage>) commonDao.getDataByMap(mapp, new DraftPassage(), null, null, 0, -1);
					if(dsi.size() > 0) {
						dsi.get(0).setStatus("Deactive");
						commonDao.updateDataToDb(dsi.get(0));
					}else {
						DraftPassage dd = new DraftPassage();
						dd.setGroup_id(passage.getGroup_id());
						dd.setSchool_id(passage.getSchool_id());
						dd.setStudent_id(passage.getStudent_id());
						dd.setPassage(passage.getPassage());
						dd.setStatus("Active");
						dd.setCreatedAt(new Date());
						commonDao.addDataToDb(dd);	
					}
					response.put("status", "Success");
					response.put("message", "Full Author Profile Updated Successfully");
				}else {
					passage.setStatus("Active");
					passage.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(passage);
					if (i > 0) {
						Map<String, Object> mapp = new HashMap<String, Object>();
						mapp.put("student_id", passage.getStudent_id());
						List<DraftPassage> dsi = (List<DraftPassage>) commonDao.getDataByMap(mapp, new DraftPassage(), null, null, 0, -1);
						if(dsi.size() > 0) {
							dsi.get(0).setStatus("Deactive");
							commonDao.updateDataToDb(dsi.get(0));
						}else {
							DraftPassage dd = new DraftPassage();
							dd.setGroup_id(passage.getGroup_id());
							dd.setSchool_id(passage.getSchool_id());
							dd.setStudent_id(passage.getStudent_id());
							dd.setPassage(passage.getPassage());
							dd.setStatus("Active");
							dd.setCreatedAt(new Date());
							
							commonDao.addDataToDb(dd);	
						}
						response.put("status", "Success");
						response.put("message", "Full Author Profile Added Successfully");
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

	public Map<String, Object> add_draftpassage(DraftPassage passage) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("student_id", passage.getStudent_id());
				List<DraftPassage> data = (List<DraftPassage>) commonDao.getDataByMap(map, new DraftPassage(), null, null, 0, -1);
				if (data.size() > 0) {
					if (passage.getPassage() != null) {
						data.get(0).setPassage(passage.getPassage());
					}
					data.get(0).setStatus("Active");
					commonDao.updateDataToDb(data.get(0));
					response.put("status", "Success");
					response.put("message", "Full Author Profile Updated Successfully");
				}else {
					passage.setStatus("Active");
					passage.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(passage);
					if(i > 0) {
						response.put("status", "Success");
						response.put("message", "Passage Added Successfully");
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

	public Map<String, Object> get_passage(String sno, String student_id) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			map.put("status", "Active");
			List<DraftPassage> dp = (List<DraftPassage>)commonDao.getDataByMap(map, new DraftPassage(), null, null, 0, -1);
			if(dp.size() > 0) {
				response.put("data", dp);
				response.put("status", "Success");
			}else {
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("student_id", student_id);
				map1.put("status", "Active");
				List<Passage> ds = (List<Passage>)commonDao.getDataByMap(map1, new Passage(), null, null, 0, -1);
				if(ds.size() > 0) {
					response.put("data", ds);
					response.put("status", "Success");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
}
