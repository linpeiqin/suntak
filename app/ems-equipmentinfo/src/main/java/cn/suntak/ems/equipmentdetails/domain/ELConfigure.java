package cn.suntak.ems.equipmentdetails.domain;

import java.io.Serializable;

public class ELConfigure implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7355369959422459934L;
	private Long eqId;
	private Long lcId;
	public Long getEqId() {
		return eqId;
	}
	public void setEqId(Long eqId) {
		this.eqId = eqId;
	}
	public Long getLcId() {
		return lcId;
	}
	public void setLcId(Long lcId) {
		this.lcId = lcId;
	}
	
	
}
