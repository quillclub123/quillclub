package com.quillBolt.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.quillBolt.model.MailTemplate;

@Repository

public class MailTemplateDao {

	@Autowired
	private SessionFactory sessionFactory;
	@Transactional
	public List<MailTemplate> getTemplate(String templateid) {
		System.out.println(templateid);
		Criteria criteria=sessionFactory.getCurrentSession().createCriteria(MailTemplate.class);
		criteria.add(Restrictions.eq("templateType", templateid));
		criteria.add(Restrictions.eq("status", "Active"));
		List<MailTemplate> list=criteria.list();
		
		return list;
		
	}
}
