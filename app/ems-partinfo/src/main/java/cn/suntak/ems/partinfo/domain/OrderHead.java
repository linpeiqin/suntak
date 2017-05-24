package cn.suntak.ems.partinfo.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class OrderHead extends FileEntity {

	// fields =================================================================

	private Integer operation;
	private Date dateTime;
	private String orderNo;
	private String supplier;
	private String useD;
	private Long equipmentId;
	private String operationType;
    private String remark;
    private String useP;
    private Long organizationId;

	public EquipmentDetails getEquipmentDetails() {
		EquipmentDetailsService equipmentDetailsService = AppContext.getServiceFactory().getService("equipmentDetailsService");
		if (this.equipmentId == null || this.equipmentId==0)
		{
			return null;
		}
		EquipmentDetails equipmentDetails = equipmentDetailsService.load(this.equipmentId);
		if (equipmentDetails==null)
		{
			return null;
		}
		return equipmentDetails;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}


    public String getOperationTypeName() {
    	if (this.getOperationType()==null) return "";
		return this.getOperationType();
	}


	public String getDateTimeStr() {
		return  DateTimeUtils.formatDate(dateTime);

	}

	public void setDateTimeStr(String dateTime) {
		this.dateTime = DateTimeUtils.getDate(dateTime);

	}
    
    public String getUseP() {
        return useP;
    }

    public void setUseP(String useP) {
        this.useP = useP;
    }

    public Integer getOperation() {
		return operation;
	}
	public void setOperation(Integer operation) {
		this.operation = operation;
	}
	public Date getDateTime() {
		return dateTime;
	}
	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getUseD() {
		return useD;
	}
	public void setUseD(String useD) {
		this.useD = useD;
	}
	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getOperationType() {
		return operationType;
	}
	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
    

	
}
