package cn.suntak.ems.partinfo.domain;

import cn.oz.FileEntity;

/**
 * Created by linking on 2017/3/13.
 */
public class GroupInventory extends FileEntity {

    private Long organizationId;
    private String organizationName;
    private String partNo;
    private Integer onhandQty;
    private Integer onroadQty;


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

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getPartNo() {
        return partNo;
    }

    public void setPartNo(String partNo) {
        this.partNo = partNo;
    }

}
