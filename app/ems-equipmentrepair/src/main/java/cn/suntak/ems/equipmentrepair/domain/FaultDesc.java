package cn.suntak.ems.equipmentrepair.domain;

import cn.oz.FileEntity;
import cn.oz.config.helper.DataDictHelper;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@SuppressWarnings("serial")
public class FaultDesc extends FileEntity {

	// fields =================================================================
	private String faultType;//故障分类  FAULT_TYPE
	private String faultTypeName;
	private String appearanceSummary;//现象摘要  APPEARANCE_SUMMARY
	private String apearanceDetail;//现象详细   APPEARANCE_DETAIL
	private String dealSummary;//处理摘要   DEAL_SUMMARY
	private String dealDetail;//处理详细  DEAL_DETAIL

	
	public String getFaultTypeName() {
		if(this.getFaultType()==null) return null;
		return  DataDictHelper.getDataDict("GZLB", this.getFaultType()).getName();
	}

	public void setFaultTypeName(String faultTypeName) {
		this.faultTypeName = faultTypeName;
	}

	public String getFaultType() {
		return faultType;
	}

	public void setFaultType(String faultType) {
		this.faultType = faultType;
	}

	public String getAppearanceSummary() {
		return appearanceSummary;
	}

	public void setAppearanceSummary(String appearanceSummary) {
		this.appearanceSummary = appearanceSummary;
	}

	public String getApearanceDetail() {
		return apearanceDetail;
	}

	public void setApearanceDetail(String apearanceDetail) {
		this.apearanceDetail = apearanceDetail;
	}

	public String getDealSummary() {
		return dealSummary;
	}

	public void setDealSummary(String dealSummary) {
		this.dealSummary = dealSummary;
	}

	public String getDealDetail() {
		return dealDetail;
	}

	public void setDealDetail(String dealDetail) {
		this.dealDetail = dealDetail;
	}

}