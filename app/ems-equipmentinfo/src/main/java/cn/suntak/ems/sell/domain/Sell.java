package cn.suntak.ems.sell.domain;

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
public class Sell extends EMSEntity {

	// fields =================================================================
	private String type; // 类型：出售|| 报废 TYPE
	private String number;// 编号 EMS_NUMBER
	private String contractNumber;// 合同编号 CONTRACT_NUMBER
	private String fixedAssetsName;// 固定资产名称 FIXED_ASSETS_NAME
	private String specificationModel;// 固定资产编号 SPECIFICATION_MODEL
	private String fixedAssetsType;// 固定资产类别 FIXED_ASSETS_TYPE
	private String fixedAssetsNo;// 固定资产编号 FIXED_ASSETS_NO
	private Integer assetsNumber;// 数 量 ASSETS_NUMBER
	private String agent;// 代 理 商 AGENT
	private String origin;// 原 产 地 ORIGIN
	private String manufacturer;// 制 造 商 MANUFACTURER
	private String isImported;// 是否进口资产 IS_IMPORTED
	private String customsNo;// 报关单号 CUSTOMS_NO
	private String customsPerson;// 行政部-关务负责人 CUSTOMS_PERSON
	private String isDevelop;// 是否研发资产 IS_DEVELOP
	private String RDPerson;// 研发部负责人 R_D_PERSON
	private String faTechnicalIndex;// 固定资产工作原理及主要技术指标 FA_TECHNICAL_INDEX
	private Date startTime;// 开始使用时间 START_TIME
	private Date startTimeStr;// 开始使用时间 START_TIME
	private String ascriptionMD;// 归口管理部门 ASCRIPTION_M_D
	private String installationLocation;// 安 装 地 点 INSTALLATION_LOCATION
	private String useD;// 使 用 部 门 USE_D
	private String usefulLife;// 已使用期限 USEFUL_LIFE
	private String canUseLife;// 尚可使用期限 CAN_USE_LIFE
	private String faDescription;// 固定资产出售/报废情况说明 FA_DESCRIPTION
	private String putUnderCharge;// 归口部门主管 PUT_UNDER_CHARGE
	private String putUnderDMH;// 归口部门负责人 PUT_UNDER_D_M_H
	private String sectorOpinion;// 使用部门意见 SECTOR_OPINION
	private String useDCharge;// 使用部门主管 USE_D_CHARGE
	private String useDMH;// 使用部门负责人 USE_D_M_H
	private Double originalValue;// 原 值 ORIGINAL_VALUE
	private Double netWorth;// 净 值 NEW_WORTH
	private String financeFillPerson;// 财务部填写人 FINANCE_FILL_PERSON
	private String financeDMH;// 财务部负责人 FINANCE_D_M_H
	private String faApprovalOpinion;// 固定资产出售/报废批准意见 FA_APPROVAL_OPINION
	private String GM;// 总经理 G_M
	private String chairman;// 董事长 CHAIRMAN
	private String faPlaceOfStorage;// 固定资产报废后存放地点 FA_PLACE_OF_STORAGE
	private Date createdDate;   //创建日期    CREATED_DATE
	private String createdBy;  //创建人    CREATED_BY
	private Date updatedDate;  //修改日期    UPDATED_DATE
	private String updatedBy;  //修改人      UPDATED_BY
	private EquipmentLifeCycle equipmentLifeCycle;
	
