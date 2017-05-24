package cn.suntak.ems.common.service.impl;

import cn.suntak.ems.common.dao.hibernate.UserVDaoImpl;
import cn.suntak.ems.common.service.UserVService;

public class UserVServiceImpl implements UserVService {

    private UserVDaoImpl userVDao;

    public void setUserVDao(UserVDaoImpl userVDao) {
        this.userVDao = userVDao;
    }

    public UserVDaoImpl getUserVDao() {
        return userVDao;
    }
}
