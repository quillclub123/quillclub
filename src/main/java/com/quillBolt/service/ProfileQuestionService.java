package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.ProfileQuestions;
import com.quillBolt.model.QuestionList;
import com.quillBolt.model.Schools;
import com.quillBolt.model.SelectedStudent;

@Service
public class ProfileQuestionService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_profile_question(ProfileQuestions question) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			if(question.getSno() > 0) {
				commonDao.deleteprofilquestion(question.getSno());
				List<QuestionList> qlist = question.getQlist();
				for(int i=0; i < qlist.size(); i++){
					QuestionList qlst = new QuestionList();
					qlst.setQ_id(question.getSno());
					qlst.setSeq_no(qlist.get(i).getSeq_no());
					qlst.setQuestion(qlist.get(i).getQuestion());
					commonDao.addDataToDb(qlst);
				}
				response.put("status", "Success");
				response.put("message", "Author Profile Questions Updated successfully");
			}else {
				question.setStatus("Active");
				question.setCreatedAt(new Date());
				int j = commonDao.addDataToDb(question);
				if(j > 0) {

					List<QuestionList> qlist = question.getQlist();
					for(int i=0; i < qlist.size(); i++){
						QuestionList qlst = new QuestionList();
						qlst.setQ_id(j);
						qlst.setSeq_no(qlist.get(i).getSeq_no());
						qlst.setQuestion(qlist.get(i).getQuestion());
						commonDao.addDataToDb(qlst);
					}
					response.put("status", "Success");
					response.put("message", "Author Profile Question added successfully");
				}else {
					response.put("status", "Failed");
					response.put("message", "Something went wrong");
				}
			}
		} catch (Exception e) {
			response.put("Failure", "Internal Server Error");
			e.printStackTrace();
		}
		return response;
	}

	public Map<String, Object> get_profile_questions(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("status", search);
			}
			List<ProfileQuestions> list = (List<ProfileQuestions>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new ProfileQuestions(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new ProfileQuestions(), "sno", "asc");
			if(list.size()>0) {
				for(int i =0; i <list.size(); i++) {
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", list.get(i).getGroup_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map1, new InstituitonGroup(), null, null, 0, -1);
					list.get(i).setGroup_name(data.get(0).getInstitution_group());
					
					Map<String, Object> map2 = new HashMap<String,Object>();
					map2.put("sno", list.get(i).getSchool_id());
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map2, new Schools(), null, null, 0, -1);
					list.get(i).setSchool_name(data1.get(0).getSchool_name());
				}
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

	public Map<String, Object> get_question_list(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> mp = new HashMap<String,Object>();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("q_id", Integer.parseInt(sno));
			mp.put("sno", Integer.parseInt(sno));
			List<ProfileQuestions> pd = (List<ProfileQuestions>) commonDao.getDataByMap(mp, new ProfileQuestions(), null, null, 0, -1);	
			List<QuestionList> list = (List<QuestionList>) commonDao.getDataByMap(map, new QuestionList(), "seq_no", "desc", 0, -1);	
			if(list.size()>0) {
				response.put("pdata", pd);
				response.put("data", list);
				response.put("status", "Success");
			}else {
				response.put("data", new ArrayList());
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
}
