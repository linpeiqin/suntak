package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.PoMethodVDao;
import cn.suntak.ems.common.domain.PoMethodV;
import cn.suntak.ems.common.service.PoMethodVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class PoMethodVServiceImpl implements PoMethodVService {
    private PoMethodVDao poMethodVDao;

    public void setPoMethodVDao(PoMethodVDao poMethodVDao) {
        this.poMethodVDao = poMethodVDao;
    }

	@Override
	public List<SelectOption> getPoMethodOption() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		List<PoMethodV> poMethodVs = this.poMethodVDao.getPoMethodList();
		selectOptions.add(new SelectOption("", ""));
		for (PoMethodV poMethodV : poMethodVs) {
			if (null != poMethodV.getPoMethod())
				selectOptions.add(new SelectOption(poMethodV.getPoMethod(), poMethodV.getPoMethod()));
		}
		return selectOptions;
	}

}
