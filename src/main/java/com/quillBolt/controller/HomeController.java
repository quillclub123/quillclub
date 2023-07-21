package com.quillBolt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.quillBolt.dao.CommonDao;
import com.quillBolt.model.AdminLogin;
import com.quillBolt.model.Answers;
import com.quillBolt.model.Banner;
import com.quillBolt.model.Classes;
import com.quillBolt.model.Information;
import com.quillBolt.model.InstituitonGroup;
import com.quillBolt.model.MailTemplate;
import com.quillBolt.model.Paper;
import com.quillBolt.model.ProgramInformation;
import com.quillBolt.model.QuestionClassWise;
import com.quillBolt.model.QuestionPaper;
import com.quillBolt.model.Questions;
import com.quillBolt.model.SampleAnswer;
import com.quillBolt.model.SampleQuestion;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;
import com.quillBolt.service.ClassesService;
import com.quillBolt.service.InstitutionGroupService;

import javassist.expr.NewArray;


@Controller
public class HomeController {
	@Autowired
	CommonDao commonDao;
	@Autowired
	InstitutionGroupService institutionGroupService;
	@Autowired
	ClassesService classesService;
	
	@RequestMapping(value="/")
	public ModelAndView test(HttpServletRequest request) throws IOException{
		ModelAndView mv = new ModelAndView("Website/LandingPage/landingpage");
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		Map<String,Object> map2 = new HashMap<String,Object>();
		Map<String,Object> map3 = new HashMap<String,Object>();
		map.put("status", "Active");
		List<InstituitonGroup> group = new ArrayList<InstituitonGroup>();
		List<Schools> school = new ArrayList<Schools>();
		List<ProgramInformation> pinf = (List<ProgramInformation>)commonDao.getDataByMap(map, new ProgramInformation(),null , null, 0, -1);
		List<Banner> banner = (List<Banner>)commonDao.getDataByMap(map, new Banner(),null , null, 0, -1);
		if(pinf.size() > 0) {
			
			for(ProgramInformation ig : pinf) {
				String sid = ig.getSchool_id();
				System.out.println("h=="+sid);
				String[] school_id = sid.split(",");
				List<Schools> schoolLocation = new ArrayList<Schools>();
				for(int i=0; i<school_id.length; i++) {
					map1.put("sno", Integer.parseInt(school_id[i]));
					 schoolLocation = (List<Schools>)commonDao.getDataByMap(map1, new Schools(),null , null, 0, -1);
					school.add(schoolLocation.get(0));
				}
				System.out.println("h=="+school_id[0]);
				map2.put("institution_group_id",ig.getInstitution_group_id());
				map3.put("sno",ig.getInstitution_group_id());
				//List<Schools> school = (List<Schools>)commonDao.getDataByMap(map1, new Schools(),null , null, 0, -1);
				
				List<InstituitonGroup> igroup = (List<InstituitonGroup>)commonDao.getDataByMap(map3, new InstituitonGroup(),null , null, 0, -1);
				group.add(igroup.get(0));
				
				System.out.println("igroup="+igroup.size());
				//mv.addObject("school", school);
				mv.addObject("schoolLocation", schoolLocation);
				
			}
		}
		mv.addObject("banner", banner);
		mv.addObject("pinf", pinf);
		mv.addObject("igroup", group);
		mv.addObject("school", school);
		
		return mv;
	}
	@RequestMapping(value="/Adminlogin")
	public ModelAndView login(HttpServletRequest request) throws IOException{
		ModelAndView mv = new ModelAndView("Admin_Panel/login");
		return mv;
	}
	@RequestMapping(value="/change_password")
	public ModelAndView change_password(HttpServletRequest request) throws IOException{
		ModelAndView mv = new ModelAndView("Admin_Panel/changePassword");
		return mv;
	}
	
