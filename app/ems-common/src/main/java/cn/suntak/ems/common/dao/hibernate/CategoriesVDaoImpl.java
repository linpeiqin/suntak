package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.CategoriesVDao;
import cn.suntak.ems.common.domain.CategoriesV;

public class CategoriesVDaoImpl extends HibernateDao<CategoriesV,Long> implements CategoriesVDao{

	@Override
	public List<CategoriesV> getCategoriesList() {
		// TODO Auto-generated method stub
		  List<CategoriesV> categoriesVs = this.loadAll();
	        return categoriesVs;
	}
}
