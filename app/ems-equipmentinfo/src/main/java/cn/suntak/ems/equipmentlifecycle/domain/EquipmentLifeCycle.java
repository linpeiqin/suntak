package cn.suntak.ems.equipmentlifecycle.domain;


import cn.oz.FileEntity;
import cn.oz.config.helper.DataDictHelper;
import cn.suntak.ems.completion.domain.Completion;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.internaltransfer.domain.InternalTransfer;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.intofactoryandcheck.domain.IntoFactoryAndCheck;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;
import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;
import cn.suntak.ems.scrap.domain.Scrap;
import cn.suntak.ems.sell.domain.Sell;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@SuppressWarnings("serial")
public class EquipmentLifeCycle extends FileEntity {
	private Date startTime;
	private Date endTime;
	private String type;
	private Date ebsDate;
	private Integer ebsType;
	private Date oaDate;
	private Integer oaType;
	private String createdBy;
	private String remark;
	private Date updatedDate;
	private String updatedBy;
    private Long organizationId;

	private String processId;
	private Integer processState;

    private InternalTransfer internalTransfer;
    private IntoFactory intoFactory;
    private IntoFactoryCheck intoFactoryCheck;
    private Renewal renewal;
    private RenewalCheck renewalCheck ;
    private Scrap scrap ;
    private Sell sell ;
    private Completion completion;
	private CompletionCheck completionCheck;

	private IntoFactoryAndCheck intoFactoryAndCheck;
	private RenewalAndCheck renewalAndCheck;

    private Set<EquipmentDetails> equipmentDetails;
    
	public InternalTransfer getInternalTransfer() {
		return internalTransfer;
	}

	public void setInternalTransfer(InternalTransfer internalTransfer) {
		this.internalTransfer = internalTransfer;
	}

	public IntoFactory getIntoFactory() {
		return intoFactory;
	}

	public void setIntoFactory(IntoFactory intoFactory) {
		this.intoFactory = intoFactory;
	}

	public IntoFactoryCheck getIntoFactoryCheck() {
		return intoFactoryCheck;
	}

	public void setIntoFactoryCheck(IntoFactoryCheck intoFactoryCheck) {
		this.intoFactoryCheck = intoFactoryCheck;
	}

	public Renewal getRenewal() {
		return renewal;
	}

	public void setRenewal(Renewal renewal) {
		this.renewal = renewal;
	}

	public RenewalCheck getRenewalCheck() {
		return renewalCheck;
	}

	public void setRenewalCheck(RenewalCheck renewalCheck) {
		this.renewalCheck = renewalCheck;
	}

	public Scrap getScrap() {
		return scrap;
	}

	public void setScrap(Scrap scrap) {
		this.scrap = scrap;
	}

	public Sell getSell() {
		return sell;
	}

	public void setSell(Sell sell) {
		this.sell = sell;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	public String getTypeName() {
		return DataDictHelper.getDataDict("LIFE-CYCLE", this.getType()).getName();
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}

	public Date getEbsDate() {
		return ebsDate;
	}

	public void setEbsDate(Date ebsDate) {
		this.ebsDate = ebsDate;
	}

	public Integer getEbsType() {
		return ebsType;
	}

	public void setEbsType(Integer ebsType) {
		this.ebsType = ebsType;
	}

	public Date getOaDate() {
		return oaDate;
	}

	public void setOaDate(Date oaDate) {
		this.oaDate = oaDate;
	}

	public Integer getOaType() {
		return oaType;
	}

	public void setOaType(Integer oaType) {
		this.oaType = oaType;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getRemark() {


		if(type!=null&&intoFactory!=null){
			return intoFactory.getWPATI();
		}else if(type!=null&&intoFactoryCheck!=null){
			return intoFactoryCheck.getWPATI();
		}else if(type!=null&&renewal!=null){
			return renewal.getFaUpdateContent();
		}else if(type!=null&&renewalCheck!=null){
			return renewalCheck.getFaUpdateContent();
		}else if(type!=null&&internalTransfer!=null){
			return internalTransfer.getFaPrincipleTechnology();
		}else if(type!=null&&scrap!=null){
			return scrap.getFaTechnicalIndex();
		}else if(type!=null&&completion!=null){
			return completion.getWPT();
		}else if(type!=null&&completionCheck!=null){
			return completionCheck.getWPT();
		}else if(type!=null&&intoFactoryAndCheck!=null){
			return intoFactoryAndCheck.getWPATI();
		}else if(type!=null&&renewalAndCheck!=null){
			return renewalAndCheck.getFaUpdateContent();
		}
		return null;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public void setEquipmentDetails(Set<EquipmentDetails> equipmentDetails) {
		this.equipmentDetails = equipmentDetails;
	}

	public Set<EquipmentDetails> getEquipmentDetails() {
		if(equipmentDetails==null)
			equipmentDetails = new  HashSet<EquipmentDetails>();
		return equipmentDetails;
	}

	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getProcessId() {
		return processId;
	}
	public void setProcessState(Integer processState) {
		this.processState = processState;
	}
	public Integer getProcessState() {
		return processState;
	}

	public Completion getCompletion() {
		return completion;
	}

	public void setCompletion(Completion completion) {
		this.completion = completion;
	}

	public CompletionCheck getCompletionCheck() {
		return completionCheck;
	}

	public void setCompletionCheck(CompletionCheck completionCheck) {
		this.completionCheck = completionCheck;
	}

	public IntoFactoryAndCheck getIntoFactoryAndCheck() {
		return intoFactoryAndCheck;
	}

	public void setIntoFactoryAndCheck(IntoFactoryAndCheck intoFactoryAndCheck) {
		this.intoFactoryAndCheck = intoFactoryAndCheck;
	}

	public RenewalAndCheck getRenewalAndCheck() {
		return renewalAndCheck;
	}

	public void setRenewalAndCheck(RenewalAndCheck renewalAndCheck) {
		this.renewalAndCheck = renewalAndCheck;
	}
}
