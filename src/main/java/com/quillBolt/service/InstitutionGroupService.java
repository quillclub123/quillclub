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
import com.mongodb.internal.connection.tlschannel.util.Util;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.AdminLogin;
import com.quillBolt.model.Answers;
import com.quillBolt.model.Classes;
import com.quillBolt.model.DeletedAnswer;
import com.quillBolt.model.DeletedClasses;
import com.quillBolt.model.DeletedGroup;
import com.quillBolt.model.DeletedPaper;
import com.quillBolt.model.DeletedProgram;
import com.quillBolt.model.DeletedQuestionPaper;
import com.quillBolt.model.DeletedSchools;
import com.quillBolt.model.DeletedSection;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Paper;
import com.quillBolt.model.ProgramInformation;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;
import com.quillBolt.utils.Utils;


@Service
public class InstitutionGroupService {
	
	@Autowired
	CommonDao commonDao;
	
	public Map<String, Object> add_group(InstituitonGroup institutionGroup) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			if(institutionGroup.getSno() > 0) {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno",institutionGroup.getSno());
				List<InstituitonGroup> insGroups = (List<InstituitonGroup>) commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
				if(insGroups.size() >0) {
					insGroups.get(0).setInstitution_group(institutionGroup.getInstitution_group());
					insGroups.get(0).setSub_title(institutionGroup.getSub_title());
					insGroups.get(0).setStatus("Deactive");
					insGroups.get(0).setUpdatedAt(new Date());
					commonDao.updateDataToDb(insGroups.get(0));
					response.put("status","Success");
					response.put("message", "Institution Group Update Successfully");
				}
			}else {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("institution_group", institutionGroup.getInstitution_group());
				List<InstituitonGroup> list = (List<InstituitonGroup>) commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
				if(list.size() >0) {
					response.put("status","Already_Exist");
					response.put("message", "Institution Group Already Exist");
				}else {
					institutionGroup.setStatus("Deactive");
					institutionGroup.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(institutionGroup);
					if(i >0) {
						response.put("status","Success");
						response.put("message", "Institution Group Saved Successfully");
					}else {
						response.put("status","Failure");
						response.put("message", "Institution Group Not Saved");
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
	

	public Map<String, Object> get_group(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("institution_group", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<InstituitonGroup> list = (List<InstituitonGroup>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new InstituitonGroup(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new InstituitonGroup(), "sno", "asc");
			
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
			response.put("data", new ArrayList());
			response.put("recordsFiltered", 0);
			response.put("recordsTotal", 0);
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}
	public Map<String, Object> get_deletedgroup(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("institution_group", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<DeletedGroup> list = (List<DeletedGroup>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new DeletedGroup(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new DeletedGroup(), "sno", "asc");
			
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
			response.put("data", new ArrayList());
			response.put("recordsFiltered", 0);
			response.put("recordsTotal", 0);
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}

	public Map<String, Object> delete_group(String sno) {
		Map<String, Object> response = new HashMap<String,Object>(); 
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map1 = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			map1.put("institution_group_id", Integer.parseInt(sno));
			map2.put("group_id", Integer.parseInt(sno));
			List<InstituitonGroup> igroup =(List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			DeletedGroup g = new DeletedGroup();
			g.setInstitution_group(igroup.get(0).getInstitution_group());
			g.setSub_title(igroup.get(0).getSub_title());
			g.setGroup_id(igroup.get(0).getSno());
			g.setStatus(igroup.get(0).getStatus());
			g.setCreatedAt(new Date());
			int j = commonDao.addDataToDb(g);
			List<Schools> school =(List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
			if(school.size() > 0) {
				DeletedSchools ds = new DeletedSchools();
				for(Schools s : school) {
					
					ds.setInstitution_group_id(s.getInstitution_group_id());
					ds.setSchool_name(s.getSchool_name());
					ds.setState(s.getState());
					ds.setCity(s.getCity());
					ds.setLocation(s.getLocation());
					ds.setBranch(s.getBranch());
					ds.setStatus(s.getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {
						commonDao.delete(new Schools(), String.valueOf(s.getSno()));
					}
				}
				
			}
			List<ProgramInformation> program =(List<ProgramInformation>)commonDao.getDataByMap(map1, new ProgramInformation(), null, null, 0, -1);
			if(program.size() > 0) {
				DeletedProgram dp = new DeletedProgram();
				dp.setProgram_id(program.get(0).getSno());
				dp.setTitle(program.get(0).getTitle());
				dp.setSubTitle(program.get(0).getSubTitle());
				dp.setLogo(program.get(0).getLogo());
				dp.setProgram_id(program.get(0).getInstitution_group_id());
				dp.setSchool_id(program.get(0).getSchool_id());
				dp.setDescription(program.get(0).getDescription());
				dp.setTermsCondition(program.get(0).getTermsCondition());
				dp.setExtra(program.get(0).getExtra());
				dp.setStatus(program.get(0).getStatus());
				dp.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(dp);
				if(i > 0) {
					commonDao.delete(new ProgramInformation(), String.valueOf(program.get(0).getSno()));
				}
				
			}
			List<Answers> answer =(List<Answers>)commonDao.getDataByMap(map2, new Answers(), null, null, 0, -1);
			if(answer.size() > 0) {
				DeletedAnswer ds = new DeletedAnswer();
				for(Answers a : answer) {
					ds.setAnswer_id(a.getSno());
					ds.setSchool_id(a.getSchool_id());
					ds.setGroup_id(a.getGroup_id());
					ds.setName(a.getName());
					ds.setEmail(a.getEmail());
					ds.setAnswer(a.getAnswer());
					ds.setStatus(a.getStatus());
					ds.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(ds);
					if( i > 0) {

						commonDao.delete(new Answers(), String.valueOf(a.getSno()));
					}
				}	
				
			}
			commonDao.delete(new InstituitonGroup(), sno);
			response.put("status","Success");
			response.put("message", "Data Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
	public Map<String, Object> edit_group(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<InstituitonGroup> list = (List<InstituitonGroup>) commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			
			if(list.size()>0) {
				response.put("status","Success");
				response.put("data",list);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

	public Map<String, Object> updateInstitutiondata(InstituitonGroup instituitonGroup) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", instituitonGroup.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(instituitonGroup, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "InstituitonGroup", search);
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


	public Map<String, Object> checklogin(String email, String password) {

		Map<String, Object> response = new HashMap<String, Object>();
		try {
			System.out.println("Login service");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("email", email);
			map.put("password", password);
			List<AdminLogin> data = (List<AdminLogin>) commonDao.getDataByMap(map, new AdminLogin(),
					null, null, 0, -1);
			if (data.size() > 0) {
				System.out.println("service success");
				response.put("status", "Success");
			} else {
				System.out.println("service failure");
				response.put("status", "Failed");
				response.put("message", "Something Went Wrong");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Something Went Wrong" + e);
		}
		return response;

	}


	public Map<String, Object> change_password(String currentpassword, String password) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			System.out.println("Login service");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("password", currentpassword);
			List<AdminLogin> data = (List<AdminLogin>) commonDao.getDataByMap(map, new AdminLogin(),null, null, 0, -1);
			if (data.size() > 0) {
				Map<String, Object> search = new HashMap<String, Object>();
				search.put("sno", data.get(0).getSno());
				
				// object mapper to convert the class object to map
				ObjectMapper mapObject = new ObjectMapper();
				Map<String, Object> mapObj = mapObject.convertValue(new AdminLogin(), Map.class);
				mapObj.put("password", password);
				// updating the fields
				int id = commonDao.updateMethodForAll(mapObj, "AdminLogin", search);
				if (id > 0) {
					response.put("status", "Success");
					return response;
				}
			} else {
				System.out.println("Failure");
				response.put("status", "Failure");
				response.put("message", "Something went wrong");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Something Went Wrong" + e);
		}
		return response;
	}

	
}
