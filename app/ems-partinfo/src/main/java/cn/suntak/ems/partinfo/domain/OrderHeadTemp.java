package cn.suntak.ems.partinfo.domain;

import cn.oz.FileAuthor;
import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

import java.util.Date;
import java.util.Set;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class OrderHeadTemp extends FileEntity {

	// fields =================================================================
	public static final  Integer SUCCESS  = 1;
	public static final  Integer FAIL  = 0;
	public static final  Integer NO  = -1;

	private Integer operation;
	private Date dateTime;
	private String orderNo;
	private String supplier;
	private String useD;
	private String operationType;
    private String remark;
    private Set<OrderLineTemp> orderLineTemps;
    private FileAuthor useP;
	private EquipmentDetails equipmentDetails;
    private Long organizationId;
    private Long repairId;
    private String maintenanceNo;
	private Integer ebsState;//EBS同步状态


	public Integer getEbsState() {
		return ebsState;
	}

	public void setEbsState(Integer ebsState) {
		this.ebsState = ebsState;
	}

	public Long getRepairId() {
		return repairId;
	}

	public void setRepairId(Long repairId) {
		this.repairId = repairId;
	}

	public String getMaintenanceNo() {
		return maintenanceNo;
	}

	public void setMaintenanceNo(String maintenanceNo) {
		this.maintenanceNo = maintenanceNo;
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
    
    public FileAuthor getUseP() {
        return useP;
    }

    public void setUseP(FileAuthor useP) {
        this.useP = useP;
    }

	public Set<OrderLineTemp> getOrderLineTemps() {
		return orderLineTemps;
	}

	public void setOrderLineTemps(Set<OrderLineTemp> orderLineTemps) {
		this.orderLineTemps = orderLineTemps;
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
