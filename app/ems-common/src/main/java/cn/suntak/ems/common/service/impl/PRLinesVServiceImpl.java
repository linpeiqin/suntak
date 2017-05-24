package cn.suntak.ems.common.service.impl;

import cn.suntak.ems.common.dao.PRLinesVDao;
import cn.suntak.ems.common.domain.PRLinesV;
import cn.suntak.ems.common.service.PRLinesVService;

import java.util.List;

/**
 * Created by Administrator on 2017/5/5.
 */
public class PRLinesVServiceImpl implements PRLinesVService {
    private PRLinesVDao pRLinesVDao;

    public void setpRLinesVDao(PRLinesVDao pRLinesVDao) {
        this.pRLinesVDao = pRLinesVDao;
    }


    @Override
    public PRLinesV getPRLinesVBy(Long id) {
        return this.pRLinesVDao.getPRLinesVBy(id);
    }
}
