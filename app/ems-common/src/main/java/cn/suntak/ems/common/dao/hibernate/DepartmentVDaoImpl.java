package cn.suntak.ems.common.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.DepartmentVDao;
import cn.suntak.ems.common.domain.DepartmentV;

public class DepartmentVDaoImpl extends HibernateDao<DepartmentV,Long> implements DepartmentVDao{


    @Override
    public List<DepartmentV> getDeartmentList() {
        List<DepartmentV> departmentVs = this.loadAll();
        return departmentVs;
    }

	@Override
	public DepartmentV getDepartmentByUseD(String useD) {
		return this.findUniqueBy("flexValue",useD);
	}

    @Override
    public List<DepartmentV> getManageD() {
        List<DepartmentV> departmentVs = this.loadAll();
        return departmentVs;
    }

    @Override
    public List<DepartmentV> getUseD() {
        String hql = "from DepartmentV departmentV where departmentV.summaryFlag <> 'Y'";
        return this.find(hql,new ArrayList().toArray());
    }

    @Override
    public List<DepartmentV> getProcedure() {
        String hql = "from DepartmentV departmentV where departmentV.summaryFlag <> 'Y' and (departmentV.flexValue like '180%' or departmentV.flexValue like '181%')";
        return this.find(hql,new ArrayList().toArray());
    }
}
