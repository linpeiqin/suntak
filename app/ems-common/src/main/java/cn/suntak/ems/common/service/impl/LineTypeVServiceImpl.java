package cn.suntak.ems.common.service.impl;

import java.util.List;

import cn.suntak.ems.common.dao.LineTypeVDao;
import cn.suntak.ems.common.domain.LineTypeV;
import cn.suntak.ems.common.service.LineTypeVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class LineTypeVServiceImpl  implements LineTypeVService {
    private LineTypeVDao lineTypeVDao;

    public void setLineTypeVDao(LineTypeVDao lineTypeVDao) {
        this.lineTypeVDao = lineTypeVDao;
    }

	@Override
	public LineTypeV getLineTypeVBy(String lineTypeId) {
		// TODO Auto-generated method stub
		return this.lineTypeVDao.getLineTypeBy(lineTypeId);
	}
	@Override
	public List<LineTypeV> getLineTypeList() {
		// TODO Auto-generated method stub
		return this.lineTypeVDao.getLineTypeList();
	}
}
