package cn.suntak.ems.intofactoryandcheck.domain;


import java.util.Date;

import cn.oz.AppContext;
import cn.oz.annotation.AttachmentSupport;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.organize.OUInfo;
import cn.oz.organize.service.OrganizeService;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.oa.service.OaDepartService;
import cn.suntak.ems.oa.service.impl.OaDepartServiceImpl;
import org.springframework.beans.factory.BeanFactory;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class IntoFactoryAndCheck extends EMSEntity {
	
	// fields =================================================================
	private String type; //类型：入厂|| 验收
	private String number;//编号
	private String contractNumber;//合同编号
	private String fixedAssetsName;//固定资产名称
	private String specificationModel;//规 格 型 号
	private String fixedAssetsType;//固定资产类别
	private String fixedAssetsTypeId;//固定资产类别ID
	private String fixedAssetsNo;//固定资产编号
	private Integer assetsNumber;//数    量
	private String agent;//代 理 商
	private String agentId;//代 理 商id
	private String origin;//原 产 地
	private String manufacturer;//制 造 商
	private String manufacturerId;//制 造 商id
	private String customsNo;//报关单号
	private String isImported;//是否进口资产
	private String isDevelop;//是否研发资产
	private String customsPerson;//行政部-关务负责人
	private String RDPerson;//研发部负责人
	private String WPATI;//固定资产工作原理及主要技术指标
	private Date intoFactoryTime;//入 厂 时 间
	private Date intoFactoryTimTime;//入 厂 时 间
	private String ascriptionMD;//归口管理部门ID
	private String ascriptionMDname;//归口管理部门名称
	private String ascriptionMDebs;//归口管理部门EBSid

	private String installationLocation;//安 装 地 点
	private String useD;//使 用 部 门ID
	private String useDname;//使 用 部 门名称
	private String useDebs;//使 用 部 门ebsID
	private String currency;

	private String installationPersonnel;//安装调试人员
	private String estimateUsefulLife;//预计使用年限
	private String mainRecordIndex;//主要技术指标
	private String testRecord;//测试记录
	private String conclusion;//结论
	private String acceptancePersonT;//技术部门验收人
	private String technicalMH;//技术部门负责人
	private String putUnderD;//固定资产入厂检查、验收情况(归口部门管理填)
	private String acceptancePersonM ;//归口管理部门验收人
	private String putUnderDMH;//归口管理部门部门负责人
	private String useDOpinion;//使用部门意见
	private String useDCharge;//使用部门主管
	private String useDMH;//使用部门负责人
	private Double originalValue;//原 值
	private Double installationCost;//安装费用
	private Double tariff;//关 税
	private Double other;//其 他
	private Double totalValue;//价值合计
	private String financeFillPerson;//财务部填写人
	private String financeDMH;//财务部部门负责人
	private String GM;//总经理
	private String chairman;//董事长
	private Date createdDate;   //创建日期    CREATED_DATE
	private String createdBy;  //创建人    CREATED_BY
	private Date updatedDate;  //修改日期    UPDATED_DATE
	private String updatedBy;  //修改人      UPDATED_BY
	private String serialNumber;//设备编号
	private String hasTax;//是否含税
	public IntoFactoryAndCheck() {
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	private EquipmentLifeCycle equipmentLifeCycle;


    public String getNoImported() {
    	if(isImported!=null&&isImported.equals("1")){
    		return "0";
    	}else{
    		return "1";
    	}
	}

	public String getNoDevelop() {
		if(isDevelop!=null&&isDevelop.equals("1")){
    		return "0";
    	}else{
    		return "1";
    	}
	}

	private Long organizationId;


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

	public EquipmentLifeCycle getEquipmentLifeCycle() {
		return equipmentLifeCycle;
	}

	public void setEquipmentLifeCycle(EquipmentLifeCycle equipmentLifeCycle) {
		this.equipmentLifeCycle = equipmentLifeCycle;
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

	public String getCustomsNo() {
		return customsNo;
	}

	public void setCustomsNo(String customsNo) {
		this.customsNo = customsNo;
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

	public String getCustomsPerson() {
		return customsPerson;
	}

	public void setCustomsPerson(String customsPerson) {
		this.customsPerson = customsPerson;
	}

	public String getRDPerson() {
		return RDPerson;
	}

	public void setRDPerson(String RDPerson) {
		this.RDPerson = RDPerson;
	}

	public String getWPATI() {
		return WPATI;
	}

	public void setWPATI(String WPATI) {
		this.WPATI = WPATI;
		super.setZCYLJSZB(WPATI);
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

	public String getPutUnderD() {
		return putUnderD;
	}

	public void setPutUnderD(String putUnderD) {
		this.putUnderD = putUnderD;
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

	public Integer getAssetsNumber() {
		return assetsNumber;
	}

	public void setAssetsNumber(Integer assetsNumber) {
		this.assetsNumber = assetsNumber;
	}


	public Double getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(Double originalValue) {
		this.originalValue = originalValue;
	}

	public Double getInstallationCost() {
		return installationCost;
	}

	public void setInstallationCost(Double installationCost) {
		this.installationCost = installationCost;
	}

	public Double getTariff() {
		return tariff;
	}

	public void setTariff(Double tariff) {
		this.tariff = tariff;
	}

	public Double getOther() {
		return other;
	}

	public void setOther(Double other) {
		this.other = other;
	}

	public Double getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(Double totalValue) {
		this.totalValue = totalValue;
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
	public String getFixedAssetsTypeId() {
		return fixedAssetsTypeId;
	}
	public void setFixedAssetsTypeId(String fixedAssetsTypeId) {
		this.fixedAssetsTypeId = fixedAssetsTypeId;
	}
	public String getAgentId() {
		return agentId;
	}
	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}
	public String getManufacturerId() {
		return manufacturerId;
	}
	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}
	public String getTypeRc() {
		return "1";
	}
	public String getTypeYs() {
		return "0";
	}
	public String getUseDname() {
		return useDname;
	}
	public void setUseDname(String useDname) {
		this.useDname = useDname;
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
	private String ascriptionMDOa;//归口管理部门ID
	private String useDOa;//使 用 部 门ID
	private OaDepartService oaDepartService;//OA部门选择
	public String getAscriptionMDOa() {
        if(ascriptionMD!=null){
			return this.getOaDepartService().getOaDepartId(ascriptionMD);
        }
		return null;
	}
    private OrganizeService organizeService;
	public String getUseDOa() {
        if(useD==null){
            return null;
        }
		return this.getOaDepartService().getOaDepartId(useD);
	}
    private OaDepartService getOaDepartService(){
        if(this.oaDepartService==null){
            this.oaDepartService = AppContext.getServiceFactory().getService("oaDepartService");
        }
        return this.oaDepartService;
    }
    public String getAscriptionMDname() {
        if(ascriptionMD==null)
            return null;
        this.organizeService = AppContext.getServiceFactory().getService("organizeService");
        OUInfo oUInfo = this.organizeService.loadOUInfo(ascriptionMD);
        return oUInfo.getName();
    }
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getHasTax() {
		return hasTax;
	}
	public void setHasTax(Double tax) {
		if(this.currency!=null&&this.currency.equals("CNY")){
			if(tax!=null&&tax>0){
				this.hasTax = "含税";
			}else{
				this.hasTax = "不含税";
			}
		}
	}

	public Date getIntoFactoryTime() {
		return intoFactoryTime;
	}

	public void setIntoFactoryTime(Date intoFactoryTime) {
		this.intoFactoryTime = intoFactoryTime;
	}

	public String getIntoFactoryTimeTime(){
		if(intoFactoryTime==null){
			return null;
		}
		return DateTimeUtils.formatDate(intoFactoryTime);
	}
	public void setIntoFactoryTimeTime(String intoFactoryTimeTime) {
		this.intoFactoryTime = DateTimeUtils.getDate(intoFactoryTimeTime);
	}
}

