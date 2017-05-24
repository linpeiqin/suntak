package cn.suntak.ems.partinfo.domain;

import java.util.Date;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.suntak.ems.common.domain.LineTypeV;
import cn.suntak.ems.common.service.LineTypeVService;

/**
 *
 *
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class PRLine extends FileEntity {
	private String lineTypeId;//类型   LINE_TYPE_ID
	private String lineTypeName;//类型名称
	private Long itemId;//物料id   ITEM_ID
	private String itemNo;//物料编号
	private String itemName;//物料名称  
	private String itemUnit;//单位   ITEM_UNIT
	private Integer qty;//数量   QTY
	private Double price;//单价  PRICE
	private Double amount;//总价  AMOUNT
	private Date   needDate;//实际到货日期   NEED_DATE
	private String needReason;//用途  NEED_REASON
	private Date   promisedDate;//预计到货日期   PROMISED_DATE
	private String isUrgent;//是否紧急
	private String urgentText;
	private PRHead pRHead;

	public String getUrgentText() {
		if(null==this.isUrgent)
		{
			return null;
		}
		else
		{
			if(this.isUrgent.equals("N"))return "否";
			else if(this.isUrgent.equals("Y"))return "是";
			else  return null;
		}
	}

	public String getIsUrgent() {
		return isUrgent;
	}
	public void setIsUrgent(String isUrgent) {
		this.isUrgent = isUrgent;
	}
	public PRHead getpRHead() {
		return pRHead;
	}
	public void setpRHead(PRHead pRHead) {
		this.pRHead = pRHead;
	}
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getLineTypeId() {
		return lineTypeId;
	}
	public void setLineTypeId(String lineTypeId) {
		this.lineTypeId = lineTypeId;
	}

	public String getLineTypeName() {
		return lineTypeName;
	}

	public String getNeedReason() {
		return needReason;
	}
	public void setNeedReason(String needReason) {
		this.needReason = needReason;
	}
	public void setLineTypeName(String lineTypeName) {
		this.lineTypeName = lineTypeName;
	}
	public Long getItemId() {
		return itemId;
	}
	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {return itemName;}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemUnit() {
		return itemUnit;
	}
	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Date getNeedDate() {
		return needDate;
	}
	public void setNeedDate(Date needDate) {
		this.needDate = needDate;
	}
	public Date getPromisedDate() {
		return promisedDate;
	}
	public void setPromisedDate(Date promisedDate) {
		this.promisedDate = promisedDate;
	}
}
