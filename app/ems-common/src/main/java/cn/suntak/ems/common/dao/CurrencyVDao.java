package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.CurrencyV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface CurrencyVDao {
    public List<CurrencyV> getCurrencyList();
    public CurrencyV getCurrencyBy(String currencyCode);
}
