package cn.suntak.ems.equipmentrepair.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.Author;
import cn.oz.FileAuthor;
import cn.oz.FileEntity;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.util.DateTimeUtils;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@SuppressWarnings("serial")
public class RepairRecord extends FileEntity {

	// constants ==============================================================
	/** 状态： 已报修 REPAIR*/
	public static final Integer SUBMIT_MAINTENANCE 		= 0;
	/** 状态： 已分配 DISTRIBUTION*/
	public static final Integer DISTRIBUTION 				= 1;
	/** 状态： 已维修 BEEN_REPAIRED*/
	public static final Integer BEEN_REPAIRED 				= 2;
	/** 状态： 已关闭 ALREADY_CLOSED*/
	public static final Integer ALREADY_CLOSED 			= 3;

	private Integer status;     //状态

	// fields =================================================================
	private String eDegree;    //E_DEGREE  紧急程度
	private String maintenanceNo;  //MAINTENANCE_NO   维修单号


	private Date maintenanceTime;//MAINTENANCE_TIME   送修时间
	private String faultDescription;//FAULT_DESCRIPTION 故障描述
	private String maintenanceUnit;//MAINTENANCE_UNIT  维修单位

	private Integer maintenaceState;//MAINTENANCE_STATE  维修状态
	private String maintenaceLevel;//MAINTENANCE_LEVE  维修级别
	private String faultClass;//FAULT_CLASS  故障类别
	private Date startTime;//START_TIME 开始时间
	private Date endTime;//END_TIME  完成时间
	private Double maintenanceCost; //MAINTENANCE_COST  维修费用
	private String downTime;//DOWN_TIME 停机时长
	private String timeCost;//TIME_COST  维修耗时
	private String faultSolve;//FAULT_SOLVE 故障分析及处理
	private String userScore;//USER_SCORE 用户评分
	private String userOpinion;//USER_OPINION 用户意见
	private Date createdDate;//CREATED_TIME 创建时间
	private String createdBy;//CREATED_BY 创建人
	private Date updatedDate;//UPDATED_TIME 修股时间
	private String updatedBy;//UPDATED_BY 修改人
	private Long organizationId;

	private EquipmentDetails equipmentDetails;
	private Set<PartReplace> partReplaces;


	private FileAuthor maintenanceApplicant;//MAINTENANCE_APLLICANT 维修申请人
	private FileAuthor distributor;//distributor  分配人
	private FileAuthor maintenancePerson;//MAINTENANCE_PERSON  维修人

	

    private Date distributionDate;  // 分配时间
    private Integer repairMode;        //维修方式          0：自修  1：外修
    private Integer billMode;          //开单方式           0：生产开单   1：自开单
    private Integer timeOccupy;        //是否占用生产时间     0：否     1：是

	public FileAuthor getMaintenanceApplicant() {
		return maintenanceApplicant;
	}

	public void setMaintenanceApplicant(FileAuthor maintenanceApplicant) {
		this.maintenanceApplicant = maintenanceApplicant;
	}

	public FileAuthor getDistributor() {
		return distributor;
	}

	public void setDistributor(FileAuthor distributor) {
		this.distributor = distributor;
	}

	public FileAuthor getMaintenancePerson() {
		return maintenancePerson;
	}

	public void setMaintenancePerson(FileAuthor maintenancePerson) {
		this.maintenancePerson = maintenancePerson;
	}

	public String getFaultClassName() {
		if(StringUtils.isNullString(this.getFaultClass()))
			return null;
		else
		    return DataDictHelper.getDataDict("GZLB",this.getFaultClass()).getName();
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}


	public Set<PartReplace> getPartReplaces() {
		return partReplaces;
	}

	public void setPartReplaces(Set<PartReplace> partReplaces) {
		this.partReplaces = partReplaces;
	}

	public EquipmentDetails getEquipmentDetails() {
		return equipmentDetails;
	}

	public void setEquipmentDetails(EquipmentDetails equipmentDetails) {
		this.equipmentDetails = equipmentDetails;
	}

	
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public String geteDegree() {
		return eDegree;
	}

