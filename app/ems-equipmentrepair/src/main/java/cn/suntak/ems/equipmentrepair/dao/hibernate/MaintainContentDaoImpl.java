package cn.suntak.ems.equipmentrepair.dao.hibernate;

import org.hibernate.Query;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.dao.MaintainContentDao;
import cn.suntak.ems.equipmentrepair.domain.MaintainContent;

public  class MaintainContentDaoImpl extends SimpleDaoImpl<MaintainContent, Long> implements MaintainContentDao{


	@Override
	public void getPage(Page page, String dbftSearchParams,
			SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delByMaintainId(Long maintainId) {
		// TODO Auto-generated method stub
		Query q = this.getSession().createQuery("DELETE FROM MaintainContent WHERE maintain.id = ?");
		q.setLong(0, maintainId);
		return q.executeUpdate();
	}

}
