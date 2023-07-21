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
import com.quillBolt.model.DeletedAnswer;
import com.quillBolt.model.DeletedGroup;
import com.quillBolt.model.DeletedProgram;
import com.quillBolt.model.DeletedSchools;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.ProgramInformation;
import com.quillBolt.model.Schools;
import com.quillBolt.utils.Utils;

@Service
public class ProgramService {

	@Autowired
	CommonDao commonDao;
	public Map<String, Object> add_program(ProgramInformation programInformation, MultipartFile logo) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			System.out.println("school==="+programInformation.getSchool_id());
			if(programInformation.getSno() > 0) {
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("sno", programInformation.getSno());
				List<ProgramInformation> data = (List<ProgramInformation>) commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
				if(data.size() > 0) {
					Utils utils = new Utils();
					if(logo != null && !logo.isEmpty()) {
						String path = utils.uploadImage(logo);
						data.get(0).setLogo(path);
					}
					data.get(0).setSno(programInformation.getSno());
					data.get(0).setTitle(programInformation.getTitle());
					data.get(0).setBgColor(programInformation.getBgColor());
					data.get(0).setStudentOf(programInformation.getStudentOf());
					data.get(0).setSubTitle(programInformation.getSubTitle());
					data.get(0).setInstitution_group_id(programInformation.getInstitution_group_id());
					data.get(0).setSchool_id(programInformation.getSchool_id());
					data.get(0).setDescription(programInformation.getDescription());
					data.get(0).setTermsCondition(programInformation.getTermsCondition());
					
				}
				
				data.get(0).setUpdatedAt(new Date());
				commonDao.updateDataToDb(data.get(0));
				response.put("status","Success");
				response.put("message", "School Updated Successfully");
			}else {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("institution_group_id", programInformation.getInstitution_group_id());
				List<ProgramInformation> school = (List<ProgramInformation>) commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
				if(school.size() > 0) {
					response.put("status","Already_Exist");
					response.put("message", "Program at this Location Already Exist");
				}else {
					Utils utils = new Utils();
					String path = utils.uploadImage(logo);
					programInformation.setLogo(path);
					programInformation.setStatus("Deactive");
					programInformation.setCreatedAt(new Date());
					int i = commonDao.addDataToDb(programInformation);
					if (i>0) {
						response.put("status","Success");
						response.put("message", "School Added Successfuly");
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
	public Map<String, Object> get_program(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("title", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<ProgramInformation> list = (List<ProgramInformation>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new ProgramInformation(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new ProgramInformation(), "sno", "asc");
			
			if(list.size()>0) {
				for(int i =0; i <list.size(); i++) {
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", list.get(i).getInstitution_group_id());
					List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map1, new InstituitonGroup(), null, null, 0, -1);
					list.get(i).setInstitution_group(data.get(0).getInstitution_group());
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
	public Map<String, Object> edit_program(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<ProgramInformation> list = (List<ProgramInformation>) commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
			
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
	public Map<String, Object> updateprogram(ProgramInformation programInformation) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", programInformation.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(programInformation, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "ProgramInformation", search);
			if (id > 0) {
				response.put("status", "Success");
				return response;
			}else {
				response.put("Failure", "Success");
				return response;
			}
			
		} catch (Exception e) {
			response.put("Failed", "Internal Server Error");
			e.printStackTrace();
			return response;
		}
	}
	public Map<String, Object> get_Deleted_program(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			if(search != null && !search.isEmpty()) {
				map.put("title", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<DeletedProgram> list = (List<DeletedProgram>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(), map, new DeletedProgram(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(), map, new DeletedProgram(), "sno", "asc");
			
			if(list.size()>0) {
				for(DeletedProgram s : list) {
					Map<String, Object> map1 = new HashMap<String,Object>();
					map1.put("sno", s.getInstitution_group_id());
					List<DeletedGroup> data = (List<DeletedGroup>)commonDao.getDataByMap(map, new DeletedGroup(), null, null, 0, -1);
					if(data.size() > 0) {
						s.setInstitution_group(data.get(0).getInstitution_group());
					}
					
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
	public Map<String, Object> delete_program(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			
			List<ProgramInformation> program =(List<ProgramInformation>)commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
			if(program.size() > 0) {
				DeletedProgram dp = new DeletedProgram();
				dp.setProgram_id(program.get(0).getSno());
				dp.setTitle(program.get(0).getTitle());
				dp.setSubTitle(program.get(0).getSubTitle());
				dp.setStudentOf(program.get(0).getStudentOf());
				dp.setBgColor(program.get(0).getBgColor());
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
					commonDao.delete(new ProgramInformation(), String.valueOf(sno));
					response.put("status","Success");
					response.put("message", "Data Deleted Successfully");
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}

}
