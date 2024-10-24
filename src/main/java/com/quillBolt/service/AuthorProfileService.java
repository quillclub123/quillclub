package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.AuthorProfileQuestion;
import com.quillBolt.model.HistoryAPQuestionAnswer;
import com.quillBolt.model.HistoryPQA;
import com.quillBolt.model.ProfileQuestionsAnswer;

@Service
public class AuthorProfileService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_apq(AuthorProfileQuestion authorProfileQuestion) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", authorProfileQuestion.getStudent_id());
			List<AuthorProfileQuestion> ap = (List<AuthorProfileQuestion>) commonDao.getDataByMap(map, new AuthorProfileQuestion(), null, null, 0, -1);
			if (ap.size() > 0) {
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("apq_id", ap.get(0).getSno());
				List<ProfileQuestionsAnswer> pqa1 = (List<ProfileQuestionsAnswer>) commonDao.getDataByMap(map1,new ProfileQuestionsAnswer(), null, null, 0, -1);
				for (ProfileQuestionsAnswer p : pqa1) {
					HistoryPQA hpqa = new HistoryPQA();
					hpqa.setApq_id(p.getApq_id());
					hpqa.setQuestion_id(p.getQuestion_id());
					hpqa.setAnswer(p.getAnswer());
					hpqa.setSeq_no(p.getSeq_no());
					hpqa.setStatus("Active");
					hpqa.setCreatedAt(new Date());
					commonDao.addDataToDb(hpqa);
				}

				commonDao.deleteAuthorQuestionAnswer(ap.get(0).getSno());
				List<ProfileQuestionsAnswer> pqa = authorProfileQuestion.getPs();
				for (ProfileQuestionsAnswer p : pqa) {
					if(p.getAnswer() != null && !p.getAnswer().isEmpty()) {
						p.setApq_id(ap.get(0).getSno());
						p.setQuestion_id(p.getQuestion_id());
						p.setAnswer(p.getAnswer());
						p.setSeq_no(p.getSeq_no());
						p.setStatus("Active");
						p.setCreatedAt(new Date());
						commonDao.addDataToDb(p);
					}
				}
				response.put("status", "Success");
				response.put("message", "Updated Successfully");
			} else {
				authorProfileQuestion.setStatus("Active");
				authorProfileQuestion.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(authorProfileQuestion);
				if (i > 0) {
					List<ProfileQuestionsAnswer> pqa = authorProfileQuestion.getPs();
					for (ProfileQuestionsAnswer p : pqa) {
						if(p.getAnswer() != null && !p.getAnswer().isEmpty()) {
							p.setApq_id(i);
							p.setQuestion_id(p.getQuestion_id());
							p.setAnswer(p.getAnswer());
							p.setSeq_no(p.getSeq_no());
							p.setStatus("Active");
							p.setCreatedAt(new Date());
							commonDao.addDataToDb(p);
						}
					}
					response.put("status", "Success");
					response.put("message", "Added Successfully");
				} else {
					response.put("status", "Failed");
					response.put("message", "Something went wrong");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Internal server Error" + e);
		}
		return response;
	}

	public Map<String, Object> get_apq(int start, int length, String search) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> get_qa(String sno) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("apq_id", Integer.parseInt(sno));
			List<ProfileQuestionsAnswer> pqa = (List<ProfileQuestionsAnswer>) commonDao.getDataByMap(map,new ProfileQuestionsAnswer(), "question_id", "desc", 0, -1);
			if(pqa.size() > 0) {
				response.put("data", pqa);
				response.put("status", "Success");
				response.put("message", "Data fetch Successfully");
			}else {
				response.put("status", "Failed");
				response.put("message", "Something went wrong");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Internal server Error" + e);
		}
		return response;
	}

}
