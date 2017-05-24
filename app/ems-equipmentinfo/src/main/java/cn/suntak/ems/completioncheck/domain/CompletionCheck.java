package cn.suntak.ems.completioncheck.domain;


import java.util.Date;

import cn.oz.annotation.AttachmentSupport;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class CompletionCheck extends EMSEntity {


	// fields =================================================================
	private String type;
	private String number;//编号
	private String contractNumber;//合同编号
	private String projectName;//工程项目名称
	private Long assetsNumber;//数    量
	private String ascriptionMD;//归口管理部门
	private String contractingUnit;//承 包 单 位
	private String constructionUnit;//施 工 单 位
	private String WPT;//工作原理及主要技术指标
	private Date constructionStartTime;//开始施工时间
	private Date makespan;//完 工 时 间
	private String installationLocation;//安 装 地 点
	private String useD;//使 用 部 门
	private String installationPersonnel;//安装调试人员
	private String estimateUsefulLife;//预计使用年限

	private String mainRecordIndex;//主要技术指标
	private String testRecord;//测试记录
	private String conclusion;//结论
	private String acceptancePersonT;//技术部门验收人
	private String technicalMH;//技术部门负责人

	private String engineeringInspection;//工程效果检查/完工验收情况
	private String acceptancePersonM ;//归口管理部门验收人
	private String putUnderDMH;//归口管理部门部门负责人

	private String useDOpinion;//使用部门意见
	private String useDCharge;//使用部门主管
	private String useDMH;//使用部门负责人

	private String engineeringValue;//工程价值
	private String financeFillPerson;//财务部填写人
	private String financeDMH;//财务部部门负责人
	private String GM;//总经理
	private String chairman;//董事长
	private String projectInformation;//工程项目资料
	private String recipient;//接收人
	private Date createdDate;   //创建日期    CREATED_DATE
	private String createdBy;  //创建人    CREATED_BY
	private Date updatedDate;  //修改日期    UPDATED_DATE
	private String updatedBy;  //修改人      UPDATED_BY
    private EquipmentLifeCycle equipmentLifeCycle;
    
    @SuppressWarnings("unused")
	private String typeName;
    private Long organizationId;

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	
	
	public String getTypeName() {
		return DataDictHelper.getDataDict("LIFE-CYCLE", this.getType()).getName();
	}
	
	
	public EquipmentLifeCycle getEquipmentLifeCycle() {
		return equipmentLifeCycle;
	}

	public void setEquipmentLifeCycle(EquipmentLifeCycle equipmentLifeCycle) {
		this.equipmentLifeCycle = equipmentLifeCycle;
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

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getContractNumber() {
		return contractNumber;
	}

	public void setContractNumber(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}


	public String getAscriptionMD() {
		return ascriptionMD;
	}

	public void setAscriptionMD(String ascriptionMD) {
		this.ascriptionMD = ascriptionMD;
	}

	public String getContractingUnit() {
		return contractingUnit;
	}

	public void setContractingUnit(String contractingUnit) {
		this.contractingUnit = contractingUnit;
	}

	public String getConstructionUnit() {
		return constructionUnit;
	}

	public void setConstructionUnit(String constructionUnit) {
		this.constructionUnit = constructionUnit;
	}

	public String getWPT() {
		return WPT;
	}

	public void setWPT(String WPT) {
		this.WPT = WPT;
	}


	public String getInstallationLocation() {
		return installationLocation;
	}

	public void setInstallationLocation(String installationLocation) {
		this.installationLocation = installationLocation;
	}

	public String getUseD() {
		return useD;
	}

	public void setUseD(String useD) {
		this.useD = useD;
	}

	public String getInstallationPersonnel() {
		return installationPersonnel;
	}

	public void setInstallationPersonnel(String installationPersonnel) {
		this.installationPersonnel = installationPersonnel;
	}

	public String getEstimateUsefulLife() {
		return estimateUsefulLife;
	}

	public void setEstimateUsefulLife(String estimateUsefulLife) {
		this.estimateUsefulLife = estimateUsefulLife;
	}

	public String getMainRecordIndex() {
		return mainRecordIndex;
	}

	public void setMainRecordIndex(String mainRecordIndex) {
		this.mainRecordIndex = mainRecordIndex;
	}

	public String getTestRecord() {
		return testRecord;
	}

	public void setTestRecord(String testRecord) {
		this.testRecord = testRecord;
	}

	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public String getAcceptancePersonT() {
		return acceptancePersonT;
	}

	public void setAcceptancePersonT(String acceptancePersonT) {
		this.acceptancePersonT = acceptancePersonT;
	}

	public String getTechnicalMH() {
		return technicalMH;
	}

	public void setTechnicalMH(String technicalMH) {
		this.technicalMH = technicalMH;
	}

	public String getEngineeringInspection() {
		return engineeringInspection;
	}

	public void setEngineeringInspection(String engineeringInspection) {
		this.engineeringInspection = engineeringInspection;
	}

	public String getAcceptancePersonM() {
		return acceptancePersonM;
	}

	public void setAcceptancePersonM(String acceptancePersonM) {
		this.acceptancePersonM = acceptancePersonM;
	}

	public String getPutUnderDMH() {
		return putUnderDMH;
	}

	public void setPutUnderDMH(String putUnderDMH) {
		this.putUnderDMH = putUnderDMH;
	}

	public String getUseDOpinion() {
		return useDOpinion;
	}

	public void setUseDOpinion(String useDOpinion) {
		this.useDOpinion = useDOpinion;
	}

	public String getUseDCharge() {
		return useDCharge;
	}

	public void setUseDCharge(String useDCharge) {
		this.useDCharge = useDCharge;
	}

	public String getUseDMH() {
		return useDMH;
	}

	public void setUseDMH(String useDMH) {
		this.useDMH = useDMH;
	}

	public String getEngineeringValue() {
		return engineeringValue;
	}

	public void setEngineeringValue(String engineeringValue) {
		this.engineeringValue = engineeringValue;
	}

	public String getFinanceFillPerson() {
		return financeFillPerson;
	}

	public void setFinanceFillPerson(String financeFillPerson) {
		this.financeFillPerson = financeFillPerson;
	}

	public String getFinanceDMH() {
		return financeDMH;
	}

	public void setFinanceDMH(String financeDMH) {
		this.financeDMH = financeDMH;
	}

	public String getGM() {
		return GM;
	}

	public void setGM(String GM) {
		this.GM = GM;
	}

	public String getChairman() {
		return chairman;
	}

	public void setChairman(String chairman) {
		this.chairman = chairman;
	}

	public String getProjectInformation() {
		return projectInformation;
	}

	public void setProjectInformation(String projectInformation) {
		this.projectInformation = projectInformation;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getAssetsNumber() {
		return assetsNumber;
	}

	public void setAssetsNumber(Long assetsNumber) {
		this.assetsNumber = assetsNumber;
	}

	public Date getConstructionStartTime() {
		return constructionStartTime;
	}

	public void setConstructionStartTime(Date constructionStartTime) {
		this.constructionStartTime = constructionStartTime;
	}
	public String getConstructionStartTimeTime(){
		return DateTimeUtils.formatDate(constructionStartTime);
	}
	public void setConstructionStartTimeTime(String constructionStartTimeTime) {
		this.constructionStartTime = DateTimeUtils.getDate(constructionStartTimeTime);
	}
	public Date getMakespan() {
		return makespan;
	}

	public void setMakespan(Date makespan) {
		this.makespan = makespan;
	}
	public String getMakespanTime(){
		return DateTimeUtils.formatDate(makespan);
	}
	public void setMakespanTime(String makespanTime) {
		this.makespan = DateTimeUtils.getDate(makespanTime);
	}
	
	public String getTypeWg() {
		return "0";
	}

	public String getTypeYs() {
		return "1";
	}
	private String contractingUnitId;
	private String constructionUnitId;

	public String getContractingUnitId() {
		return contractingUnitId;
	}

	public void setContractingUnitId(String contractingUnitId) {
		this.contractingUnitId = contractingUnitId;
	}

	public String getConstructionUnitId() {
		return constructionUnitId;
	}

	public void setConstructionUnitId(String constructionUnitId) {
		this.constructionUnitId = constructionUnitId;
	}
	
}
