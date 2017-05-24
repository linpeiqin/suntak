package cn.suntak.ems.common.domain;



public class VendorSiteAddrV {
	private Integer vendorId;
	private String vendorSiteId;
	private String addressShortName;

	public Integer getVendorId() {
		return vendorId;
	}

	public void setVendorId(Integer vendorId) {
		this.vendorId = vendorId;
	}

	public String getVendorSiteId() {
		return vendorSiteId;
	}

	public void setVendorSiteId(String vendorSiteId) {
		this.vendorSiteId = vendorSiteId;
	}

	public String getAddressShortName() {
		return addressShortName;
	}

	public void setAddressShortName(String addressShortName) {
		this.addressShortName = addressShortName;
	}
}
