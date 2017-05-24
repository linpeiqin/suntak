package cn.suntak.ems.renewal.domain;

import cn.oz.IdEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

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
public class RenewalContract extends IdEntity {

	// fields =================================================================
	private String contractNo;
	private Double worth;
	private String currency;
	private String supplier;
	private String supplierId;
	private Integer state;
	private Set<EquipmentDetails> equipmentDetails;

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public Double getWorth() {
		return worth;
	}

	public void setWorth(Double worth) {
		this.worth = worth;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}

	public Set<EquipmentDetails> getEquipmentDetails() {
		return equipmentDetails;
	}

	public void setEquipmentDetails(Set<EquipmentDetails> equipmentDetails) {
		this.equipmentDetails = equipmentDetails;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
}
