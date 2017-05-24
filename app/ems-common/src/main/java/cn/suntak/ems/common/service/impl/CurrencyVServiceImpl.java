package cn.suntak.ems.common.service.impl;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.CurrencyVDao;
import cn.suntak.ems.common.domain.CurrencyV;
import cn.suntak.ems.common.service.CurrencyVService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/12/10.
 */
public class CurrencyVServiceImpl  implements CurrencyVService {
    private CurrencyVDao currencyVDao;

    public void setCurrencyVDao(CurrencyVDao currencyVDao) {
        this.currencyVDao = currencyVDao;
    }

    @Override
    public List<SelectOption> getCurrencyOption() {
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<CurrencyV> currencyVs = this.currencyVDao.getCurrencyList();
        selectOptions.add(new SelectOption("CNY      人民币元","CNY"));
        for (CurrencyV currencyV : currencyVs){
        	if(currencyV.getCurrencyCode().equals("CNY"))
        		continue;
            selectOptions.add(new SelectOption(currencyV.getCurrencyCode()+"      "+currencyV.getCurrencyName(),currencyV.getCurrencyCode()));
        }
        return  selectOptions;
    }

	@Override
	public CurrencyV getCurrencyBy(String currencyCode) {
		// TODO Auto-generated method stub
		return this.currencyVDao.getCurrencyBy(currencyCode);
	}


}
