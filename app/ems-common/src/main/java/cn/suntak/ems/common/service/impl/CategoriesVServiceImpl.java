package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.CategoriesVDao;
import cn.suntak.ems.common.domain.CategoriesV;
import cn.suntak.ems.common.service.CategoriesVService;

public class CategoriesVServiceImpl implements CategoriesVService {
    private CategoriesVDao categoriesVDao;

    public void setCategoriesVDao(CategoriesVDao categoriesVDao) {
        this.categoriesVDao = categoriesVDao;
    }
	@Override
	public List<SelectOption> getCategoriesOption() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		List<CategoriesV> categoriesV = this.categoriesVDao.getCategoriesList();
		for (CategoriesV CategoriesV : categoriesV) {
			selectOptions.add(new SelectOption(CategoriesV.getFaCategory(),
					CategoriesV.getFaCategory()));
		}
		return selectOptions;
	}
}
