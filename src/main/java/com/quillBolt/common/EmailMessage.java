package com.quillBolt.common;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.quillBolt.dao.CommonDao;
import com.quillBolt.dao.MailTemplateDao;
import com.quillBolt.model.Answers;
import com.quillBolt.model.Classes;
import com.quillBolt.model.MailTemplate;
import com.quillBolt.model.Schools;
import com.quillBolt.model.Section;





@Service
public class EmailMessage {

	@Autowired
	MailTemplateDao mailtemplateDao;
	@Autowired
	CommonDao commonDao;

	Properties emailProperties;
	Session mailSession;
	boolean returnValue;
	MimeMessage emailMessage;

	public static void main(String agr[]) {
		EmailMessage emailMessage = new EmailMessage();
		emailMessage.sendSmsMessage("9953791575", 123456);
	}

	public boolean sendSmsMessage(String mobileno, int otp) {
		returnValue = false;

		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "application/x-www-form-urlencoded");
			final String url = "https://2factor.in/API/V1/87a186cd-d3ef-11ea-9fa5-0200cd936042/SMS/" + mobileno + "/"
					+ otp + "/Chakrabarty Mathematics";
			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
			HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(map, headers);
			String result = restTemplate.postForObject(url, requestEntity, String.class);
			System.out.println(result);
			returnValue = true;
		} catch (Exception e) {
			returnValue = false;
		}
		return returnValue;
	}

	public boolean sendEmailMessage(String templatetype, Map<String, String> map, String email, int answwerId) {
		try {
			
			List<MailTemplate> mailTemplate = mailtemplateDao.getTemplate(templatetype);
			String mailContent = mailTemplate.get(0).getMessageBody();
			String subjectContent = mailTemplate.get(0).getSubject();
			for (Map.Entry<String, String> m : map.entrySet()) {
				mailContent = mailContent.replace("##" + m.getKey() , String.valueOf(m.getValue()));
				subjectContent = subjectContent.replace("##" + m.getKey(), String.valueOf(m.getValue()));
			}
			Map<String,Object> map1 = new HashMap<String,Object>();
			map1.put("sno", answwerId);
			List<Answers> ans = (List<Answers>)commonDao.getDataByMap(map1, new Answers(), null, null, 0, -1);
			Map<String,Object> map2 = new HashMap<String,Object>();
			Map<String,Object> map3 = new HashMap<String,Object>();
			Map<String,Object> map4 = new HashMap<String,Object>();
			map3.put("sno", ans.get(0).getSchool_id());	
			List<Schools> school = (List<Schools>)commonDao.getDataByMap(map3, new Schools(), null, null, 0, -1);
			
//			map2.put("sno", ans.get(0).getClass_id());			
//			map4.put("sno", ans.get(0).getSection_id());	
//			List<Classes> classn = (List<Classes>)commonDao.getDataByMap(map2, new Classes(), null, null, 0, -1);
//			List<Section> section = (List<Section>)commonDao.getDataByMap(map4, new Section(), null, null, 0, -1);
			
			String emailContent = mailContent.replace("{{email}}", email)
				.replace("{{name}}", ans.get(0).getName())
				//.replace("{{img_url}}", mailTemplate.get(0).getLogo())
				.replace("{{school}}", school.get(0).getSchool_name())
				.replace("{{section}}", ans.get(0).getSection())
				.replace("{{class_name}}", ans.get(0).getClass_name())
				.replace("{{answer}}", ans.get(0).getAnswer());
			System.out.println("mail-content="+emailContent);
			
			 
			final String username = "query@quillclubwriters.com";
			final String password = "jppoqulkriijrvnc";
			Properties prop = new Properties();
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.port", "587");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			prop.put("mail.smtp.ssl.protocols", "TLSv1.2");

			Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			});
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject(subjectContent);
			message.setContent(emailContent, "text/html");
			Transport.send(message);
			System.out.println("Done");
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendSmsMessage(String mobileno, String otp, String email) {
		returnValue = false;

		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "application/x-www-form-urlencoded");
			final String url = "https://2factor.in/API/V1/4c8a2aa5-9b24-11e9-ade6-0200cd936042/ADDON_SERVICES/SEND/TSMS";
			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
			map.add("From", "MTESTS");
			map.add("To", mobileno);
			map.add("TemplateName", "VerifyOTP");
			map.add("VAR1", "User");
			map.add("VAR2", otp + " for email id: " + email);
			HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(map, headers);
			String result = restTemplate.postForObject(url, requestEntity, String.class);
			System.out.println(result);
			returnValue = true;
		} catch (Exception e) {
			returnValue = false;
		}
		return returnValue;
	}

}
