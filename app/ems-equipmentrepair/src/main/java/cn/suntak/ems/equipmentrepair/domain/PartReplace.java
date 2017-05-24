package cn.suntak.ems.equipmentrepair.domain;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.suntak.ems.common.domain.LineTypeV;
import cn.suntak.ems.common.service.LineTypeVService;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@SuppressWarnings("serial")
public class PartReplace extends FileEntity {


	// fields =================================================================
	private String partName; //PART_Name
	private String partNo; //partId;
	private Integer qty;//qty   数量
	private RepairRecord  repairRecord;
	private String section;             //分段
	private Long equipmentId;
    private Long organizationId;
	private Long partId;
	private Double price;
	private Double totalPrice;
	private String lineTypeId;
	private Long itemId;
	private String lineTypeName;
	


	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getLineTypeId() {
		return lineTypeId;
	}

	public void setLineTypeId(String lineTypeId) {
		this.lineTypeId = lineTypeId;
	}

	public String getLineTypeName() {
		LineTypeVService lineTypeVService = AppContext.getServiceFactory().getService("lineTypeVService");
		if (this.lineTypeId==null)
			return "";
		LineTypeV lineType = lineTypeVService.getLineTypeVBy(this.lineTypeId);
		if (lineType==null)
			return "";
		return lineType.getLineTypeName();
	}

	public void setLineTypeName(String lineTypeName) {
		this.lineTypeName = lineTypeName;
	}

	public Long getPartId() {
		return partId;
	}

	public void setPartId(Long partId) {
		this.partId = partId;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public RepairRecord getRepairRecord() {
		return repairRecord;
	}
	public void setRepairRecord(RepairRecord repairRecord) {
		this.repairRecord = repairRecord;
	}


	public String getPartName() {
		return partName;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public void setPartName(String partName) {
		this.partName = partName;
	}

	public String getPartNo() {
		return partNo;
	}

	public void setPartNo(String partNo) {
		this.partNo = partNo;
	}
	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}


	public Long getItemId() {
		return itemId;
	}

	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}
}