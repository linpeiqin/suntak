package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;
import java.util.List;

import cn.oz.FileAuthor;
import cn.oz.FileEntity;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@SuppressWarnings("serial")
public class RepairPlan extends FileEntity {

	// fields =================================================================
	private Date lastTime;//LAST_REPAIR   上次维修
	private Date nextTime;//NEXT_REPAIR   下次维修
	private String maintenanceUnit;//MAINTENANCE_UNIT  维保单位
	private FileAuthor maintenancePeson;//MAINTENANCE_PERSON  维保人员
	private Integer state;//STATE   状态
	private String maintenanceProject;//MAINTENANCE_PROJECT  维保项目
	private String projectName;//维保项目名称
	private String maintenanceStandard;//MAINTENANCE_STANDARD  维保标准
	private String workDescription;//WORK_DESCRIPTION  工作描述
	private String type;
	private Date createdDate;
	private EquipmentDetails equipmentDetails;
    private Long organizationId;
    private Integer isOff;        //是否关闭 列值    0：未关闭     1：关闭
	private Long maintainId;//保养记录ID
	private Integer startIndex;       //开始标识 
	
	private List<RepairPlanRule> repairPlanRules;

	public Long getMaintainId() {
		return maintainId;
	}

	public void setMaintainId(Long maintainId) {
		this.maintainId = maintainId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public String getProjectName(){
		if(this.getMaintenanceProject() == null){
			return null;
		}else{
			return DataDictHelper.getDataDict("WBXM", this.getMaintenanceProject()).getName();
		}
	}
	public String getTypeName(){
		if(this.getType() == null){
			return null;
		}else{
			return DataDictHelper.getDataDict("RMType", this.getType()).getName();
		}
	}
	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public EquipmentDetails getEquipmentDetails() {
		return equipmentDetails;
	}

	public void setEquipmentDetails(EquipmentDetails equipmentDetails) {
		this.equipmentDetails = equipmentDetails;
	}


	public Date getLastTime() {
		return lastTime;
	}
	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}
	public String getLastTimeStr() {
		return DateTimeUtils.formatDateTime(this.lastTime);
	}
	public void setLastTimeStr(String lastTimeStr) {
		this.lastTime = DateTimeUtils.getDate(lastTimeStr);
	}

	public Date getNextTime() {
		return nextTime;
	}
	public void setNextTime(Date nextTime) {
		this.nextTime = nextTime;
	}

	public String getNextTimeStr() {
		return DateTimeUtils.formatDateTime(this.nextTime);
	}
	public void setNextTimeStr(String nextTimeStr) {
		this.nextTime = DateTimeUtils.getDate(nextTimeStr);
	}

	public String getMaintenanceUnit() {
		return maintenanceUnit;
	}
	public void setMaintenanceUnit(String maintenanceUnit) {
		this.maintenanceUnit = maintenanceUnit;
	}
	public FileAuthor getMaintenancePeson() {
		return maintenancePeson;
	}
	public void setMaintenancePeson(FileAuthor maintenancePeson) {
		this.maintenancePeson = maintenancePeson;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	
	

	public Integer getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(Integer startIndex) {
		this.startIndex = startIndex;
	}

	public String getMaintenanceProject() {
		return maintenanceProject;
	}
	public void setMaintenanceProject(String maintenanceProject) {
		this.maintenanceProject = maintenanceProject;
	}
	public String getMaintenanceStandard() {
		return maintenanceStandard;
	}
	public void setMaintenanceStandard(String maintenanceStandard) {
		this.maintenanceStandard = maintenanceStandard;
	}
	public String getWorkDescription() {
		return workDescription;
	}
	public void setWorkDescription(String workDescription) {
		this.workDescription = workDescription;
	}
	public Date getCreatedDate() {
		return this.createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getCreatedDateTime() {
		return DateTimeUtils.formatDateTime(this.createdDate);
	}

	public void setCreatedDateTime(String createdDateTime) {
		this.createdDate = DateTimeUtils.getDate(createdDateTime);
	}
	
	
	
	public Integer getIsOff() {
		return isOff;
	}

	public void setIsOff(Integer isOff) {
		this.isOff = isOff;
	}

	public List<RepairPlanRule> getRepairPlanRules() {
		return repairPlanRules;
	}

	public void setRepairPlanRules(List<RepairPlanRule> repairPlanRules) {
		this.repairPlanRules = repairPlanRules;
	}

	

	
	
}