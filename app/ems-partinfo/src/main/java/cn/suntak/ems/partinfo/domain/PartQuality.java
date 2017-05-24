package cn.suntak.ems.partinfo.domain;

import java.util.Date;

import cn.oz.FileEntity;
import cn.oz.config.helper.DataDictHelper;


@SuppressWarnings("serial")
public class PartQuality extends FileEntity {

	private String qualityType;//评价分类  QUALITY_TYPE
	private String qualityTypeName;
	private String judgmentDetail;//评价详细内容  JUDGEMENT_DETAIL
	private String createdBy;//评价人  CREATED_BY
	private Date   createdDate;//创建日期  CREATED_DATE
	private long   partId;//配件ID  PART_ID
	
	public String getQualityTypeName() {
		if(this.getQualityType()==null) return null;
		return  DataDictHelper.getDataDict("ZLPJ", this.getQualityType()).getName();
	}
	public void setQualityTypeName(String qualityTypeName) {
		this.qualityTypeName = qualityTypeName;
	}
	public String getQualityType() {
		return qualityType;
	}
	public void setQualityType(String qualityType) {
		this.qualityType = qualityType;
	}
	public String getJudgmentDetail() {
		return judgmentDetail;
	}
	public void setJudgmentDetail(String judgmentDetail) {
		this.judgmentDetail = judgmentDetail;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public long getPartId() {
		return partId;
	}
	public void setPartId(long partId) {
		this.partId = partId;
	}
	
}