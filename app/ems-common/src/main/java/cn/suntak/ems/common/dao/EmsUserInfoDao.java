package cn.suntak.ems.common.dao;

import cn.oz.module.organize.dao.OzGroupDao;
import cn.oz.organize.UserInfo;

import java.util.List;
import java.util.Set;

/**
 * Created by linking on 2017/4/12.
 */
public interface EmsUserInfoDao extends OzGroupDao {
    Set<UserInfo> findAllByCode(String code);
}