	public void seteDegree(String eDegree) {
		this.eDegree = eDegree;
	}

	public String getMaintenanceNo() {
		return maintenanceNo;
	}

	public void setMaintenanceNo(String maintenanceNo) {
		this.maintenanceNo = maintenanceNo;
	}


	public Date getMaintenanceTime() {
		return maintenanceTime;
	}
	public void setMaintenanceTime(Date maintenanceTime) {
		this.maintenanceTime = maintenanceTime;
	}
	public String getMaintenanceTimeStr() {
		return DateTimeUtils.formatDateTime(this.maintenanceTime);
	}

	public void setMaintenanceTimeStr(String maintenanceTime) {
		this.maintenanceTime = DateTimeUtils.getDate(maintenanceTime);
	}

	public String getFaultDescription() {
		return faultDescription;
	}

	public void setFaultDescription(String faultDescription) {
		this.faultDescription = faultDescription;
	}

	public String getMaintenanceUnit() {
		return maintenanceUnit;
	}

	public void setMaintenanceUnit(String maintenanceUnit) {
		this.maintenanceUnit = maintenanceUnit;
	}



	public Integer getMaintenaceState() {
		return maintenaceState;
	}

	public void setMaintenaceState(Integer maintenaceState) {
		this.maintenaceState = maintenaceState;
	}

	public String getMaintenaceLevel() {
		return maintenaceLevel;
	}

	public void setMaintenaceLevel(String maintenaceLevel) {
		this.maintenaceLevel = maintenaceLevel;
	}

	public String getFaultClass() {
		return faultClass;
	}

	public void setFaultClass(String faultClass) {
		this.faultClass = faultClass;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getStartTimeStr() {
		return DateTimeUtils.formatDateTime(this.startTime);
	}

	public void setStartTimeStr(String startTime) {
		this.startTime = DateTimeUtils.getDate(startTime);
	}
	public String getEndTimeStr() {
		return DateTimeUtils.formatDateTime(this.endTime);
	}

	public void setEndTimeStr(String endTime) {
		this.endTime = DateTimeUtils.getDate(endTime);
	}
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Double getMaintenanceCost() {
		return maintenanceCost;
	}

	public void setMaintenanceCost(Double maintenanceCost) {
		this.maintenanceCost = maintenanceCost;
	}

	public String getDownTime() {
		return downTime;
	}

	public void setDownTime(String downTime) {
		this.downTime = downTime;
	}

	public String getTimeCost() {
		return timeCost;
	}

	public void setTimeCost(String timeCost) {
		this.timeCost = timeCost;
	}

	public String getFaultSolve() {
		return faultSolve;
	}

	public void setFaultSolve(String faultSolve) {
		this.faultSolve = faultSolve;
	}

	public String getUserScore() {
		return userScore;
	}

	public void setUserScore(String userScore) {
		this.userScore = userScore;
	}

	public String getUserOpinion() {
		return userOpinion;
	}

	public void setUserOpinion(String userOpinion) {
		this.userOpinion = userOpinion;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getDistributionDate() {
		return distributionDate;
	}

	public void setDistributionDate(Date distributionDate) {
		this.distributionDate = distributionDate;
	}



	public Integer getRepairMode() {
		return repairMode;
	}

	public void setRepairMode(Integer repairMode) {
		this.repairMode = repairMode;
	}
	
	

	public Integer getBillMode() {
		return billMode;
	}

	public void setBillMode(Integer billMode) {
		this.billMode = billMode;
	}
	
	

	public Integer getTimeOccupy() {
		return timeOccupy;
	}

	public void setTimeOccupy(Integer timeOccupy) {
		this.timeOccupy = timeOccupy;
	}

	public String geteDegreeName() {
		if(StringUtils.isNullString(this.geteDegree()))
			return null;
		else
		    return DataDictHelper.getDataDict("REPAIR-DEGREE",this.geteDegree()).getName();
	}

	public String getMaintenaceLevelName() {
		if(StringUtils.isNullString(this.getMaintenaceLevel()))
			return null;
		else
		    return DataDictHelper.getDataDict("REPAIR-LEVEL",this.getMaintenaceLevel()).getName();
	}
}