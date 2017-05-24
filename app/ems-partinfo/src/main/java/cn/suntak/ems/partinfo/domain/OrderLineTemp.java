package cn.suntak.ems.partinfo.domain;

import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class OrderLineTemp extends FileEntity {

	private Long partId;
	private String partName;
	private String partNo;
	private String type;
	private Integer qty;
	private Double price;
	private Double amount;
	private String UOMCode;
	private String lineTypeId;
	private String lineTypeName;
	private Long itemId;
	private OrderHeadTemp orderHeadTemp;
    private Long organizationId;

    
	public String getLineTypeName() {
		return lineTypeName;
	}

	public void setLineTypeName(String lineTypeName) {
		this.lineTypeName = lineTypeName;
	}

	public String getLineTypeId() {
		return lineTypeId;
	}

	public void setLineTypeId(String lineTypeId) {
		this.lineTypeId = lineTypeId;
	}

	public Long getItemId() {
		return itemId;
	}

	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}

	public String getPartName() {
		return partName;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public String getUOMCode() {
		return UOMCode;
	}

	public void setUOMCode(String UOMCode) {
		this.UOMCode = UOMCode;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}


	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public OrderHeadTemp getOrderHeadTemp() {
		return orderHeadTemp;
	}

	public void setOrderHeadTemp(OrderHeadTemp orderHeadTemp) {
		this.orderHeadTemp = orderHeadTemp;
	}

	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}

	public Long getPartId() {
		return partId;
	}

	public void setPartId(Long partId) {
		this.partId = partId;
	}
}
