package cn.suntak.ems.equipmentlifecycle.domain;

import cn.oz.FileEntity;

import java.util.Date;


public class EMSEntity extends FileEntity {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 565843410486461823L;
	private String manufacturerId;//制 造 商id
	private String agentId;//代 理 商id
	private String fixedAssetsTypeId;//固定资产类别ID
	private String processId;
	private Integer processState;
	private EquipmentLifeCycle equipmentLifeCycle;
	private Double netWorth;//净值
	private Double originalValue;//原值
	private Double cost;//报废成本
	private String usefulLife;//已使用年限
	private String canUseLife;//尚可使用年限
	private String ZCYLJSZB;//泛指中间那块，固定资产工作原理与更新改造内容等...
	private Date startTime;
	/**
	 * 2017年5月12日 10:42:27添加
     */
	private String fixedAssetsName;// 固定资产名称 FIXED_ASSETS_NAME
	private String specificationModel;// 规 格 型 号 SPECIFICATiON_MODEL
	private String fixedAssetsType;// 固定资产类别 FIXED_ASSETS_TYPE
	private String ascriptionMDebs;// 归口管理部门 ASCRIPTION_M_D
	private String ascriptionMDname;// 归口管理部门 ASCRIPTION_M_D
	private String ascriptionMD;// 归口管理部门 ASCRIPTION_M_D
	private String installationLocation;// 原安装地点 INSTALLATION_LOCATION
	private String useDebs;// 原 使 用 部 门 USE_D ID
	private String useDname;//名称
	private String useD;//名称
	private String serialNumber;//设备编号
	private String agent;//代理商名称
	private String manufacturer;//制造商
	private String isImported;//是否进口设备
	private String isDevelop;//是否研发设备
	private String contractNumber;//合同编号
	private String type;//类型
	public EquipmentLifeCycle getEquipmentLifeCycle() {
		return equipmentLifeCycle;
	}

	public void setEquipmentLifeCycle(EquipmentLifeCycle equipmentLifeCycle) {
		this.equipmentLifeCycle = equipmentLifeCycle;
	}
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
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getProcessId() {
		return processId;
	}
	public void setProcessState(Integer processState) {
		this.processState = processState;
	}
	public Integer getProcessState() {
		return processState;
	}

	public Double getNetWorth() {
		return netWorth;
	}

	public void setNetWorth(Double netWorth) {
		this.netWorth = netWorth;
	}

	public Double getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(Double originalValue) {
		this.originalValue = originalValue;
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

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}


	public String getZCYLJSZB() {
		return ZCYLJSZB;
	}

	public void setZCYLJSZB(String ZCYLJSZB) {
		this.ZCYLJSZB = ZCYLJSZB;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
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


	public String getInstallationLocation() {
		return installationLocation;
	}

	public void setInstallationLocation(String installationLocation) {
		this.installationLocation = installationLocation;
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

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getAscriptionMDname() {
		return ascriptionMDname;
	}

	public void setAscriptionMDname(String ascriptionMDname) {
		this.ascriptionMDname = ascriptionMDname;
	}

	public String getUseDname() {
		return useDname;
	}

	public void setUseDname(String useDname) {
		this.useDname = useDname;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getAscriptionMD() {
		return ascriptionMD;
	}

	public void setAscriptionMD(String ascriptionMD) {
		this.ascriptionMD = ascriptionMD;
	}

	public String getUseD() {
		return useD;
	}

	public void setUseD(String useD) {
		this.useD = useD;
	}

	public String getIsImported() {
		return isImported;
	}

	public void setIsImported(String isImported) {
		this.isImported = isImported;
	}

	public String getIsDevelop() {
		return isDevelop;
	}

	public void setIsDevelop(String isDevelop) {
		this.isDevelop = isDevelop;
	}


	public String getContractNumber() {
		return contractNumber;
	}

	public void setContractNumber(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
