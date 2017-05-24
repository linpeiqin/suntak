package cn.suntak.ems.common.dao.hibernate;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.PRLinesVDao;
import cn.suntak.ems.common.domain.PRLinesV;

import java.util.List;

/**
 * Created by Administrator on 2017/5/5.
 */
public class PRLinesVDaoImpl extends HibernateDao<PRLinesV, Long> implements PRLinesVDao {

    @Override
    public PRLinesV getPRLinesVBy(Long id) {
        return this.findUniqueBy("id",id);
    }
}
