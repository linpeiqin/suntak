package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;
import java.util.List;

import cn.oz.FileAuthor;
import cn.oz.FileEntity;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

@SuppressWarnings("serial")
public class Maintain extends FileEntity {
	
	public static final int STATUS_WAIT_VALUE = 0;       //待执行
	public static final int STATUS_FINISH_VALUE = 1;       //待执行

	private String maintainLevel;//MAINTAIN_LEVEL   保养级别
	private Date planDate;   //计划日期
	private Date executTime;//EXECUTE_DATE   执行时间
	private EquipmentDetails equipmentDetails;
	private FileAuthor maintainPerson;//MAAINTAIN_PERSON  保养人
/*	private String number;// NUMBER    编号
*/	private String maintainResult;//MAINTAIN_RESULT  保养结果
	private String mltUseState;//MLT_USE_STATE  物料使用情况
	private String processAccept;//PROCESS_ACCEPT  工序验收
	private Date acceptDate;//ACCEPT_DATE  工序验收日期
	private String processValidate;//PROCESS_VALIDATE  工艺确认
	private Date validateDate;//VALIDATE_DATE  工艺确认日期
	private String qaVerificate;//QA_VERIFICATE  品保确认
	private Date verificateDate;//VERIFICATE_DATE  品保确认日期
	private String equipmentRP;//EQUIPMENT_R_P  设备责任人
	private Date rpDate;//R_P_DATE  责任人日期
	private String equipmentAudit;//EUQIPMENT_AUDIT  设备部审核
	private Date auditDate;//AUDIT_DATE  设备部审核日期
	private Integer status;       //状态
	private Long organizationId;//组织ID
	private Long repairTimeId;//保养计划时间ID
	private List<MaintainContent>  maintainContents;

	

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public List<MaintainContent> getMaintainContents() {
		return maintainContents;
	}

	public void setMaintainContents(List<MaintainContent> maintainContents) {
		this.maintainContents = maintainContents;
	}

	public EquipmentDetails getEquipmentDetails() {
		return equipmentDetails;
	}

	public void setEquipmentDetails(EquipmentDetails equipmentDetails) {
		this.equipmentDetails = equipmentDetails;
	}

	public String getMaintainLevel() {
		return maintainLevel;
	}
	public void setMaintainLevel(String maintainLevel) {
		this.maintainLevel = maintainLevel;
	}
	public Date getExecutTime() {
		return executTime;
	}
	public void setExecutTime(Date executTime) {
		this.executTime = executTime;
	}
	public String getExecutTimeStr() {
		return DateTimeUtils.formatDateTime(this.executTime);
	}

	public void setExecutTimeStr(String executTime) {
		this.executTime = DateTimeUtils.getDate(executTime);
	}
	public FileAuthor getMaintainPerson() {
		return maintainPerson;
	}
	public void setMaintainPerson(FileAuthor maintainPerson) {
		this.maintainPerson = maintainPerson;
	}
	public String getMaintainResult() {
		return maintainResult;
	}
	public void setMaintainResult(String maintainResult) {
		this.maintainResult = maintainResult;
	}
	public String getMltUseState() {
		return mltUseState;
	}
	public void setMltUseState(String mltUseState) {
		this.mltUseState = mltUseState;
	}
	public String getProcessAccept() {
		return processAccept;
	}
	public void setProcessAccept(String processAccept) {
		this.processAccept = processAccept;
	}
	public Date getAcceptDate() {
		return acceptDate;
	}
	public void setAcceptDate(Date acceptDate) {
		this.acceptDate = acceptDate;
	}
	public String getAcceptDateStr() {
		return DateTimeUtils.formatDateTime(this.acceptDate);
	}

	public void setAcceptDateStr(String acceptDate) {
		this.acceptDate = DateTimeUtils.getDate(acceptDate);
	}
	public String getProcessValidate() {
		return processValidate;
	}
	public void setProcessValidate(String processValidate) {
		this.processValidate = processValidate;
	}
	public Date getValidateDate() {
		return validateDate;
	}
	public void setValidateDate(Date validateDate) {
		this.validateDate = validateDate;
	}
	public String getValidateDateStr() {
		return DateTimeUtils.formatDateTime(this.validateDate);
	}

	public void setValidateDateStr(String validateDate) {
		this.validateDate = DateTimeUtils.getDate(validateDate);
	}
	public String getQaVerificate() {
		return qaVerificate;
	}
	public void setQaVerificate(String qaVerificate) {
		this.qaVerificate = qaVerificate;
	}
	public Date getVerificateDate() {
		return verificateDate;
	}
	public void setVerificateDate(Date verificateDate) {
		this.verificateDate = verificateDate;
	}
	public String getVerificateDateStr() {
		return DateTimeUtils.formatDateTime(this.verificateDate);
	}

	public void setVerificateDateStr(String verificateDate) {
		this.verificateDate = DateTimeUtils.getDate(verificateDate);
	}
	public String getEquipmentRP() {
		return equipmentRP;
	}
	public void setEquipmentRP(String equipmentRP) {
		this.equipmentRP = equipmentRP;
	}
	public Date getRpDate() {
		return rpDate;
	}
	public void setRpDate(Date rpDate) {
		this.rpDate = rpDate;
	}
	public String getRpDateStr() {
		return DateTimeUtils.formatDateTime(this.rpDate);
	}

	public void setRpDateStr(String rpDate) {
		this.rpDate = DateTimeUtils.getDate(rpDate);
	}
	public String getEquipmentAudit() {
		return equipmentAudit;
	}
	public void setEquipmentAudit(String equipmentAudit) {
		this.equipmentAudit = equipmentAudit;
	}
	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getAuditDateStr() {
		return DateTimeUtils.formatDateTime(this.auditDate);
	}

	public void setAuditDateStr(String auditDate) {
		this.auditDate = DateTimeUtils.getDate(auditDate);
	}
	
	
	public Date getPlanDate() {
		return planDate;
	}

	public void setPlanDate(Date planDate) {
		this.planDate = planDate;
	}
	
	public String getPlanDateStr() {
		return DateTimeUtils.formatDate(this.planDate);
	}

	public void setPlanDateStr(String planDate) {
		this.planDate = DateTimeUtils.getDate(planDate);
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getRepairTimeId() {
		return repairTimeId;
	}

	public void setRepairTimeId(Long repairTimeId) {
		this.repairTimeId = repairTimeId;
	}

}
