package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.FileEntity;

public class RepairMonthPlan extends FileEntity{

	/**
	 * 保养月计划表
	 */
	public static final int STATUS_DEF = 0;      //初始状态
	public static final int STATUS_COMMIT = 1;   //提交状态
	
	
	private static final long serialVersionUID = 1L;
	private String planMonth;         //计划月
	private Date planTime;			  //做计划时间
	private String remark;            //备注
	private Integer status;           //状态
	private String plannerName;       //计划者姓名
	private Long plannerId;           //计划者ID
	private Long organizationId;
	private Set<MonthPlanDetail> monthPlanDetails;
	public String getPlanMonth() {
		return planMonth;
	}
	public void setPlanMonth(String planMonth) {
		this.planMonth = planMonth;
	}
	public Date getPlanTime() {
		return planTime;
	}
	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getPlannerName() {
		return plannerName;
	}
	public void setPlannerName(String plannerName) {
		this.plannerName = plannerName;
	}
	public Long getPlannerId() {
		return plannerId;
	}
	public void setPlannerId(Long plannerId) {
		this.plannerId = plannerId;
	}
	
	public Long getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}
	public Set<MonthPlanDetail> getMonthPlanDetails() {
		return monthPlanDetails;
	}
	public void setMonthPlanDetails(Set<MonthPlanDetail> monthPlanDetails) {
		this.monthPlanDetails = monthPlanDetails;
	}
	
	
}
