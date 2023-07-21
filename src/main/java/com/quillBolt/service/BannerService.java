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
import com.quillBolt.model.Banner;
import com.quillBolt.utils.Utils;

@Service
public class BannerService {

	@Autowired
	CommonDao commonDao;
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public Map<String, Object> add_banner(MultipartFile bannerImg) {
		Map<String,Object> response = new HashMap<String,Object>();
		try {
			Banner banner = new Banner();
			Utils utils = new Utils();
			if(bannerImg != null && !bannerImg.isEmpty()) {
				String qimg = utils.uploadImage(bannerImg);
				banner.setBannerImg(qimg);
			}
			banner.setStatus("Deactive");
			banner.setCreatedAt(new Date());
			int i = commonDao.addDataToDb(banner);
			if(i > 0) {
				response.put("status", "Success");
				response.put("message", "Banner Uploaded Successfully");
			}else {
				response.put("status", "Failed");
				response.put("message", "Something went wrong");
			}
			
		}catch(Exception e) {
			response.put("status", "Failure");
			response.put("message", "Something went wrong"+e);
		}
		return response;
	}
	public Map<String, Object> get_banner(int start, int length, String search) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			Map<String,Object> map2 = new HashMap<String,Object>();
			
			List<Banner> classes = (List<Banner>) commonDao.getDataByMapSearchAnd(new HashMap<String,Object>(),map2, new Banner(), "sno", "desc", start, length);
			int count = commonDao.getDataByMapSearchAndSize(new HashMap<String,Object>(),map2 ,new Banner(), "sno", "asc");
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
	public Map<String, Object> delete_banner(String sno) {
		Map<String, Object> response = new HashMap<String,Object>();
		try {
			commonDao.delete(new Banner(), sno);
			response.put("status","Success");
			response.put("message", "Banner Deleted Successfully");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status","Failed");
			response.put("message", "Something Went Wrong " +e);
		}
		return response;
	}
	public Map<String, Object> updatbanner(Banner banner) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			Map<String, Object> map =new HashMap<String,Object>();
			map.put("status", "Active");
			List<Banner> mdata = (List<Banner>)commonDao.getDataByMap(map, new Banner(), null, null, 0, -1);
			System.out.println("mdata=="+mdata.size());
			if(mdata.size() > 0) {
				for(Banner m : mdata) {
					Map<String, Object> search1 = new HashMap<String, Object>();
					search1.put("sno", m.getSno());
					
					// object mapper to convert the class object to map
					ObjectMapper mapObject1 = new ObjectMapper();
					Map<String, Object> mapObj1 = mapObject1.convertValue(m, Map.class);
					mapObj1.put("status", "Deactive");
					mapObj1.put("createdAt", dateFormat.format(new Date()));
					// updating the fields
					int i = commonDao.updateMethodForAll(mapObj1, "Banner", search1);
				}
				
			}
			Map<String, Object> search = new HashMap<String, Object>();
			search.put("sno", banner.getSno());
			
			// object mapper to convert the class object to map
			ObjectMapper mapObject = new ObjectMapper();
			Map<String, Object> mapObj = mapObject.convertValue(banner, Map.class);
			
			// updating the fields
			int id = commonDao.updateMethodForAll(mapObj, "Banner", search);
			if (id > 0) {
				response.put("status", "Success");
				return response;
			}
			response.put("Failure", "Success");
			return response;
		} catch (Exception e) {
			response.put("Failed", "Internal Server Error");
			e.printStackTrace();
		}
		return response;
	}

}
