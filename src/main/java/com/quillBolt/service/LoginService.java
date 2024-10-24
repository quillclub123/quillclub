package com.quillBolt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.SelectedStudent;

@Service
public class LoginService {

	@Autowired
	CommonDao commonDao;

	public Map<String, Object> checklogin(String student_id, String password) {
		Map<String,Object> response = new HashMap<String, Object>();
		try {
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("student_id", student_id);
			map.put("password", password);
			map.put("status", "Active");
			List<SelectedStudent> st = (List<SelectedStudent>)commonDao.getDataByMap(map, new SelectedStudent(), null, null, 0, -1);
			if(st.size() > 0) {
				response.put("status", "Success");
				response.put("message", "Login Success");
			}else {
				response.put("status", "Failed");
				response.put("message", "Something went wrong");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "Failed");
			response.put("message", "Something went wrong"+e);
		}
		return response;
	}
}
