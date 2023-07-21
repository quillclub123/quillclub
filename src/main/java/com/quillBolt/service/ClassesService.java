package com.quillBolt.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
import com.quillBolt.model.DeletedmailTemplate;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.MailTemplate;
import com.quillBolt.model.Paper;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;
import com.quillBolt.utils.Utils;

import javassist.expr.NewArray;

@Service
public class ClassesService {

	@Autowired
	CommonDao commonDao;
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public Map<String, Object> add_class(Classes classes){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			if(classes.getSno()>0){
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno", classes.getSno());
				List<Classes> data = (List<Classes>) commonDao.getDataByMap(map, new Classes(), null, null, 0, -1);
				if(data.size()>0) {
					if(classes.getInstitution_group_id() >0) {
						data.get(0).setInstitution_group_id(classes.getInstitution_group_id());
					}if(classes.getSchool_id() >0) {
						data.get(0).setSchool_id(classes.getSchool_id());
					}
					if(classes.getClasses() != null) {
						data.get(0).setClasses(classes.getClasses());
					}
					data.get(0).setUpdatedAt(new Date());
					commonDao.updateDataToDb(data.get(0));
					response.put("status","Success");
					response.put("message", "Class Updated Successfully");
				}
			}else {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("institution_group_id", classes.getInstitution_group_id());
				map.put("school_id", classes.getSchool_id());
				map.put("classes", classes.getClasses());
				List<Classes> classes2 = (List<Classes>) commonDao.getDataByMap(map, new Classes(), null, null, 0, -1);
				if(classes2.size() >0) {
					response.put("status","Already_Exist");
					response.put("message", "This Class Already Exist for this School");
				}else {
					classes.setStatus("Active");
					classes.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(classes);
					if (i>0) {
						response.put("status","Success");
						response.put("message", "Class Added Successfully");
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
	
	public Map<String, Object> get_class(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map2.put("institution_group", search);
				map2.put("status", search);
			}
			List<Classes> classes = (List<Classes>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new Classes(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new Classes(), "sno", "asc");
			if (classes.size()>0) {
				for(Classes c : classes) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", c.getInstitution_group_id());
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", c.getSchool_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
					c.setInstitution_group(data.get(0).getInstitution_group());
					c.setSchool_name(data1.get(0).getSchool_name());
				}
				response.put("data", classes);
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
	public Map<String, Object> get_deletedclass(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map2.put("institution_group", search);
				map2.put("status", search);
			}
			List<DeletedClasses> classes = (List<DeletedClasses>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new DeletedClasses(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new DeletedClasses(), "sno", "asc");
			if (classes.size()>0) {
				for(DeletedClasses c : classes) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", c.getInstitution_group_id());
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", c.getSchool_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					if(data.size() > 0) {
						c.setInstitution_group(data.get(0).getInstitution_group());
					}else {
						Map<String, Object> map3 = new HashMap<String,Object>();
						map3.put("group_id", c.getInstitution_group_id());
						List<DeletedGroup> data2 = (List<DeletedGroup>)commonDao.getDataByMap(map3, new DeletedGroup(), null, null, 0, -1);
						if(data2.size() > 0) {
							c.setInstitution_group(data2.get(0).getInstitution_group());
						}
					}
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
					if(data1.size() > 0) {
						c.setSchool_name(data1.get(0).getSchool_name());
					}else {
						Map<String, Object> map3 = new HashMap<String,Object>();
						map3.put("school_id", c.getSchool_id());
						List<DeletedSchools> data2 = (List<DeletedSchools>)commonDao.getDataByMap(map, new DeletedSchools(), null, null, 0, -1);
						if(data2.size() > 0) {
							c.setSchool_name(data2.get(0).getSchool_name());
						}
					}
				}
				response.put("data", classes);
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

	public Map<String, Object> delete_class(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			map1.put("class_id", Integer.parseInt(sno));
		
			List<Classes> classes =(List<Classes>)commonDao.getDataByMap(map, new Classes(), null, null, 0, -1);
			if(classes.size() > 0) {
				DeletedClasses ds = new DeletedClasses();
				
					ds.setClasses(classes.get(0).getClasses());
					ds.setSchool_id(classes.get(0).getSchool_id());
					ds.setInstitution_group_id(classes.get(0).getInstitution_group_id());
					ds.setImageType(classes.get(0).getImageType());
					ds.setStatus(classes.get(0).getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {
						Map<String,Object> map3 = new HashMap<String,Object>();
						map3.put("school_id",classes.get(0).getSchool_id());
						map3.put("class_id",classes.get(0).getSno());
						List<Paper> paper = (List<Paper>)commonDao.getDataByMap(map3, new Paper(), null, null, 0, -1);
						if(paper.size() > 0) {
							for(Paper q : paper) {
								DeletedPaper dp = new DeletedPaper();
								dp.setSchool_id(q.getSchool_id());
								dp.setClass_id(q.getClass_id());
								dp.setStatus(q.getStatus());
								dp.setCreatedAt(new Date());
								int k = commonDao.addDataToDb(dp);
								if(k > 0) {
									Map<String,Object> map4 = new HashMap<String,Object>();
									map4.put("paper_id",q.getSno());
									List<QuestionPaper> qpaper = (List<QuestionPaper>)commonDao.getDataByMap(map4, new QuestionPaper(), null, null, 0, -1);
									if(qpaper.size() > 0) {
										for(QuestionPaper qp : qpaper ) {
											DeletedQuestionPaper dq = new DeletedQuestionPaper();
											dq.setPaper_id(qp.getPaper_id());
											dq.setQuestion_id(qp.getQuestion_id());
											dq.setStatus(qp.getStatus());
											dq.setCreatedAt(new Date());
											int l = commonDao.addDataToDb(dq);
											if(l > 0) {
												commonDao.delete(new QuestionPaper(), String.valueOf(qp.getSno()));
											}
										}
									}
								}
								commonDao.delete(new Paper(), String.valueOf(q.getSno()));
							}
						}
						
					
				}		
			}
			List<Section> section =(List<Section>)commonDao.getDataByMap(map1, new Section(), null, null, 0, -1);
			if(section.size() > 0) {
				DeletedSection ds = new DeletedSection();
				for(Section s : section) {
					ds.setClass_id(s.getClass_id());
					ds.setSchool_id(s.getSchool_id());
					ds.setInstitution_group_id(s.getInstitution_group_id());
					ds.setSection_name(s.getSection_name());
					ds.setStatus(s.getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {
						commonDao.delete(new Section(), String.valueOf(s.getSno()));
					}
				}	
				
			}
			List<Answers> answer =(List<Answers>)commonDao.getDataByMap(map1, new Answers(), null, null, 0, -1);
			if(answer.size() > 0) {
				DeletedAnswer ds = new DeletedAnswer();
				for(Answers s : answer) {
					//ds.setClass_id(s.getClass_id());
					ds.setSchool_id(s.getSchool_id());
					ds.setGroup_id(s.getGroup_id());
					//ds.setSection_id(s.getSection_id());
					ds.setName(s.getName());
					ds.setEmail(s.getEmail());
					ds.setAnswer(s.getAnswer());
					ds.setStatus(s.getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {
						commonDao.delete(new Section(), String.valueOf(s.getSno()));
					}
				}	
				
			}
			commonDao.delete(new Classes(), sno);
			response.put("status","Success");
			response.put("message", "Class Details Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> get_schooldata(String institutionId) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("institution_group_id", Integer.parseInt(institutionId));
			map.put("status", "Active");
			List<Schools> school = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			if (school.size()>0) {
				response.put("status","Success");
				response.put("message", "Classes Fetched Successfully");
				response.put("data", school);
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

	public Map<String, Object> edit_class(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> mapdata  = new HashMap<String,Object>();
			mapdata.put("sno", Integer.parseInt(sno));
			List<Classes> classes = (List<Classes>) commonDao.getDataByMap(mapdata, new Classes(), null, null, 0, -1);
	
			if (classes.size()>0) {
				for(Classes c : classes) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", c.getInstitution_group_id());
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", c.getSchool_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					List<Schools> data1 = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
					c.setInstitution_group(data.get(0).getInstitution_group());
					c.setSchool_name(data1.get(0).getSchool_name());
				}
				response.put("status","Success");
				response.put("message", "Classes Fetched Successfully");
				response.put("data", classes);
				
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

	public Map<String, Object> get_classdata(String schoolId) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("school_id", Integer.parseInt(schoolId));
			List<Classes> classes = (List<Classes>) commonDao.getDataByMap(map, new Classes(), null, null, 0, -1);
			if (classes.size()>0) {
				response.put("status","Success");
				response.put("message", "Classes Fetched Successfully");
				response.put("data", classes);
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

	public Map<String, Object> add_mailTemplate(MailTemplate mailTemplate) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			if(mailTemplate.getSno() > 0) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("sno", mailTemplate.getSno());
				List<MailTemplate> mdata = (List<MailTemplate>)commonDao.getDataByMap(map, new MailTemplate(), null, null, 0, -1);
				if(mdata.size() > 0) {
					mdata.get(0).setSubject(mailTemplate.getSubject());
					mdata.get(0).setMessageBody(mailTemplate.getMessageBody());
					mdata.get(0).setTemplateType("Answer Submition");
					mdata.get(0).setStatus("Deactive");
					mdata.get(0).setUpdatedAt(new Date());
					commonDao.updateDataToDb(mdata.get(0));
					
					response.put("status","Success");
					response.put("message", "Mail Template Updated Successfully");
				}
			}else {
			mailTemplate.setTemplateType("Answer Submition");
			mailTemplate.setStatus("Deactive");
			mailTemplate.setCreatedAt(new Date());
		    int i = commonDao.addDataToDb(mailTemplate);
			if (i>0) {
				response.put("status","Success");
				response.put("message", "Mail Template Added Successfully");
			}else {
				response.put("status","Failure");
				response.put("message", "Something Went Wrong");
			}
		}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> get_mailTemplate(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map2.put("subject", search);
				map2.put("status", search);
			}
			List<MailTemplate> classes = (List<MailTemplate>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new MailTemplate(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new MailTemplate(), "sno", "asc");
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

	public Map<String, Object> get_templateData(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<MailTemplate> classes = (List<MailTemplate>) commonDao.getDataByMap(map, new MailTemplate(), null, null, 0, -1);
			if(classes.size() > 0) {
				response.put("data", classes);
				response.put("status", "Success");
			}else {
				response.put("status","Failed");
				response.put("message", "Something Went Wrong!!");
				return response;
			}
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}

	public Map<String, Object> delete_Template(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<MailTemplate> mdata = (List<MailTemplate>)commonDao.getDataByMap(map, new MailTemplate(), null, null, 0, -1);
			if(mdata.size() > 0) {
				DeletedmailTemplate dm = new DeletedmailTemplate();
				dm.setTemplate_id(Integer.parseInt(sno));
				dm.setSubject(mdata.get(0).getSubject());
				dm.setMessageBody(mdata.get(0).getMessageBody());
				dm.setStatus("Deactive");
				dm.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(dm);
				if(i > 0) {
					commonDao.delete(new MailTemplate(), sno);
				}
			}
			
			response.put("status","Success");
			response.put("message", "Mailtemplate Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
		
	}

	public Map<String, Object> updatemailTemplate(MailTemplate mailtemplate) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map =new HashMap<String,Object>();
			map.put("status", "Active");
			List<MailTemplate> mdata = (List<MailTemplate>)commonDao.getDataByMap(map, new MailTemplate(), null, null, 0, -1);
			System.out.println("mdata=="+mdata.size());
			if(mdata.size() > 0) {
				for(MailTemplate m : mdata) {
					Map<String, Object> search1 = new HashMap<String, Object>();
					search1.put("sno", m.getSno());
					
					// object mapper to convert the class object to map
					ObjectMapper mapObject1 = new ObjectMapper();
					Map<String, Object> mapObj1 = mapObject1.convertValue(m, Map.class);
					mapObj1.put("status", "Deactive");
					mapObj1.put("createdAt", dateFormat.format(new Date()));
					// updating the fields
					int i = commonDao.updateMethodForAll(mapObj1, "MailTemplate", search1);
				}
				
			}
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", mailtemplate.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(mailtemplate, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "MailTemplate", search);
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
