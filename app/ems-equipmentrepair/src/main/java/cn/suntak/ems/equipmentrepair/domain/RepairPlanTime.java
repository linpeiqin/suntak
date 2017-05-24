package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;

import cn.oz.FileEntity;
/**
 * 保养计划时间记录
 * @author wulk
 *
 */
public class RepairPlanTime extends FileEntity{
	
	/**
	 * 
	 */
	public static final int STATUS_WAIT_VALUE = 0;       //待执行
	public static final int STATUS_PUSH_VALUE = 1;       //已推送
	public static final int STATUS_FINISH_VALUE = 2;     //已执行
	
	private static final long serialVersionUID = 1L;
	private RepairPlanRule repairPlanRule;     //保养规则
	private Date planDate;                     //计划日期
	private Date actualDate;                   //实际日期
	private Integer status;                    //状态
	private Long organizationId;               //组织ID 便于检索
	public RepairPlanRule getRepairPlanRule() {
		return repairPlanRule;
	}
	public void setRepairPlanRule(RepairPlanRule repairPlanRule) {
		this.repairPlanRule = repairPlanRule;
	}
	public Date getPlanDate() {
		return planDate;
	}
	public void setPlanDate(Date planDate) {
		this.planDate = planDate;
	}
	public Date getActualDate() {
		return actualDate;
	}
	public void setActualDate(Date actualDate) {
		this.actualDate = actualDate;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Long getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}
	
	

}
