package cn.suntak.ems.equipmentrepair.domain;

import cn.oz.FileEntity;

@SuppressWarnings("serial")
public class MaintainContent extends FileEntity {

	private String content;
	private Maintain maintain;
	private String mCheck;
	private String mClear;
	private String mAdjust;
	private String mLubric;
	private String mRepair;
	private String mChange;
	
	public String getmCheck() {
		return mCheck;
	}
	public void setmCheck(String mCheck) {
		this.mCheck = mCheck;
	}
	public String getmClear() {
		return mClear;
	}
	public void setmClear(String mClear) {
		this.mClear = mClear;
	}
	public String getmAdjust() {
		return mAdjust;
	}
	public void setmAdjust(String mAdjust) {
		this.mAdjust = mAdjust;
	}
	public String getmLubric() {
		return mLubric;
	}
	public void setmLubric(String mLubric) {
		this.mLubric = mLubric;
	}
	public String getmRepair() {
		return mRepair;
	}
	public void setmRepair(String mRepair) {
		this.mRepair = mRepair;
	}
	public String getmChange() {
		return mChange;
	}
	public void setmChange(String mChange) {
		this.mChange = mChange;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Maintain getMaintain() {
		return maintain;
	}
	public void setMaintain(Maintain maintain) {
		this.maintain = maintain;
	}

}
