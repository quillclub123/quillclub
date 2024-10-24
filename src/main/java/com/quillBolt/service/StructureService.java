package com.quillBolt.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.RecentStructureDescription;
import com.quillBolt.model.Structure;
import com.quillBolt.model.StructureDescription;

@Service
public class StructureService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> add_structure(Structure structure) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("student_id", structure.getStudent_id());
			List<Structure> stuc = (List<Structure>)commonDao.getDataByMap(map, new Structure(), null, null, 0, -1);
			if(stuc.size() > 0) {
				System.out.println("Date and Time="+new Date());
				stuc.get(0).setTotal_words(structure.getTotal_words());
				commonDao.updateDataToDb(stuc.get(0));
				Map<String, Object> mp = new HashMap<String, Object>();
				mp.put("structure_id", stuc.get(0).getSno());
				List<StructureDescription> sdd = (List<StructureDescription>)commonDao.getDataByMap(mp, new StructureDescription(), null, null, 0, -1);
				for(StructureDescription s: sdd) {
					RecentStructureDescription rsd = new RecentStructureDescription();
					rsd.setStructure_id(s.getStructure_id());
					rsd.setDescription(s.getDescription());
					rsd.setWords(s.getWords());
					rsd.setStatus("Active");
					rsd.setCreatedAt(new Date());
					commonDao.addDataToDb(rsd);
				}
				commonDao.deleteStructureDescription(stuc.get(0).getSno());
				List<StructureDescription> sd= structure.getSd();
				for(StructureDescription s : sd) {
					s.setStructure_id(stuc.get(0).getSno());
					s.setDescription(s.getDescription());
					s.setWords(s.getWords());
					s.setStatus("Active");
					s.setCreatedAt(new Date());
					commonDao.addDataToDb(s);
				}
				response.put("status", "Success");
				response.put("message", "Updated Successfully");
			}else {
				structure.setStatus("Active");
				structure.setCreatedAt(new Date());
				int i = commonDao.addDataToDb(structure);
				if(i > 0) {
					List<StructureDescription> sd= structure.getSd();
					for(StructureDescription s : sd) {
						s.setStructure_id(i);
						s.setDescription(s.getDescription());
						s.setWords(s.getWords());
						s.setStatus("Active");
						s.setCreatedAt(new Date());
						commonDao.addDataToDb(s);
					}
					response.put("status", "Success");
					response.put("message", "Added Successfully");
				}else {
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

	public Map<String, Object> get_structuredata(String sno) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Structure> st = (List<Structure>)commonDao.getDataByMap(map, new Structure(), null, null, 0, -1);
			if(st.size() > 0) {
				Map<String, Object> mp = new HashMap<String, Object>();
				mp.put("structure_id", Integer.parseInt(sno));
				List<StructureDescription> sd = (List<StructureDescription>)commonDao.getDataByMap(mp, new StructureDescription(), null, null, 0, -1);
				response.put("data", st);
				response.put("data1", sd);
				response.put("status", "Success");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Internal server Error" + e);
		}
		return response;
	}
}
