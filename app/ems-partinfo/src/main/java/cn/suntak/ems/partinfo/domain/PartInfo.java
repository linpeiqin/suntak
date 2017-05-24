package cn.suntak.ems.partinfo.domain;

import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;

/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class PartInfo extends FileEntity {

    private Long itemId;       //配件ID PART_ID ebs物料ID
    private String partNo;       //配件编号 PART_NO
    private String partName;     //配件名称 PART_NAME
    private String UOMCode;   //单位   COUNT_UNITS
    private String partType;   // 配件类型   PART_TYPE
    private Double price;         //单价      PRICE
 /*   private Integer currentInventory;  //现有库存  CURRENT_INVENTORY
    private Integer lessQty;//可用量
    private Integer currentInventory2;//不分组织总库存现有量
    private Integer lessQty2;//总可用量*/
    private Integer onhandQty;//  本地现有量
    private Integer onroadQty;// 本地在途量
    private Integer totalOnhandQty;// 集团总现有量
    private Long organizationId;
    private String organizationName;
    private String category1;
    private String category2;


    public Integer getOnhandQty() {
        return onhandQty;
    }

    public void setOnhandQty(Integer onhandQty) {
        this.onhandQty = onhandQty;
    }

    public Integer getOnroadQty() {
        return onroadQty;
    }

    public void setOnroadQty(Integer onroadQty) {
        this.onroadQty = onroadQty;
    }

    public Integer getTotalOnhandQty() {
        return totalOnhandQty;
    }

    public void setTotalOnhandQty(Integer totalOnhandQty) {
        this.totalOnhandQty = totalOnhandQty;
    }

    public String getCategory2() {
        return category2;
    }

    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    public String getCategory1() {
        return category1;
    }

    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
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

    public String getUOMCode() {
        return UOMCode;
    }

    public void setUOMCode(String UOMCode) {
        this.UOMCode = UOMCode;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public String getPartType() {
        return partType;
    }

    public void setPartType(String partType) {
        this.partType = partType;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }




}
