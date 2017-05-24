package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.FileEntity;

public class RepairYearPlan extends FileEntity{

	/**
	 * 保养年计划表
	 */
	public static final int STATUS_DEF = 0;      //初始状态
	public static final int STATUS_COMMIT = 1;   //提交状态
	
	
	private static final long serialVersionUID = 1L;
	private String planYear;          //计划年
	private Date planTime;			  //做计划时间
	private String remark;            //备注
	private Integer status;           //状态
	private String plannerName;       //计划者姓名
	private Long plannerId;           //计划者ID
	private Set<YearPlanDetail> yearPlanDetails;
	private Long organizationId;
	public String getPlanYear() {
		return planYear;
	}
	public void setPlanYear(String planYear) {
		this.planYear = planYear;
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
	
	
	public Set<YearPlanDetail> getYearPlanDetails() {
		return yearPlanDetails;
	}
	public void setYearPlanDetails(Set<YearPlanDetail> yearPlanDetails) {
		this.yearPlanDetails = yearPlanDetails;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Long getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}
	
}
