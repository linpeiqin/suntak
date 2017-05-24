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
public class OrderLine extends FileEntity {

	private Long partId;
	private String partNo;
	private String partName;
	private Integer qty;
	private Double price;
	private Double amount;
	private String UOMCode;
	private Integer startInventory;
	private Integer endInventory;
	private OrderHead orderHead;
    private Long organizationId;
	private String currencyCode;
	private Integer rate;

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public String getCurrencyCode() {
		return currencyCode;
	}

	public void setCurrencyCode(String currencyCode) {
		this.currencyCode = currencyCode;
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

	public OrderHead getOrderHead() {
		return orderHead;
	}
	public void setOrderHead(OrderHead orderHead) {
		this.orderHead = orderHead;
	}
	public String getPartNo() {
		return partNo;
	}
	public void setPartNo(String partNo) {
		this.partNo = partNo;
	}
	public String getPartName() {
		return partName;
	}
	public void setPartName(String partName) {
		this.partName = partName;
	}
	public Long getPartId() {
		return partId;
	}

	public void setPartId(Long partId) {
		this.partId = partId;
	}

	public String getQtyIn() {
		if (orderHead.getOperation()==0){
			return String.valueOf(amount);
		}
		return "";
	}

	public String getQtyOut() {
		if (orderHead.getOperation()==1){
			return String.valueOf(qty);
		}
		return "";
	}

	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getStartInventory() {
		return startInventory;
	}
	public void setStartInventory(Integer startInventory) {
		this.startInventory = startInventory;
	}
	public Integer getEndInventory() {
		return endInventory;
	}
	public void setEndInventory(Integer endInventory) {
		this.endInventory = endInventory;
	}

}
