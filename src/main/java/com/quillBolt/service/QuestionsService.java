package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.quillBolt.utils.Utils;

import javassist.expr.NewArray;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.quillBolt.controller.QuestionsController;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.Classes;
import com.quillBolt.model.DeletedQuestionClassWise;
import com.quillBolt.model.DeletedQuestionPaper;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Paper;
import com.quillBolt.model.QuestionClassWise;
import com.quillBolt.model.QuestionDeletedHistory;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Questions;

@Service
public class QuestionsService {

	@Autowired
	CommonDao commonDao;
	
	public Map<String, Object> add_question(Questions questiondata, MultipartFile question_image) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			Utils utils = new Utils();
			Map<String, Object> map = new HashMap<String,Object>();
			Map<String, Object> map1 = new HashMap<String,Object>();
			map.put("sno", questiondata.getSno());
			map1.put("question_id", questiondata.getSno());
			List<Questions> data = (List<Questions>)commonDao.getDataByMap(map, new Questions(), null, null, 0, -1);
			List<QuestionClassWise> data1 = (List<QuestionClassWise>)commonDao.getDataByMap(map1, new QuestionClassWise(), null, null, 0, -1);
			if(data.size() > 0) {
				for(QuestionClassWise a : data1) {
					commonDao.delete(new QuestionClassWise(), String.valueOf(a.getSno()));
				}
				QuestionClassWise qcw = new QuestionClassWise();
				String class_name = questiondata.getClass_name();
				String[] cn = class_name.split(",");
				for(int j = 0; j < cn.length; j++) {
					qcw.setQuestion_id(questiondata.getSno());
					qcw.setClass_name(cn[j]);
					qcw.setStatus("Active");
					qcw.setCreatedAt(new Date());
					int k = commonDao.addDataToDb(qcw);
				}
				if(question_image != null && !question_image.isEmpty()) {
					String qimg = utils.uploadImage(question_image);
					data.get(0).setQuestion_image(qimg);
				}
				data.get(0).setSno(questiondata.getSno());
				data.get(0).setTitle(questiondata.getTitle());
				data.get(0).setInstructionHeadingQ(questiondata.getInstructionHeadingQ());
				data.get(0).setQuotes(questiondata.getQuotes());
				data.get(0).setInstructionQ(questiondata.getInstructionQ());
				data.get(0).setInstructionHeadingA(questiondata.getInstructionHeadingA());
				data.get(0).setInstructionA(questiondata.getInstructionA());
				data.get(0).setQuestion(questiondata.getQuestion());
				data.get(0).setStatus("Active");
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				response.put("status", "Success");
				response.put("message", "Question updated successfully");
			}else {
				

				if(question_image != null && !question_image.isEmpty()) {
					String qimg = utils.uploadImage(question_image);
					questiondata.setQuestion_image(qimg);
				}
				questiondata.setStatus("Active");
				questiondata.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(questiondata);
				if(i > 0) {
					QuestionClassWise qcw = new QuestionClassWise();
					String class_name = questiondata.getClass_name();
					String[] cn = class_name.split(",");
					for(int j = 0; j < cn.length; j++) {
						qcw.setQuestion_id(i);
						qcw.setClass_name(cn[j]);
						qcw.setStatus("Active");
						qcw.setCreatedAt(new Date());
						int k = commonDao.addDataToDb(qcw);
					}
					response.put("status", "Success");
					response.put("message", "Question Added Successfully");
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

	public Map<String, Object> get_quetion(int start, int length,String search,String imgdata) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map4 = new HashMap<String,Object>();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("questionImgType", imgdata);
			if(search != null && !search.isEmpty()) {
				map4.put("title", search);
				map4.put("question", search);
			}
		
				List<Questions> list = (List<Questions>) commonDao.getDataByMapSearchAnd(map,map4, new Questions(), "sno", "desc", start, length);
				int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map4,new Questions(),"sno", "asc");
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
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> delete_question(String sno) {
		Map<String, Object> response = new HashMap<String,Object>(); 
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Questions> qdata = (List<Questions>)commonDao.getDataByMap(map, new Questions(), null, null, 0, -1);
			QuestionDeletedHistory qdh = new QuestionDeletedHistory();
			qdh.setQuestion_id(qdata.get(0).getSno());
			qdh.setTitle(qdata.get(0).getTitle());
			qdh.setQuestion(qdata.get(0).getQuestion());
			qdh.setQuestion_image(qdata.get(0).getQuestion_image());
			qdh.setStatus("Active");
			qdh.setCreatedAt(new Date());
			int i = commonDao.addDataToDb(qdh);
			if(i > 0) {
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("question_id", Integer.parseInt(sno));
				List<QuestionClassWise> qcw = (List<QuestionClassWise>)commonDao.getDataByMap(map1, new QuestionClassWise(), null, null, 0, -1);
				if(qcw.size() > 0) {
					DeletedQuestionClassWise dqcw = new DeletedQuestionClassWise();
					for(QuestionClassWise q : qcw) {
						dqcw.setQuestion_class_wise_id(q.getSno());
						dqcw.setQuestion_id(q.getQuestion_id());
						dqcw.setClass_name(q.getClass_name());
						dqcw.setStatus(q.getStatus());
						dqcw.setCreatedAt(new Date());
						int j = commonDao.addDataToDb(dqcw);
						if(j > 0) {
							commonDao.delete(new QuestionClassWise(), String.valueOf(q.getSno()));
						}
					}
				}
				commonDao.delete(new Questions(), sno);
				response.put("status","Success");
				response.put("message", "Data Deleted Successfully");
			}else {
				response.put("status","Failed");
				response.put("message", "Something went wrong");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Falure");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> edit_question(String sno) {
		Map<String,Object> response = new HashMap<String, Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Questions> data = (List<Questions>)commonDao.getDataByMap(map, new Questions(), null, null, 0, -1);
			if(data.size() > 0 ) {
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("question_id", data.get(0).getSno());
				List<String> cname= new ArrayList<String>();
				List<QuestionClassWise> data1 = (List<QuestionClassWise>)commonDao.getDataByMap(map1, new QuestionClassWise(), null, null, 0, -1);
				if(data1.size() > 0) {
					for(QuestionClassWise qcs : data1) {
						cname.add(qcs.getClass_name());
					}
				}
				response.put("cname", cname);
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

	public Map<String, Object> get_questionforPaper(int start, int length, String search, int school_id, int class_id, String imgdata) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			List<Questions> qdata = (List<Questions>)commonDao.getDataByMap(response, new Questions(), null, null, 0, -1);
			
			Map<String,Object> map4 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map4.put("title", search);
				map4.put("question", search);
			}
			Map<String,Object> mapdata = new HashMap<String,Object>();
			if(school_id == 0 && class_id == 0) {
				mapdata.put("questionImgType", imgdata);
				List<Questions> list = (List<Questions>) commonDao.getDataByMapSearchAnd(mapdata,map4, new Questions(), "sno", "desc", start, length);
				int count = commonDao.getDataByMapSearchAndSize(mapdata,map4,new Questions(),"sno", "asc");
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
				
			
			}else {
				Map<String, Object> map = new HashMap<String,Object>();
				Map<String, Object> map5 = new HashMap<String,Object>();
				map5.put("school_id", school_id);
				map5.put("sno", class_id);
				if(school_id > 0) {
					map.put("school_id", school_id);
				
				}
				
				List<Classes> clss = (List<Classes>)commonDao.getDataByMap(map5, new Classes(), null, null, 0, -1);
				if(class_id > 0) {
					map.put("class_id", class_id);
					
				}
				System.out.println("imgType="+clss.get(0).getImageType());
				List<Paper> papers = (List<Paper>) commonDao.getDataByMap(map, new Paper(), null, null, 0, -1);
				if(papers.size() > 0) {
					mapdata.put("questionImgType", clss.get(0).getImageType());
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("paper_id", papers.get(0).getSno());
					List<QuestionPaper> questionPapers = (List<QuestionPaper>) commonDao.getDataByMap(map1, new QuestionPaper(), null, null, 0, -1);
					System.out.println("size="+questionPapers.size());
					List<Questions> questions = new ArrayList<Questions>();
					List<Questions> allQuestions = (List<Questions>) commonDao.getDataByMap(mapdata, new Questions(), null, null, 0, -1);
					List<Questions> q1 = allQuestions.stream().filter(two -> questionPapers.stream().anyMatch(data -> data.getQuestion_id().equals(two.getSno()))).collect(Collectors.toList());
					for(Questions q : q1) {
						q.setCommonQuestion("on");
					}
					System.out.println("value="+q1.size());
					questions.addAll(q1);
					List<Questions> q2 = allQuestions.stream().filter(two -> questionPapers.stream().noneMatch(data -> data.getQuestion_id().equals(two.getSno()))).collect(Collectors.toList());
					System.out.println("value1="+q2.size());
					questions.addAll(q2);
					int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map4,new Questions(),"sno", "asc");
					response.put("data", questions);
					response.put("recordsFiltered", count);
					response.put("recordsTotal", count);
					response.put("status", "Success");
				}
				else {
					mapdata.put("questionImgType", clss.get(0).getImageType());
					List<Questions> list = (List<Questions>) commonDao.getDataByMapSearchAnd(mapdata,map4, new Questions(), "sno", "desc", start, length);
					int count = commonDao.getDataByMapSearchAndSize(mapdata,map4,new Questions(),"sno", "asc");
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
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> get_Deletedquestion(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map4 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map4.put("title", search);
				map4.put("question", search);
			}
				List<QuestionDeletedHistory> list = (List<QuestionDeletedHistory>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map4, new QuestionDeletedHistory(), "sno", "desc", start, length);
				int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map4,new QuestionDeletedHistory(),"sno", "asc");
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
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> updateQuestion(Questions questions) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", questions.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(questions, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "Questions", search);
			if (id > 0) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("question_id", questions.getSno());
				List<QuestionClassWise> qqqq = (List<QuestionClassWise>)commonDao.getDataByMap(map, new QuestionClassWise(), null, null,0, -1);
				if(qqqq.size() > 0) {
					for(QuestionClassWise q : qqqq) {
						Map<String, Object> search1 = new HashMap<String, Object>();
						search1.put("sno", q.getSno());
						// object mapper to convert the class object to map
						ObjectMapper mapObject1 = new ObjectMapper();
					
						Map<String, Object> mapObj1 = mapObject1.convertValue(new QuestionClassWise(), Map.class);
						mapObj1.put("status", questions.getStatus());
						// updating the fields
						int id1 = commonDao.updateMethodForAll(mapObj1, "QuestionClassWise", search1);
					}
				}
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
