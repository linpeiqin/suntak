package cn.suntak.ems.equipmentdetails.domain;


import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.oz.component.attachment.domain.Attachment;
import cn.oz.component.attachment.service.AttachmentService;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.common.domain.DepartmentV;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.renewal.domain.RenewalContract;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;

import java.lang.reflect.Field;
import java.util.*;

/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class EquipmentDetails extends FileEntity {
    private String equipmentNo; //EQUIPMENT_NO 设备编号

    private String equipmentName; //EQUIPMENT_NAME 设备名称
    private String specificationModel; //SPECIFICATION_MODEL 规格型号
    private String equipmentType; //设备类别  1
    private Date startTime; //START_TIME 购置时间   1
    private String financeDMH; //FINANCE_D_M_H 资产负责人
    private String manufacturer; //MANUFACTURER 生产厂商
    private String equipmentAlias;//设备别名
    private Double netWorth;//资产净值
    private String assetId;//资产编号
    /**
     * 执行简报
     */
    private String equipmentTypeId; //设备类别ID
    private String manufacturerId; //生产厂商ID
    private String financeDMHId; //资产负责人ID
    private String qty;//数量
    private String isImportEquipment;//是否进口设备
    private String factoryName;//工厂
    private Long factoryNo;//工厂编号
    private String suppliers;//SUPPLIERS 供应商
    private String suppliersId;//供应商 ID
    private String projectName;//项目名称
    private String projectNo;//项目编号
    private String contractName;//合同名称
    private String assetName;//固定资产名称
    private String contractNo;//合同编号
    /**
     *
     */
    private String acquisitionMode; //ACQUISITION_MODE 购置方式  1
    private String deprectationMethod; //DEPRECTATION_METHOD 折旧方式
    private Double originalValue; //ORIGINAL_VALUE 资产原值  1
    private Double residualRate; //RESIDUAL_RATE 净残率
    private Integer fixedAssetLife; //FIXED_ASSET_LIFE 折旧年限
    private Date lastRepair; //LAST_REPAIR 上次维修
    private Integer isUse; //IS_USE 使用状况
    private String useD; //USE_D 使用部门
    private String operator; //OPERATOR 操作人员
    private String installationLocation; //INSTALLATION_LOCATION 安装地点
    private String remark; //REMARK 备注
    private Set<EquipmentLifeCycle> equipmentLifeCycles;
    private Set<TechnicalParams> technicalParams;
    private Long organizationId;//组织ID
    private Integer type;//设备状态
    private Integer scrapState;//是否作废
    private String managerD;//管理部门
    private Long parentId;//主机关联ID   
    private String currency;
    private Integer contractType;//合同类别0：新设备合同1：旧设备合同2：工程合同
    private Set<RenewalContract> renewalContracts; //设备更新改造合同
    private Double tax;//税率
    private String procedure;//工序
    private String serialNo;//机身编号
    private EBSEntity ebsEntity;
    private Boolean instructions;

    private String brand;//品牌

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public Boolean getInstructions() {
        AttachmentService attachmentService = AppContext.getServiceFactory().getService("attachmentService");
        if (!this.isNew()) {
            List<Attachment> attachments = attachmentService.findByParent("cn.suntak.ems.equipmentdetails.domain.EquipmentDetails", String.valueOf(super.getId()), "equipmentInstructions");
            if (attachments == null || attachments.size() == 0) {
                return false;
            }
        }
        return true;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
    }

    public String getParentName() {
        if (this.parentId == null) {
            return "";
        }
        EquipmentDetailsService equipmentDetailsService = AppContext.getServiceFactory().getService("equipmentDetailsService");
        EquipmentDetails equipmentDetails = equipmentDetailsService.load(this.parentId);
        if (equipmentDetails == null) {
            return "";
        }
        return equipmentDetails.getEquipmentName();
    }

    public String getTypeName() {
        if (this.getType() == null) {
            return null;
        } else {
            return DataDictHelper.getDataDict("SBZT", String.valueOf(this.getType())).getName();
        }
    }

    public String getUseDName() {
        DepartmentVService departmentVService = AppContext.getServiceFactory().getService("departmentVService");
        DepartmentV d = departmentVService.getDepartmentByUseD(this.useD);
        if (d == null)
            return "";
        return d.getDescription();
    }

    public Set<TechnicalParams> getTechnicalParams() {
        return technicalParams;
    }

    public void setTechnicalParams(Set<TechnicalParams> technicalParams) {
        this.technicalParams = technicalParams;
    }

    public Set<EquipmentLifeCycle> getEquipmentLifeCycles() {
        if (equipmentLifeCycles == null) {
            equipmentLifeCycles = new HashSet<EquipmentLifeCycle>();
        }
        return equipmentLifeCycles;
    }

    public void setEquipmentLifeCycles(Set<EquipmentLifeCycle> equipmentLifeCycles) {
        this.equipmentLifeCycles = equipmentLifeCycles;
    }

    public Boolean containLifeCycle(String... lifeCycles) {
        if(equipmentLifeCycles!=null){
            for(EquipmentLifeCycle lifeCycle :equipmentLifeCycles){
                for(String type : lifeCycles){
                    if(lifeCycle.getType().equals(type)){
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentNo() {
        return equipmentNo;
    }

    public void setEquipmentNo(String equipmentNo) {
        this.equipmentNo = equipmentNo;
    }

    public String getSpecificationModel() {
        return specificationModel;
    }

    public void setSpecificationModel(String specificationModel) {
        this.specificationModel = specificationModel;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getSuppliers() {
        return suppliers;
    }

    public void setSuppliers(String suppliers) {
        this.suppliers = suppliers;
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

    public String getAcquisitionMode() {
        return acquisitionMode;
    }

    public void setAcquisitionMode(String acquisitionMode) {
        this.acquisitionMode = acquisitionMode;
    }

    public String getFinanceDMH() {
        return financeDMH;
    }

    public void setFinanceDMH(String financeDMH) {
        this.financeDMH = financeDMH;
    }

    public String getDeprectationMethod() {
        return deprectationMethod;
    }

    public void setDeprectationMethod(String deprectationMethod) {
        this.deprectationMethod = deprectationMethod;
    }

    public Double getOriginalValue() {
        return originalValue;
    }

    public void setOriginalValue(Double originalValue) {
        this.originalValue = originalValue;
    }

    public Double getResidualRate() {
        return residualRate;
    }

    public void setResidualRate(Double residualRate) {
        this.residualRate = residualRate;
    }

    public Integer getFixedAssetLife() {
        return fixedAssetLife;
    }

    public void setFixedAssetLife(Integer fixedAssetLife) {
        this.fixedAssetLife = fixedAssetLife;
    }

    public String getLastRepairStr() {
        return DateTimeUtils.formatDateTime(this.lastRepair);
    }

    public void setLastRepairStr(String lastRepair) {
        this.lastRepair = DateTimeUtils.getDate(lastRepair);
    }

    public Date getLastRepair() {
        return lastRepair;
    }

    public void setLastRepair(Date lastRepair) {
        this.lastRepair = lastRepair;
    }

    public Integer getIsUse() {
        return isUse;
    }

    public void setIsUse(Integer isUse) {
        this.isUse = isUse;
    }

    public String getUseD() {
        return useD;
    }

    public void setUseD(String useD) {
        this.useD = useD;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getInstallationLocation() {
        return installationLocation;
    }

    public void setInstallationLocation(String installationLocation) {
        this.installationLocation = installationLocation;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getEquipmentTypeId() {
        return equipmentTypeId;
    }

    public void setEquipmentTypeId(String equipmentTypeId) {
        this.equipmentTypeId = equipmentTypeId;
    }

    public String getManufacturerId() {
        return manufacturerId;
    }

    public void setManufacturerId(String manufacturerId) {
        this.manufacturerId = manufacturerId;
    }

    public String getFinanceDMHId() {
        return financeDMHId;
    }

    public void setFinanceDMHId(String financeDMHId) {
        this.financeDMHId = financeDMHId;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getIsImportEquipment() {
        return isImportEquipment;
    }

    public void setIsImportEquipment(String isImportEquipment) {
        this.isImportEquipment = isImportEquipment;
    }

    public String getFactoryName() {
        return factoryName;
    }

    public void setFactoryName(String factoryName) {
        this.factoryName = factoryName;
    }

    public Long getFactoryNo() {
        return factoryNo;
    }

    public void setFactoryNo(Long factoryNo) {
        this.factoryNo = factoryNo;
        this.organizationId = factoryNo;
    }

    public String getSuppliersId() {
        return suppliersId;
    }

    public void setSuppliersId(String suppliersId) {
        this.suppliersId = suppliersId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectNo() {
        return projectNo;
    }

    public void setProjectNo(String projectNo) {
        this.projectNo = projectNo;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public String getContractNo() {
        return contractNo;
    }

    public void setContractNo(String contractNo) {
        this.contractNo = contractNo;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getType() {
        return type;
    }


    public void setScrapState(Integer scrapState) {
        this.scrapState = scrapState;
    }

    public Integer getScrapState() {
        return scrapState;
    }

    public void setManagerD(String managerD) {
        this.managerD = managerD;
    }

    public String getManagerD() {
        return managerD;
    }


    public String getEquipmentAlias() {
        return equipmentAlias;
    }

    public void setEquipmentAlias(String equipmentAlias) {
        this.equipmentAlias = equipmentAlias;
    }

    public Double getNetWorth() {
        return netWorth;
    }

    public void setNetWorth(Double netWorth) {
        this.netWorth = netWorth;
    }

    public String getAssetId() {
        return assetId;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }


    public Set<RenewalContract> getRenewalContracts() {

        if (this.renewalContracts == null) {
            this.renewalContracts = new HashSet<RenewalContract>();
        }
        return this.renewalContracts;
    }

    public void setRenewalContracts(Set<RenewalContract> renewalContracts) {
        this.renewalContracts = renewalContracts;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public RenewalContract getToPerformContract() {
        //从合同列表中取数据，如果在生命周期中没有找到合同就选定当前合同
        if (this.renewalContracts != null) {
            Set<EquipmentLifeCycle> elcs = this.getEquipmentLifeCycles();
            List<String> remove = new ArrayList<String>();
            for (EquipmentLifeCycle elc : elcs) {
                if (elc.getType().equals("renewal")) {
                    remove.add(elc.getRenewal().getContractNumber());
                }else if(elc.getType().equals("renewalAndCheck")) {
                    remove.add(elc.getRenewalAndCheck().getContractNumber());
                }
            }
            //remove 生命周期存在的合同
            for (RenewalContract entity : renewalContracts) {
                boolean flag = true;
                for (String str : remove) {
                    if (entity.getContractNo().equals(str)) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    return entity;
                }
            }
        }
        return null;
    }

    public Integer getContractType() {
        return contractType;
    }

    public void setContractType(Integer contractType) {
        this.contractType = contractType;
    }

    public Double getTax() {
        return tax;
    }

    public void setTax(Double tax) {
        this.tax = tax;
    }

    public String getProcedure() {
        return procedure;
    }

    public void setProcedure(String procedure) {
        this.procedure = procedure;
    }

    public EBSEntity getEbsEntity() {
        return ebsEntity;
    }

    public void setEbsEntity(EBSEntity ebsEntity) {
        this.ebsEntity = ebsEntity;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public EMSEntity getLifeCycle(String... lifeCycles) {
        if(equipmentLifeCycles!=null){
            for(EquipmentLifeCycle lifeCycle :equipmentLifeCycles){
                for(String lifeCycleName:lifeCycles){
                    if(lifeCycle.getType().equals(lifeCycleName)){
                        try {
                            Field field = EquipmentLifeCycle.class.getDeclaredField(lifeCycleName);
                            field.setAccessible(true);
                            return (EMSEntity) field.get(lifeCycle);
                        } catch (NoSuchFieldException e) {
                            e.printStackTrace();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return null;
    }


    public Renewal getExecutingContract() {
        List<EquipmentLifeCycle> lifeCycles = new ArrayList<EquipmentLifeCycle>();
        lifeCycles.addAll(equipmentLifeCycles);
        Collections.sort(lifeCycles, new Comparator<EquipmentLifeCycle>() {
            @Override
            public int compare(EquipmentLifeCycle o1, EquipmentLifeCycle o2) {
                return o1.getCreatedDate().after(o2.getCreatedDate())?1:-1;
            }
        });
        Renewal renewal = null;
        for(EquipmentLifeCycle lifeCycle:lifeCycles){
            if(lifeCycle.getType().equals("renewal")){
                renewal= lifeCycle.getRenewal();
                break;
            }
        }
        RenewalCheck renewalCheck = null;
        for(EquipmentLifeCycle lifeCycle:lifeCycles){
            if(lifeCycle.getType().equals("renewalCheck")){
                renewalCheck= lifeCycle.getRenewalCheck();
                break;
            }
        }
        if(renewal!=null){
            if(renewalCheck!=null){
                if(renewal.getContractNumber().equals(renewalCheck.getContractNumber())){
                    return null;
                }
            }
            return renewal;
        }
        return null;
    }
}
