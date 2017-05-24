package cn.suntak.ems.common.dao;

import cn.suntak.ems.common.domain.DepartmentV;

import java.util.List;

public interface DepartmentVDao {
    List<DepartmentV> getDeartmentList();

    DepartmentV getDepartmentByUseD(String useD);

    List<DepartmentV> getManageD();

    List<DepartmentV> getUseD();

    List<DepartmentV> getProcedure();
}

