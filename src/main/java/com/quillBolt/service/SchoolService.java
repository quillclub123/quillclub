package com.quillBolt.service;

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
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Paper;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;
import com.quillBolt.utils.Utils;

@Service
public class SchoolService {
	
	@Autowired
	CommonDao commonDao;
	
	
	public Map<String, Object> add_school(Schools school) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			if(school.getSno() > 0) {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno",school.getSno());
				List<Schools> sch = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
				if(sch.size() >0) {
					sch.get(0).setInstitution_group_id(school.getInstitution_group_id());
					sch.get(0).setSchool_name(school.getSchool_name());
					sch.get(0).setState(school.getState());
					sch.get(0).setCity(school.getCity());
					sch.get(0).setLocation(school.getLocation());
					sch.get(0).setBranch(school.getBranch());
					sch.get(0).setStatus("Deactive");
					sch.get(0).setUpdatedAt(new Date());
					commonDao.updateDataToDb(sch.get(0));
					response.put("status","Success");
					response.put("message", "School Update Successfully");
				}
			}else {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("institution_group_id", school.getInstitution_group_id());
				map.put("school_name", school.getSchool_name());
				map.put("state", school.getState());
				map.put("city", school.getCity());
				map.put("location", school.getLocation());
				map.put("branch", school.getBranch());
				List<Schools> list = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
				if(list.size() >0) {
					response.put("status","Already_Exist");
					response.put("message", "School Already Exist");
				}else {
					school.setStatus("Deactive");
					school.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(school);
					if(i >0) {
						response.put("status","Success");
						response.put("message", "School Saved Successfully");
					}else {
						response.put("status","Failure");
						response.put("message", "Something went wrong");
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

//	public Map<String, Object> add_school(Schools schools, MultipartFile logo) {
//		Map<String, Object> response = new HashMap<String,Object>();
//		try {
//			if(schools.getSno() > 0) {
//				Map<String, Object> map = new HashMap<String,Object>();
//				map.put("sno", schools.getSno());
//				List<Schools> data = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
//				if (schools.getInstitution_group_id() >0) {
//					data.get(0).setInstitution_group_id(schools.getInstitution_group_id());
//				}
//				if(schools.getSchool_name() != null) {
//					data.get(0).setSchool_name(schools.getSchool_name());
//				}
//				if(schools.getState() != null) {
//					data.get(0).setState(schools.getState());
//				}
//				if(schools.getCity() != null) {
//					data.get(0).setCity(schools.getCity());
//				}
//				if (schools.getLocation() != null) {
//					data.get(0).setLocation(schools.getLocation());
//				}
//				data.get(0).setUpdatedAt(new Date());
//				commonDao.updateDataToDb(data.get(0));
//				response.put("status","Success");
//				response.put("message", "School Updated Successfully");
//			}else {
//				Map<String,Object> map = new HashMap<String,Object>();
//				map.put("institution_group_id", schools.getInstitution_group_id());
//				map.put("school_name", schools.getSchool_name());
//				map.put("location", schools.getLocation());
//				List<Schools> school = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
//				if(school.size() > 0) {
//					response.put("status","Already_Exist");
//					response.put("message", "School at this Location Already Exist");
//				}else {
//					Utils utils = new Utils();
//					String path = utils.uploadImage(logo);
//					schools.setLogo(path);
//					schools.setStatus("Active");
//					schools.setCreatedAt(new Date());
//					int i = commonDao.addDataToDb(schools);
//					if (i>0) {
//						String[] c = schools.getSelect_classes();
//						String[] ic = schools.getImgClasses();
//						Classes classs = new Classes();
//						for(int j = 0; j<c.length; j++) {
//							classs.setSchool_id(i);
//							classs.setInstitution_group_id(schools.getInstitution_group_id());
//							classs.setClasses(c[j]);
//							classs.setStatus("Active");
//							classs.setCreatedAt(new Date());
//							for(int k=0; k<ic.length; k++) {
//								if(c[j].equals(ic[k])) {
//									classs.setImageType("on");
//									break;
//								}else {
//									classs.setImageType("off");
//								}
//							}
//							int l = commonDao.addDataToDb(classs);
//						}
//						
//						response.put("status","Success");
//						response.put("message", "School Added Successfuly");
//					}else {
//						response.put("status","Failure");
//						response.put("message", "Something Went Wrong");
//					}
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			response.put("status","Failed");
//			response.put("message", "Something Went Wrong " +e);
//		}
//		return response;
//	}
	
	public Map<String, Object> get_schools(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map3 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map3.put("school_name", search);
				map3.put("institution_group", search);
				map3.put("state", search);
				map3.put("city", search);
				map3.put("location", search);
			}
			List<Schools> school = (List<Schools>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map3, new Schools(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map3, new Schools(), "sno", "asc");
			if (school.size() >0) {
				for(Schools s : school) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", s.getInstitution_group_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					s.setInstitution_group(data.get(0).getInstitution_group());
				}
				response.put("data", school);
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
	public Map<String, Object> get_deletedschool(int start,int length, String search){
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map3 = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map3.put("school_name", search);
				map3.put("institution_group", search);
				map3.put("state", search);
				map3.put("city", search);
				map3.put("location", search);
			}
			List<DeletedSchools> school = (List<DeletedSchools>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map3, new DeletedSchools(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map3, new DeletedSchools(), "sno", "asc");
			if (school.size() >0) {
				for(DeletedSchools s : school) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put("sno", s.getInstitution_group_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
					if(data.size() > 0) {
						s.setInstitution_group(data.get(0).getInstitution_group());
					}else {
						Map<String, Object> map1 = new HashMap<String,Object>();
						map1.put("group_id", s.getInstitution_group_id());
						List<DeletedGroup> data1 = (List<DeletedGroup>)commonDao.getDataByMap(map1, new DeletedGroup(), null, null, 0, -1);
						if(data1.size() > 0) {
							s.setInstitution_group(data1.get(0).getInstitution_group());
						}
						
					}
					
				}
				response.put("data", school);
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

	public Map<String, Object> delete_school(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			map1.put("school_id", Integer.parseInt(sno));
			List<Schools> school =(List<Schools>)commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			if(school.size() > 0) {
				DeletedSchools ds = new DeletedSchools();
					ds.setInstitution_group_id(school.get(0).getInstitution_group_id());
					ds.setSchool_name(school.get(0).getSchool_name());
					ds.setState(school.get(0).getState());
					ds.setCity(school.get(0).getCity());
					ds.setLocation(school.get(0).getLocation());
					ds.setStatus(school.get(0).getStatus());
					ds.setBranch(school.get(0).getBranch());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
				}
			
			List<Answers> answer =(List<Answers>)commonDao.getDataByMap(map1, new Answers(), null, null, 0, -1);
			if(answer.size() > 0) {
				DeletedAnswer ds = new DeletedAnswer();
				for(Answers s : answer) {
					ds.setClass_name(s.getClass_name());
					ds.setSchool_id(s.getSchool_id());
					ds.setGroup_id(s.getGroup_id());
					ds.setSection(s.getSection());
					ds.setName(s.getName());
					ds.setEmail(s.getEmail());
					ds.setAnswer(s.getAnswer());
					ds.setStatus(s.getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {
						commonDao.delete(new Answers(), String.valueOf(s.getSno()));
					}
				}	
				
			}
			commonDao.delete(new Schools(), sno);
			response.put("status","Success");
			response.put("message", "Schools Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> edit_school(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Schools> school = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			if (school.size() >0) {
				response.put("status","Success");
				response.put("message", "Schools Fetched Successfully");
				response.put("data", school);
				
			}else {
				response.put("status","Failure");
				response.put("message", "Something went wrong");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> get_schoolOptional(String sno) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			map.put("status", "Active");
			List<Schools> school = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			if(school.get(0).getExtra() != null && !school.get(0).getExtra().isEmpty()) {
				if (school.size() >0) {
					response.put("status","Success");
					response.put("message", "Schools Fetched Successfully");
					response.put("data", school);
					
				}else {
					response.put("status","Failure");
					response.put("message", "Something went wrong");
				}
			}else {
				response.put("status","Failure");
				response.put("message", "Something went wrong");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
		
	}

	public Map<String, Object> update_school(Schools schools, MultipartFile logo) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
				System.out.println("group = "  +schools.getInstitution_group_id());
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno", schools.getSno());
				List<Schools> data = (List<Schools>) commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
				
				Utils utils = new Utils();
				if(logo != null && !logo.isEmpty()) {
					String path = utils.uploadImage(logo);
					schools.setLogo(path);
				}
				
				if (schools.getInstitution_group_id() > 0) {
					data.get(0).setInstitution_group_id(schools.getInstitution_group_id());
				}
				if(schools.getSchool_name() != null) {
					data.get(0).setSchool_name(schools.getSchool_name());
				}
				if(schools.getState() != null) {
					data.get(0).setState(schools.getState());
				}
				if(schools.getCity() != null) {
					data.get(0).setCity(schools.getCity());
				}
				if (schools.getLocation() != null) {
					data.get(0).setLocation(schools.getLocation());
				}
				data.get(0).setTitle(schools.getTitle());
				data.get(0).setSubTitle(schools.getSubTitle());
				data.get(0).setDescription(schools.getDescription());
				data.get(0).setTermsCondition(schools.getTermsCondition());
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				String[] c = schools.getSelect_classes();
				String[] ic = schools.getImgClasses();
				Map<String, Object> map1 = new HashMap<String,Object>();
				map1.put("school_id", schools.getSno());
				map1.put("institution_group_id", schools.getInstitution_group_id());
				List<Classes> classs = (List<Classes>)commonDao.getDataByMap(map1, new Classes(), null, null, 0, -1);
				for(int j = 0; j<c.length; j++) {
					classs.get(j).setSchool_id(schools.getSno());
					classs.get(j).setInstitution_group_id(schools.getInstitution_group_id());
					classs.get(j).setClasses(c[j]);
					classs.get(j).setStatus("Active");
					classs.get(j).setCreatedAt(new Date());
					for(int k=0; k<ic.length; k++) {
						if(c[j].equals(ic[k])) {
							classs.get(j).setImageType("on");
							break;
						}else {
							classs.get(j).setImageType("off");
						}
					}
					commonDao.updateDataToDb(classs.get(j));
				}
				
				response.put("status","Success");
				response.put("message", "School Updated Successfully");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> updateschooldata(Schools school) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", school.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(school, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "Schools", search);
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
