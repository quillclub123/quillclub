package com.quillBolt.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.Schools;
import com.quillBolt.model.SelectedStudent;
import com.quillBolt.utils.Utils;

@Service
public class SelectedService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_selected_students(String group_id, String school_id, MultipartFile file) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			try (Workbook workbook = WorkbookFactory.create(file.getInputStream())) {
				Utils utils = new Utils();
				Sheet sheet = workbook.getSheetAt(0);
				System.out.println(sheet.getSheetName());
				SelectedStudent res = new SelectedStudent();
					int k = 0;
					for (int i = 1; i <= sheet.getLastRowNum(); i++) {
						Row row = sheet.getRow(i);
						if (row != null) {
							String name = row.getCell(0).getStringCellValue().substring(0, 3);
							String id= "QCW/"+name;
							res.setGroup_id(Integer.parseInt(group_id));
							res.setSchool_id(Integer.parseInt(school_id));
							res.setName(row.getCell(0).getStringCellValue());
							res.setClass_name((int) row.getCell(1).getNumericCellValue());
//							try {
//								res.setClass_name(row.getCell(1).getStringCellValue());
//							} catch (Exception e) {
//								res.setClass_name(String.valueOf(row.getCell(1).getNumericCellValue()));
//							}
							res.setSection(row.getCell(2).getStringCellValue());
							res.setStatus("Active");
							res.setCount(0);
							res.setCreatedAt(new Date());
							k = commonDao.addDataToDb(res);
							Map<String,Object> map =new HashMap<String, Object>();
							String sid = id+"/"+k;
							String password = utils.generateRandomPassword(10);
							map.put("sno", k);
							List<SelectedStudent> st = (List<SelectedStudent>)commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);
							st.get(0).setStudent_id(sid);
							st.get(0).setPassword(password);
							commonDao.updateDataToDb(st.get(0));
						}
					}
					if (k > 0) {
						response.put("status", "Success");
						response.put("message", "Students List Uploaded Successfully");
					}else {
						response.put("status", "Failed");
						response.put("message", "Something went wrong");
					}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Internal server error" + e);
		}
		return response;
	}

	public Map<String, Object> get_selected_students(int start, int length, String search, String group_id, String school_id) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> map11 = new HashMap<String,Object>();
			if(group_id != null && !group_id.isEmpty() && school_id != null && !school_id.isEmpty()) {
				map11.put("group_id", Integer.parseInt(group_id));
				map11.put("school_id", Integer.parseInt(school_id));
			}
			if(search != null && !search.isEmpty()) {
				map.put("name", search);
				map.put("class_name", search);
				map.put("section", search);
				map.put("student_id", search);
				map.put("status", search);
				System.out.println("map="+map);
			}
			List<SelectedStudent> list = (List<SelectedStudent>) commonDao.getDataByMapSearchAnd(map11, map, new SelectedStudent(), "sno", "desc", start, length);	
			int count = commonDao.getDataByMapSearchAndSize(map11, map, new SelectedStudent(), "sno", "asc");
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

	public Map<String, Object> upload_pdf(MultipartFile pdf, String sno, String type) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Utils utils = new Utils();
			Map<String,Object> map = new HashMap<String,Object>();
				map.put("sno", Integer.parseInt(sno));
			List<SelectedStudent> list = (List<SelectedStudent>) commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);	
			if(list.size()>0) {
				String pd = utils.uploadImage(pdf);
				if(type.equalsIgnoreCase("Admin")) {
					list.get(0).setPdf(pd);
				}else {
					list.get(0).setRe_pdf(pd);
					int c = list.get(0).getCount()+1;
					list.get(0).setCount(c);
				}
				commonDao.updateDataToDb(list.get(0));
				response.put("status", "Success");
				response.put("message", "Pdf uploaded successfuly");
			}else {
				response.put("status","Failed");
				response.put("message","Something went wrong");
			}
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}

	public Map<String, Object> update_status(String sno, String boxstatus) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			String[] sn = sno.split(",");
			if(sn.length > 1) {
				for(int j=0;j<sn.length;j++) {
					map.put("sno", Integer.parseInt(sn[j]));
					List<SelectedStudent> list = (List<SelectedStudent>) commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);	
					if(list.size()>0) {
						if(boxstatus.equalsIgnoreCase("true")) {
							list.get(0).setStatus("Active");
						}else {
							list.get(0).setStatus("Deactive");
						}
						commonDao.updateDataToDb(list.get(0));
						response.put("status", "Success");
					}else {
						response.put("status","Failed");
					}
				}
			}else {
				map.put("sno", Integer.parseInt(sno));
				List<SelectedStudent> list = (List<SelectedStudent>) commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);	
				if(list.size()>0) {
					if(list.get(0).getStatus().equalsIgnoreCase("Active")) {
						list.get(0).setStatus("Deactive");
					}else {
						list.get(0).setStatus("Active");
					}
					commonDao.updateDataToDb(list.get(0));
					response.put("status", "Success");
				}else {
					response.put("status","Failed");
				}
			}
			
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}

	public Map<String, Object> get_reviewed_pdf(String group_id, String school_id) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("group_id", Integer.parseInt(group_id));
			map.put("school_id", Integer.parseInt(school_id));
			List<SelectedStudent> list = (List<SelectedStudent>) commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);	
			if(list.size()>0) {
				for(SelectedStudent s : list) {
					Map<String,Object> mp = new HashMap<String,Object>();
					mp.put("sno", s.getSchool_id());
					List<Schools> sc = (List<Schools>) commonDao.getDataByMap(mp, new Schools(), null, null, 0, -1);	
					s.setSchool_name(sc.get(0).getSchool_name()+" "+sc.get(0).getBranch());
				}
				response.put("data", list);
				response.put("status", "Success");
			}else {
				response.put("status","Failed");
				response.put("message","Something went wrong");
			}
		} catch (Exception e) {
			response.put("message", "Internal server Error"+e);
			e.printStackTrace();
			return response;
		}
		return response;
	}
}
