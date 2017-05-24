package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.DepartmentVDao;
import cn.suntak.ems.common.domain.DepartmentV;
import cn.suntak.ems.common.service.DepartmentVService;

public class DepartmentVServiceImpl implements DepartmentVService {
    private DepartmentVDao departmentVDao;

    public void setDepartmentVDao(DepartmentVDao departmentVDao) {
        this.departmentVDao = departmentVDao;
    }

    @Override
    public  List<SelectOption> getDepartmentOption() {
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<DepartmentV> departmentVs = this.departmentVDao.getDeartmentList();
        for (DepartmentV departmentV : departmentVs){
            selectOptions.add(new SelectOption(departmentV.getFlexValue()+"   "+departmentV.getDescription(),departmentV.getFlexValue()));
        }
        return  selectOptions;
    }

    @Override
    public List<SelectOption> getManageDepartmentOption() {
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<DepartmentV> departmentVs = this.departmentVDao.getManageD();
        for (DepartmentV departmentV : departmentVs){
            if(departmentV.getFlexValue().equals("0"))
                continue;
            selectOptions.add(new SelectOption(departmentV.getFlexValue()+"   "+departmentV.getDescription(),departmentV.getFlexValue()));
        }
        return  selectOptions;
    }

    @Override
    public List<SelectOption> getUsedDepartmentOption() {
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<DepartmentV> departmentVs = this.departmentVDao.getUseD();
        for (DepartmentV departmentV : departmentVs){
            selectOptions.add(new SelectOption(departmentV.getFlexValue()+"   "+departmentV.getDescription(),departmentV.getFlexValue()));
        }
        return  selectOptions;
    }

    @Override
    public DepartmentV getDepartmentByUseD(String useD) {
        return this.departmentVDao.getDepartmentByUseD(useD);
    }

    @Override
    public List<SelectOption> getProcedureOption() {
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<DepartmentV> departmentVs = this.departmentVDao.getProcedure();
        for (DepartmentV departmentV : departmentVs){
            selectOptions.add(new SelectOption(departmentV.getFlexValue()+"   "+departmentV.getDescription(),departmentV.getFlexValue()));
        }
        return  selectOptions;
    }
}
