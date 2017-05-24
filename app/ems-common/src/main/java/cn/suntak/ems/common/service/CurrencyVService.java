package cn.suntak.ems.common.service;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.CurrencyV;

import java.util.List;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface CurrencyVService {

    List<SelectOption> getCurrencyOption();

    CurrencyV getCurrencyBy(String currencyCode);
}
