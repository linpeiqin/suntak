package com.seeyon.www.dao.hibernate;

import cn.oz.dao.hibernate.SimpleDaoImpl;

import com.seeyon.www.dao.SeeyonDao;
import com.seeyon.www.domain.Seeyon;

public class SeeyonDaoImpl  extends SimpleDaoImpl<Seeyon, Long> implements SeeyonDao {

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
