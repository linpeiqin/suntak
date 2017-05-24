package cn.suntak.ems.equipmentdetails.domain;


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
public class TechnicalParams extends FileEntity {
	
	private String technicalParam;  //TECHNICAL_PARAM  技术参数
	private String paramValue;  //PARAM_VALUE 参数值
	private EquipmentDetails equipmentDetails;
    private Long organizationId;

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
	public String getTechnicalParam() {
		return technicalParam;
	}
	public void setTechnicalParam(String technicalParam) {
		this.technicalParam = technicalParam;
	}
	public String getParamValue() {
		return paramValue;
	}
	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	
}
