package com.quillBolt.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.Classes;
import com.quillBolt.model.Paper;
import com.quillBolt.model.QuestionPaper;

@Service
public class PaperService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_paper(Paper paper) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			System.out.println("value"+paper.getSchool_id());
			if(paper.getSchool_id() > 0 && paper.getClass_id() > 0) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("school_id", paper.getSchool_id());
				map.put("class_id", paper.getClass_id());
				List<Paper> data = (List<Paper>)commonDao.getDataByMap(map, new Paper(), null, null, 0, -1);
				if(data.size() > 0) {
				QuestionPaper qp = new QuestionPaper();
				qp.setPaper_id(data.get(0).getSno());
				qp.setQuestion_id(Integer.parseInt(paper.getQuestion()));
				qp.setStatus("Active");
				qp.setCreatedAt(new Date(0));
				int k = commonDao.addDataToDb(qp);
				response.put("status", "Success");
				response.put("message", "Paper Added Successfully");
				}else {
				paper.setStatus("Active");
				paper.setCreatedAt(new Date(0));
				int i = commonDao.addDataToDb(paper);
				if(i > 0) {
					QuestionPaper qp = new QuestionPaper();
						qp.setPaper_id(i);
						qp.setQuestion_id(Integer.parseInt(paper.getQuestion()));
						qp.setStatus("Active");
						qp.setCreatedAt(new Date(0));
						int k = commonDao.addDataToDb(qp);
					response.put("status", "Success");
					response.put("message", "Paper Added Successfully");
					
				}else {
					response.put("status", "Failed");
					response.put("message", "Something went Wrong");
				}
			}
		}
			
		}catch(Exception e) {
			response.put("status", "Falure");
			response.put("message", "Something went Wrong"+e);
		}
		return response;
	}

	public Map<String, Object> delete_paper(String question_id, String school_id, String class_id) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("school_id", Integer.parseInt(school_id));
			map.put("class_id", Integer.parseInt(class_id));
			List<Paper> data = (List<Paper>)commonDao.getDataByMap(map, new Paper(), null, null, 0, -1);
			Map<String,Object> mapdata = new HashMap<String,Object>();
			mapdata.put("paper_id", data.get(0).getSno());
			List<QuestionPaper> data1 = (List<QuestionPaper>)commonDao.getDataByMap(mapdata, new QuestionPaper(), null, null, 0, -1);
			if(data1.size() > 1) {
				commonDao.delete(new QuestionPaper(), String.valueOf(data1.get(0).getSno()));
				response.put("status","Success");
				response.put("message", "Paper  Details Deleted Successfully");
			}else{
				commonDao.delete(new QuestionPaper(), String.valueOf(data1.get(0).getSno()));
				commonDao.delete(new Paper(), String.valueOf(data.get(0).getSno()));
				response.put("status","Success");
				response.put("message", "Paper  Details Deleted Successfully");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
}