	@SuppressWarnings("unused")
	private String typeName;
    private Long organizationId;
	private String serialNumber;//设备编号

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}
	
	public String getTypeName() {
		if(this.getType()==null){
			return "";
		}
		return DataDictHelper.getDataDict("LIFE-CYCLE", this.getType()).getName();
	}
	public String getStartTimeTime() {
		if(this.startTime==null){
			return null;
		}
		return DateTimeUtils.formatDateTime(this.startTime);
	}

	public void setStartTimeTime(String startTime) {
		this.startTime = DateTimeUtils.getDate(startTime);
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getFixedAssetsName() {
		return fixedAssetsName;
	}
	public void setFixedAssetsName(String fixedAssetsName) {
		this.fixedAssetsName = fixedAssetsName;
	}
	public String getSpecificationModel() {
		return specificationModel;
	}
	public void setSpecificationModel(String specificationModel) {
		this.specificationModel = specificationModel;
	}
	public String getFixedAssetsType() {
		return fixedAssetsType;
	}
	public void setFixedAssetsType(String fixedAssetsType) {
		this.fixedAssetsType = fixedAssetsType;
	}
	public String getFixedAssetsNo() {
		return fixedAssetsNo;
	}
	public void setFixedAssetsNo(String fixedAssetsNo) {
		this.fixedAssetsNo = fixedAssetsNo;
	}
	public Integer getAssetsNumber() {
		return assetsNumber;
	}
	public void setAssetsNumber(Integer assetsNumber) {
		this.assetsNumber = assetsNumber;
	}
	public String getAgent() {
		return agent;
	}
	public void setAgent(String agent) {
		this.agent = agent;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getIsImported() {
		return isImported;
	}
	public void setIsImported(String isImported) {
		this.isImported = isImported;
	}
	public String getCustomsNo() {
		return customsNo;
	}
	public void setCustomsNo(String customsNo) {
		this.customsNo = customsNo;
	}
	public String getCustomsPerson() {
		return customsPerson;
	}
	public void setCustomsPerson(String customsPerson) {
		this.customsPerson = customsPerson;
	}
	public String getIsDevelop() {
		return isDevelop;
	}
	public void setIsDevelop(String isDevelop) {
		this.isDevelop = isDevelop;
	}
	public String getRDPerson() {
		return RDPerson;
	}
	public void setRDPerson(String rDPerson) {
		RDPerson = rDPerson;
	}
	public String getFaTechnicalIndex() {
		return faTechnicalIndex;
	}
	public void setFaTechnicalIndex(String faTechnicalIndex) {
		this.faTechnicalIndex = faTechnicalIndex;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getStartTimeStr() {
		if(this.startTime==null)
			return null;
		return DateTimeUtils.formatDateTime(this.startTime);
	}

	public void setStartTimeStr(String startTime) {
		this.startTime = DateTimeUtils.getDate(startTime);
	}
	public String getAscriptionMD() {
		return ascriptionMD;
	}
	public void setAscriptionMD(String ascriptionMD) {
		this.ascriptionMD = ascriptionMD;
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
	public String getUsefulLife() {
		return usefulLife;
	}
	public void setUsefulLife(String usefulLife) {
		this.usefulLife = usefulLife;
	}
	public String getCanUseLife() {
		return canUseLife;
	}
	public void setCanUseLife(String canUseLife) {
		this.canUseLife = canUseLife;
	}
	public String getFaDescription() {
		return faDescription;
	}
	public void setFaDescription(String faDescription) {
		this.faDescription = faDescription;
	}
	public String getPutUnderCharge() {
		return putUnderCharge;
	}
	public void setPutUnderCharge(String putUnderCharge) {
		this.putUnderCharge = putUnderCharge;
	}
	public String getPutUnderDMH() {
		return putUnderDMH;
	}
	public void setPutUnderDMH(String putUnderDMH) {
		this.putUnderDMH = putUnderDMH;
	}
	public String getSectorOpinion() {
		return sectorOpinion;
	}
	public void setSectorOpinion(String sectorOpinion) {
		this.sectorOpinion = sectorOpinion;
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
	public Double getOriginalValue() {
		return originalValue;
	}
	public void setOriginalValue(Double originalValue) {
		this.originalValue = originalValue;
	}
	public Double getNetWorth() {
		return netWorth;
	}
	public void setNetWorth(Double netWorth) {
		this.netWorth = netWorth;
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
	public String getFaApprovalOpinion() {
		return faApprovalOpinion;
	}
	public void setFaApprovalOpinion(String faApprovalOpinion) {
		this.faApprovalOpinion = faApprovalOpinion;
	}
	public String getGM() {
		return GM;
	}
	public void setGM(String gM) {
		GM = gM;
	}
	public String getChairman() {
		return chairman;
	}
	public void setChairman(String chairman) {
		this.chairman = chairman;
	}
	public String getFaPlaceOfStorage() {
		return faPlaceOfStorage;
	}
	public void setFaPlaceOfStorage(String faPlaceOfStorage) {
		this.faPlaceOfStorage = faPlaceOfStorage;
	}
	public void setEquipmentLifeCycle(EquipmentLifeCycle equipmentLifeCycle) {
		this.equipmentLifeCycle = equipmentLifeCycle;
	}
	public EquipmentLifeCycle getEquipmentLifeCycle() {
		return equipmentLifeCycle;
	}
	public String getTypeBf() {
		return "0";
	}

	public String getTypeCs() {
		return "1";
	}
	private String manufacturerId;//制 造 商id
	private String agentId;//代 理 商id
	private String fixedAssetsTypeId;//固定资产类别ID
	public String getManufacturerId() {
		return manufacturerId;
	}
	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}
	public String getAgentId() {
		return agentId;
	}
	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}
	public String getFixedAssetsTypeId() {
		return fixedAssetsTypeId;
	}
	public void setFixedAssetsTypeId(String fixedAssetsTypeId) {
		this.fixedAssetsTypeId = fixedAssetsTypeId;
	}
	private String ascriptionMDname;//归口管理部门名称
	private String ascriptionMDebs;//归口管理部门EBSid
	private String useDname;//使 用 部 门名称
	private String useDebs;//使 用 部 门ebsID
	public String getUseDname() {
		return useDname;
	}

	public void setUseDname(String useDname) {
		this.useDname = useDname;
	}

	public String getAscriptionMDname() {
		return ascriptionMDname;
	}

	public void setAscriptionMDname(String ascriptionMDname) {
		this.ascriptionMDname = ascriptionMDname;
	}

	public String getAscriptionMDebs() {
		return ascriptionMDebs;
	}

	public void setAscriptionMDebs(String ascriptionMDebs) {
		this.ascriptionMDebs = ascriptionMDebs;
	}

	public String getUseDebs() {
		return useDebs;
	}

	public void setUseDebs(String useDebs) {
		this.useDebs = useDebs;
	}
}
