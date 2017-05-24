package cn.suntak.ems.common.dao.hibernate;

import cn.oz.UserContextHolder;
import cn.oz.module.organize.dao.hibernate.OzGroupDaoImpl;
import cn.oz.module.organize.domain.OzGroup;
import cn.oz.organize.UserInfo;
import cn.suntak.ems.common.dao.EmsUserInfoDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by linking on 2017/4/12.
 */
public class EmsUserInfoDaoImpl extends OzGroupDaoImpl implements EmsUserInfoDao {

    @Override
    public Set<UserInfo> findAllByCode(String code) {
        String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
        List<Object> args = new ArrayList<Object>();
        String hql = "from OzGroup g where g.code = ? ";
        args.add(code);
        List<OzGroup> groups = this.find(hql, args.toArray());
        for (OzGroup group:groups){
            if (group.getOuInfo().getUnit().getCode().equals(orgId)){
                return group.getUserInfoSet();
            }
        }
        return null;
    }
}
