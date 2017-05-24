package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;

import cn.oz.FileEntity;

public class MonthPlanDetail extends FileEntity{

	/**
	 * 保养月计划详情
	 */
	private static final long serialVersionUID = 1L;
	private RepairMonthPlan repairMonthPlan;         //月计划
	private String procedure;                        //工序
	private Long equipmentId;                        //设备ID
	private String equipmentName;                    //设备名称
	private String equipmentNo;                      //设备编码
	private String maintenaceLevel;                  //保养级别
	private Date maintenaceDate;   	                 //保养日期
	private Integer maintenaceDay;                   //保养日
	private Date  factMaintenaceDate;   	                 //实际保养日期
	private Integer  factMaintenaceDay;   	                 //实际保养日
	public RepairMonthPlan getRepairMonthPlan() {
		return repairMonthPlan;
	}
	public void setRepairMonthPlan(RepairMonthPlan repairMonthPlan) {
		this.repairMonthPlan = repairMonthPlan;
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
	public Date getMaintenaceDate() {
		return maintenaceDate;
	}
	public void setMaintenaceDate(Date maintenaceDate) {
		this.maintenaceDate = maintenaceDate;
	}
	public Integer getMaintenaceDay() {
		return maintenaceDay;
	}
	public void setMaintenaceDay(Integer maintenaceDay) {
		this.maintenaceDay = maintenaceDay;
	}
	public Date getFactMaintenaceDate() {
		return factMaintenaceDate;
	}
	public void setFactMaintenaceDate(Date factMaintenaceDate) {
		this.factMaintenaceDate = factMaintenaceDate;
	}
	public Integer getFactMaintenaceDay() {
		return factMaintenaceDay;
	}
	public void setFactMaintenaceDay(Integer factMaintenaceDay) {
		this.factMaintenaceDay = factMaintenaceDay;
	}
	
	
}
