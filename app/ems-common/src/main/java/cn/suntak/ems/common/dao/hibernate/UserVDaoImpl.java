package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.UserVDao;
import cn.suntak.ems.common.domain.UserV;

public class UserVDaoImpl extends HibernateDao<UserV,Long> implements UserVDao{


    @Override
    public List<UserV> getUserList() {
        List<UserV> userVs = this.loadAll();
        return userVs;
    }
}
