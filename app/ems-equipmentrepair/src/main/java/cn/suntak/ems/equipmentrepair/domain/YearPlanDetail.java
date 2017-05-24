package cn.suntak.ems.equipmentrepair.domain;

import cn.oz.FileEntity;

public class YearPlanDetail extends FileEntity{
	/**
	 * 保养年计划详情
	 */
	private static final long serialVersionUID = 1L;
	private RepairYearPlan repairYearPlan;           //年计划
	private String procedure;                        //工序
	private Long equipmentId;                        //设备ID
	private String equipmentName;                    //设备名称
	private String equipmentNo;                      //设备编码
	private String maintenaceLevel;                 //保养级别
	private Integer maintenaceMonth;   	             //保养月份
	public RepairYearPlan getRepairYearPlan() {
		return repairYearPlan;
	}
	public void setRepairYearPlan(RepairYearPlan repairYearPlan) {
		this.repairYearPlan = repairYearPlan;
	}
	public String getProcedure() {
		return procedure;
	}
	public void setProcedure(String procedure) {
		this.procedure = procedure;
	}
	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquipmentName() {
		return equipmentName;
	}
	public void setEquipmentName(String equipmentName) {
		this.equipmentName = equipmentName;
	}
	public String getEquipmentNo() {
		return equipmentNo;
	}
	public void setEquipmentNo(String equipmentNo) {
		this.equipmentNo = equipmentNo;
	}
	public String getMaintenaceLevel() {
		return maintenaceLevel;
	}
	public void setMaintenaceLevel(String maintenaceLevel) {
		this.maintenaceLevel = maintenaceLevel;
	}
	public Integer getMaintenaceMonth() {
		return maintenaceMonth;
	}
	public void setMaintenaceMonth(Integer maintenaceMonth) {
		this.maintenaceMonth = maintenaceMonth;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
