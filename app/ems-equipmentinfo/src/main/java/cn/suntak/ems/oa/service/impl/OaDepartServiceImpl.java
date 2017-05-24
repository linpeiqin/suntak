package cn.suntak.ems.oa.service.impl;

import cn.suntak.ems.oa.dao.OaDepartDao;
import cn.suntak.ems.oa.service.OaDepartService;

import java.text.DecimalFormat;

public class OaDepartServiceImpl implements OaDepartService {

    private OaDepartDao oaDepartDao;
    @Override
    public String getOaDepartId(String code) {
        DecimalFormat df = new DecimalFormat("0000");
        String oaCode = df.format(new Integer(code));//流水号
        String oaId = this.oaDepartDao.getOaDepartId(oaCode);
        return oaId;
    }

    public OaDepartDao getOaDepartDao() {
        return oaDepartDao;
    }

    public void setOaDepartDao(OaDepartDao oaDepartDao) {
        this.oaDepartDao = oaDepartDao;
    }
}
