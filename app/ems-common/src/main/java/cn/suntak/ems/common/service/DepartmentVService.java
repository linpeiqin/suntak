package cn.suntak.ems.common.service;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.DepartmentV;

import java.util.List;

public interface DepartmentVService {
    List<SelectOption> getDepartmentOption();
    List<SelectOption> getManageDepartmentOption();
    List<SelectOption> getUsedDepartmentOption();
    DepartmentV getDepartmentByUseD(String useD);

    List<SelectOption> getProcedureOption();
}
