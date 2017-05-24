package cn.suntak.ems.equipmentlifecycle.domain;

import cn.oz.IdEntity;

import java.text.DecimalFormat;
import java.util.Date;

/**
 * Created by Administrator on 2017-3-8.
 */
public class EBSEntity extends IdEntity {

    private String usefulLife;//已使用年限
    private String canUseLife;//尚可使用年限
    private Double originalValue;//原值
    private Double netWorth;//净值
    private Double cost;//报废值
    /**
     * 2017年4月7日 15:17:05后续添加
     */
    private String managerD;//管理部门
    private String managerDId;//管理部门ID
    private String userD;//使用部门
    private String userDId;//使用部门ID
    private String installSite;//安装地点
//    private String fixedAssetLife;//折旧年限
    private String residualRate;//净残率
    private String deprectationMethod;//折旧方法
    private Date startTime;//开始使用日期
    /**
     * 2017年5月11日 16:47:41添加
     *
     * "","origin",
     "
     "","manufacturer","manufacturerId"}
     *
     */
    private String specificationModel;//规格型号
    private String fixedAssetsType;//固定资产类别
    private String serialNumber;//序列号
    private String manufacturerName;//制造商


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

    public String getManagerD() {
        return managerD;
    }

    public void setManagerD(String managerD) {
        this.managerD = managerD;
    }

    public String getManagerDId() {
        return managerDId;
    }

    public void setManagerDId(String managerDId) {
        this.managerDId = managerDId;
    }

    public String getUserD() {
        return userD;
    }

    public void setUserD(String userD) {
        this.userD = userD;
    }

    public String getUserDId() {
        return userDId;
    }

    public void setUserDId(String userDId) {
        this.userDId = userDId;
    }

    public String getInstallSite() {
        return installSite;
    }

    public void setInstallSite(String installSite) {
        this.installSite = installSite;
    }

    public String getResidualRate() {
        return  residualRate;
    }

    public void setResidualRate(String residualRate) {
        double rate = 100*cost/netWorth;
        this.residualRate = String.format("%f%%", rate);
    }

    public String getDeprectationMethod() {
        return deprectationMethod;
    }

    public void setDeprectationMethod(String deprectationMethod) {
        this.deprectationMethod = deprectationMethod;
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

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getManufacturerName() {
        return manufacturerName;
    }

    public void setManufacturerName(String manufacturerName) {
        this.manufacturerName = manufacturerName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
}