	@RequestMapping(value="/dashboard")
	public ModelAndView dashboard(HttpServletRequest request, HttpSession session) throws IOException{
		String email = request.getParameter("email");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("email", email);
		List<AdminLogin> loginData = (List<AdminLogin>)commonDao.getDataByMap(map,new AdminLogin(), null, null , 0, -1);
		if(loginData.size() > 0) {
			ModelAndView mv =  new ModelAndView("Admin_Panel/Dashboard/dashboard");
			session.setAttribute("loginData", loginData.get(0));
			session.setAttribute("email", email);
			
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	
	@RequestMapping(value="/checklogin",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> checklogin(HttpServletRequest request){
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Map<String, Object> response = institutionGroupService.checklogin(email,password);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/change_password",method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> change_password1(HttpServletRequest request){
		String currentpassword = request.getParameter("currentpassword");
		String password = request.getParameter("password");
		Map<String, Object> response = institutionGroupService.change_password(currentpassword,password);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		session.invalidate();		
		return new ModelAndView("redirect:/");
	}
	@RequestMapping(value="/testInformation")
	public ModelAndView testInformation(HttpServletRequest request) throws IOException{
		ModelAndView mv = new ModelAndView("Website/Test_Pages/studentInformation");
		String sno = request.getParameter("sno");
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("status", "Active");
		List<SampleQuestion> sans = (List<SampleQuestion>)commonDao.getDataByMap(map2, new SampleQuestion(), null, null, 0, -1);
		List<Section> sec = (List<Section>)commonDao.getDataByMap(map2, new Section(), null, null, 0, -1);
		List<Information> infor = (List<Information>)commonDao.getDataByMap(map2, new Information(), null, null, 0, -1);
		map1.put("sno", Integer.parseInt(sno));
		List<ProgramInformation> pinfo = (List<ProgramInformation>)commonDao.getDataByMap(map1, new ProgramInformation(), null, null, 0, -1);
		map.put("institution_group_id", pinfo.get(0).getInstitution_group_id());
		map.put("status", "Active");
		List<Schools> schooldata = (List<Schools>)commonDao.getDataByMap(map, new Schools(),null , null, 0, -1);
		Map<String,Object> mapdata = new HashMap<String,Object>();
		mapdata.put("sno", pinfo.get(0).getInstitution_group_id());
		List<InstituitonGroup> instituitonGroups = (List<InstituitonGroup>)commonDao.getDataByMap(mapdata, new InstituitonGroup(), null, null, 0, -1);
		List<String> data8 = (List<String>)commonDao.getDistinctData("class_name", new QuestionClassWise());
		
		mv.addObject("pinfo", pinfo);
		mv.addObject("schooldata", schooldata);
		mv.addObject("sans", sans);
		mv.addObject("data8", data8);
		mv.addObject("instituitonGroups", instituitonGroups);
		mv.addObject("infor", infor);
		mv.addObject("sec", sec);
		return mv;
	}
	@RequestMapping(value="/test")
	public ModelAndView totest(HttpServletRequest request) throws IOException{
		ModelAndView mv = new ModelAndView("Website/Test_Pages/test");
		String school_id = request.getParameter("school_id");
		String class_name = request.getParameter("class_name");
		String section = request.getParameter("section");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String extra = request.getParameter("extra");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("status", "Active");
		List<SampleAnswer> sampleAnswers = (List<SampleAnswer>)commonDao.getDataByMap(map, new SampleAnswer(), "sno", "desc", 0, -1);
		List<Information> infor = (List<Information>)commonDao.getDataByMap(map, new Information(), null, null, 0, -1);
		Map<String,Object> map5 = new HashMap<String,Object>();
		map5.put("sno", Integer.parseInt(school_id));
		List<Schools> school = (List<Schools>)commonDao.getDataByMap(map5, new Schools(), null, null, 0, -1);
		Map<String,Object> map6 = new HashMap<String,Object>();
		map6.put("institution_group_id", school.get(0).getInstitution_group_id());
		List<ProgramInformation> pInfo = (List<ProgramInformation>)commonDao.getDataByMap(map6, new ProgramInformation(), null, null, 0, -1);
		List<QuestionClassWise> qp = (List<QuestionClassWise>)commonDao.getRandomQuestion(class_name, "Active");
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("sno", qp.get(0).getQuestion_id());
		List<Questions> questions = (List<Questions>)commonDao.getDataByMap(map1, new Questions(), null, null, 0, -1);
		mv.addObject("questions", questions);
		mv.addObject("school", school);
		mv.addObject("al", name);
		mv.addObject("class_name", class_name);
		mv.addObject("section", section);
		mv.addObject("email", email);
		mv.addObject("extra", extra);
		mv.addObject("sampleAnswers", sampleAnswers);
		mv.addObject("pInfo", pInfo);
		mv.addObject("infor", infor);
		return mv;
	}
	@RequestMapping(value="/submission")
	public ModelAndView submission(HttpServletRequest request) throws IOException{
		String group_id = request.getParameter("group_id");
		String school_id = request.getParameter("school_id");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("institution_group_id", Integer.parseInt(group_id));
		ModelAndView mv = new ModelAndView("Website/Test_Pages/submitionPage");
		List<ProgramInformation> pinfo = (List<ProgramInformation>)commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
		String[] sid = pinfo.get(0).getSchool_id().split(",");
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("sno", Integer.parseInt(school_id));
		List<Schools> school = (List<Schools>)commonDao.getDataByMap(map1, new Schools(), null, null, 0, -1);
		mv.addObject("school", school);
		mv.addObject("pinfo", pinfo);
		return mv;
	}
	@RequestMapping(value="/addgroup")
	public ModelAndView institutionGroup(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			System.out.println("Email= "+loginData.getEmail());
			ModelAndView mv =  new ModelAndView("Admin_Panel/InstitutionGroup/institutionGroup");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/deletedGroup")
	public ModelAndView deletedGroup(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			System.out.println("Email= "+loginData.getEmail());
			ModelAndView mv =  new ModelAndView("Admin_Panel/InstitutionGroup/deletedGroup");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/information")
	public ModelAndView information(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv =  new ModelAndView("Admin_Panel/Quill_Club_Info/quillClubInfo");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/editinstitutionGroup")
	public ModelAndView editinstitutionGroup(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			String sno = request.getParameter("sno");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map,new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv =  new ModelAndView("Admin_Panel/InstitutionGroup/editInstitutionGroup");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/viewgroup")
	public ModelAndView institution(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			System.out.println("Email= "+loginData.getEmail());
			ModelAndView mv =  new ModelAndView("Admin_Panel/InstitutionGroup/addInstitution");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
	}
	@RequestMapping(value="/mailTemplate")
	public ModelAndView mailTemplate(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			
			ModelAndView mv = new ModelAndView("Admin_Panel/MailTemplate/viewMailTemplate");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	
	@RequestMapping(value="/addMailTemplate")
	public ModelAndView addMailTemplate(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			
			ModelAndView mv = new ModelAndView("Admin_Panel/MailTemplate/mailTemplate");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/viewSchool")
	public ModelAndView Institution(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			String sno = request.getParameter("sno");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/School/addSchool");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/schools")
	public ModelAndView viewSchool(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("status", "Active");
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/School/school");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/progarmInformation")
	public ModelAndView progarmInformation(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/ProgramInformation/viewProgram");
		
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/deletedProgramInformation")
	public ModelAndView deletedProgramInformation(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/ProgramInformation/deletedProgram");
			
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/addProgarmInformation")
	public ModelAndView addProgarmInformation(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("status", "Active");
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/ProgramInformation/programInformation");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/editProgarmInformation")
	public ModelAndView editProgarmInformation(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			String sno = request.getParameter("sno");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<ProgramInformation> data = (List<ProgramInformation>)commonDao.getDataByMap(map, new ProgramInformation(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/ProgramInformation/editProgram");
			Map<String,Object> map1 =new HashMap<String,Object>();
			map1.put("sno", data.get(0).getInstitution_group_id());
			List<InstituitonGroup> igroup = (List<InstituitonGroup>)commonDao.getDataByMap(map1, new InstituitonGroup(), null, null, 0, -1);
			if(igroup.size() > 0) {
				data.get(0).setInstitution_group(igroup.get(0).getInstitution_group());
			}
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("status", "Active");
			List<InstituitonGroup> data2 = (List<InstituitonGroup>)commonDao.getDataByMap(map2, new InstituitonGroup(), null, null, 0, -1);
			mv.addObject("data2", data2);
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/viewDeletedSchool")
	public ModelAndView viewDeletedSchool(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/School/deletedSchools");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/editSchool")
	public ModelAndView editSchool(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/School/editSchool");
			String sno = request.getParameter("sno");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sno", Integer.parseInt(sno));
			List<Schools> data = (List<Schools>)commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			Map<String,Object> map1 = new HashMap<String,Object>();
			Map<String,Object> map2 = new HashMap<String,Object>();
			map1.put("school_id", data.get(0).getSno());
			map1.put("institution_group_id", data.get(0).getInstitution_group_id());
			map2.put("sno", data.get(0).getInstitution_group_id());
			List<Classes> cl = (List<Classes>)commonDao.getDataByMap(map1, new Classes(), null, null, 0, -1);
			List<InstituitonGroup> g = (List<InstituitonGroup>)commonDao.getDataByMap(map2, new InstituitonGroup(), null, null, 0, -1);
			mv.addObject("data", data);
			mv.addObject("data1", cl);
			mv.addObject("groupName", g.get(0).getInstitution_group());
			
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/classes")
	public ModelAndView classes(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(new HashMap<String,Object>(), new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/Classes/class");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/deletedClasses")
	public ModelAndView deletedClasses(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Classes/deletedClass");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/section")
	public ModelAndView section(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			List<InstituitonGroup> data = (List<InstituitonGroup>)commonDao.getDataByMap(new HashMap<String,Object>(), new InstituitonGroup(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/Sections/section");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/deletedSection")
	public ModelAndView deletedSection(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Sections/deletedSection");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/question")
	public ModelAndView question(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Questions/question");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/deletedQuestion")
	public ModelAndView deletedQuestion(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Questions/deletedQuestion");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/addPaper")
	public ModelAndView addPaper(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			List<Schools> data = (List<Schools>)commonDao.getDataByMap(new HashMap<String,Object>(), new Schools(), null, null, 0, -1);
			ModelAndView mv = new ModelAndView("Admin_Panel/Papers/addPaper");
			mv.addObject("data", data);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/sample_question")
	public ModelAndView sample_question(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Sample/sampleQuestion");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/sample_answer")
	public ModelAndView sample_answer(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/Sample/sampleAnswer");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/top_image_banner")
	public ModelAndView top_image_banner(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			ModelAndView mv = new ModelAndView("Admin_Panel/UploadBanner/uploadBanner");
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/viewAnswers")
	public ModelAndView viewPaper(HttpServletRequest request, HttpSession session) throws IOException{
		AdminLogin loginData = (AdminLogin)session.getAttribute("loginData");
		if(loginData != null) {
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> map4 = new HashMap<String,Object>();
			Map<String,Object> map5 = new HashMap<String,Object>();
			map.put("status", "Active");
			
			List<Answers> data = (List<Answers>)commonDao.getDataByMap(map, new Answers(), null, null, 0, -1);
			map4.put("status", "Active");
			map5.put("status", "Active");
			List<String> data5 =  (List<String>) commonDao.getDistinctData("section", new Answers());
			List<String> data6 = (List<String>)commonDao.getDistinctData("class_name", new Answers());
			List<String> data8 = (List<String>)commonDao.getDistinctData("name", new Answers());
			
			List<Date> data7 = (List<Date>) commonDao.getDistinctDataDate("createdAt", new Answers());
			
			List<Schools> data3 = (List<Schools>)commonDao.getDataByMap(map, new Schools(), null, null, 0, -1);
			List<InstituitonGroup> data4 = (List<InstituitonGroup>)commonDao.getDataByMap(map, new InstituitonGroup(), null, null, 0, -1);
			if(data.size() > 0) {
				for(Answers a : data) {
					Map<String,Object> map1 = new HashMap<String,Object>();
					Map<String,Object> map2 = new HashMap<String,Object>();
					map1.put("sno", a.getGroup_id());
					map2.put("sno", a.getSchool_id());
					List<InstituitonGroup> data1 = (List<InstituitonGroup>)commonDao.getDataByMap(map1, new InstituitonGroup(), null, null, 0, -1);
					List<Schools> data2 = (List<Schools>)commonDao.getDataByMap(map2, new Schools(), null, null, 0, -1);
					a.setSchool(data2.get(0).getSchool_name());
					a.setGroup(data1.get(0).getInstitution_group());
				}
			}
			ModelAndView mv = new ModelAndView("Admin_Panel/Answers/viewAnswer");
			mv.addObject("data", data);
			mv.addObject("school", data3);
			mv.addObject("group", data4);
			mv.addObject("section", data5);
			mv.addObject("class_name", data6);
			mv.addObject("createdAt", data7);
			mv.addObject("name", data8);
			return mv;
		}else {
			return new ModelAndView("redirect:/");
		}
		
	}
	@RequestMapping(value="/add_mailTemplate")
	public ResponseEntity<Map<String, Object>> add_mailTemplate(@RequestBody MailTemplate mailTemplate){
		Map<String, Object> response = new HashMap<String,Object>();
		response = classesService.add_mailTemplate(mailTemplate);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value="/get_mailTemplate", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_mailTemplate(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		int start = Integer.parseInt(request.getParameter("start"));
		int length = Integer.parseInt(request.getParameter("length"));
		String search = request.getParameter("search[value]");
		response =  classesService.get_mailTemplate(start,length,search);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	@RequestMapping(value="/get_templateData", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> get_templateData(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		response =  classesService.get_templateData(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping(value = "delete_Template", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> delete_Template(HttpServletRequest request){
		Map<String, Object> response = new HashMap<String,Object>();
		String sno = request.getParameter("sno");
		System.out.println("sno="+sno);
		response = classesService.delete_Template(sno);
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
		
	}
	@RequestMapping(value = "/updatemailTemplate", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updatemailTemplate(@RequestBody MailTemplate mailtemplate){
		Map<String, Object> response =classesService.updatemailTemplate(mailtemplate);
		return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
	}
}
