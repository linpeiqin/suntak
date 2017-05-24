package cn.suntak.ems.equipmentrepair.domain;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cn.oz.FileEntity;

public class RepairPlanRule extends FileEntity{

	/**
	 * 保养计划规则
	 */
	public static final int STATUS_ENABLE_VALUE = 0;
	public static final int STATUS_DEL_VALUE = 1;
	
	private static final long serialVersionUID = 1L;
	private RepairPlan repairPlan;    //保养计划
	private String maintenaceLevel;   //保养级别
	private Integer circulationMode;  //循环方式
	private Integer dayNum;           //执行日
	private Integer interval;         //间隔
	private Integer status;           //是否删除标志         0：启用        1：删除     
	private List<RepairPlanTime> repairPlanTimes;        //保养计划时间记录
	public RepairPlan getRepairPlan() {
		return repairPlan;
	}
	public void setRepairPlan(RepairPlan repairPlan) {
		this.repairPlan = repairPlan;
	}
	public String getMaintenaceLevel() {
		return maintenaceLevel;
	}
	public void setMaintenaceLevel(String maintenaceLevel) {
		this.maintenaceLevel = maintenaceLevel;
	}
	public Integer getCirculationMode() {
		return circulationMode;
	}
	public void setCirculationMode(Integer circulationMode) {
		this.circulationMode = circulationMode;
	}
	public Integer getDayNum() {
		return dayNum;
	}
	public void setDayNum(Integer dayNum) {
		this.dayNum = dayNum;
	}
	public Integer getInterval() {
		return interval;
	}
	public void setInterval(Integer interval) {
		this.interval = interval;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public List<RepairPlanTime> getRepairPlanTimes() {
		return repairPlanTimes;
	}
	public void setRepairPlanTimes(List<RepairPlanTime> repairPlanTimes) {
		this.repairPlanTimes = repairPlanTimes;
	}
	/**
	 * 获取已执行的保养计划时间记录
	 * @return
	 */
	public List<RepairPlanTime> getFinishRepairPlanTimes(){
		List<RepairPlanTime> finishTimes = new ArrayList<RepairPlanTime>();
		if(this.repairPlanTimes != null && !this.repairPlanTimes.isEmpty()){
			for(RepairPlanTime rt : this.repairPlanTimes){
				if(rt != null && rt.getStatus() == RepairPlanTime.STATUS_FINISH_VALUE)
					finishTimes.add(rt);
			}
		}
		return finishTimes;
	}
	
}
