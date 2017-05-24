package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.LineTypeVDao;
import cn.suntak.ems.common.domain.LineTypeV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class LineTypeVDaoImpl extends HibernateDao<LineTypeV, Long> implements LineTypeVDao {

	@Override
	public List<LineTypeV> getLineTypeList() {
		// TODO Auto-generated method stub
		List<LineTypeV> lineTypeVs = this.loadAll();
	    return lineTypeVs;
	}

	@Override
	public LineTypeV getLineTypeBy(String lineTypeId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("lineTypeId",lineTypeId);
	}
}
