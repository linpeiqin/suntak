package cn.suntak.ems.partinfo.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.annotation.AttachmentSupport;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.common.domain.CurrencyV;
import cn.suntak.ems.common.domain.DepartmentV;
import cn.suntak.ems.common.domain.OrgV;
import cn.suntak.ems.common.domain.ShipToLocationV;
import cn.suntak.ems.common.domain.SuppliersV;
import cn.suntak.ems.common.domain.VendorSiteAddrV;
import cn.suntak.ems.common.domain.VendorSitePersV;
import cn.suntak.ems.common.service.CurrencyVService;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.common.service.OrgVService;
import cn.suntak.ems.common.service.ShipToLocationVService;
import cn.suntak.ems.common.service.SuppliersVService;
import cn.suntak.ems.common.service.VendorSiteAddrVService;
import cn.suntak.ems.common.service.VendorSitePersVService;

/**
 *
 *
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
@AttachmentSupport
@SuppressWarnings("serial")
public class PRHead extends FileEntity {

	// fields =================================================================
	public static final  Integer SUCCESS  = 1;
	public static final  Integer FAIL  = 0;
	public static final  Integer NO  = -1;



	private String currencyName;//币种名称 
	private String currencyCode;//币种   CURRENCY_CODE
	private String orgId;//组织ID   ORG_ID
	private String orgName;
	private String prNo;//单据编号 PR_NO
	private String deptId;//申购部门 ID  DEPT_ID
	private String deptName;//申购部门 
	private Date   prDate;//申购日期   PR_DATE
	private String needReason;//需求原因说明   NEED_REASON
	private String applBy;//申请人      APPL_BY
	private String applByName;//申请人名称 APPL_BY_NAME
	private String approveStatus;//审核状态   APPROVE_STATUS
	private Long agentId;//采购员   AGENT_ID
	private Double poRate;//汇率   PO_RATE
	private Set<PRLine>  pRLines;
	private Integer ebsState;//EBS同步状态


	public Integer getEbsState() {
		return ebsState;
	}

	public void setEbsState(Integer ebsState) {
		this.ebsState = ebsState;
	}
	public String getDeptName() {
		DepartmentVService departmentVService = AppContext.getServiceFactory().getService("departmentVService");
		if (this.deptId==null)
			return "";
		DepartmentV departmentV = departmentVService.getDepartmentByUseD(this.deptId);
		if (departmentV==null)
			return "";
		return departmentV.getDescription();
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public Set<PRLine> getpRLines() {
		return pRLines;
	}
	public void setpRLines(Set<PRLine> pRLines) {
		this.pRLines = pRLines;
	}
	public String getOrgName() {
		OrgVService orgVService = AppContext.getServiceFactory().getService("orgVService");
		if (this.orgId==null)
			return "";
		OrgV orgV = orgVService.getOrgVBy(this.orgId);
		if (orgV==null)
			return "";
		return orgV.getOrgName();
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getCurrencyName() {
		CurrencyVService currencyVService = AppContext.getServiceFactory().getService("currencyVService");
		if (this.currencyCode==null)
			return "";
		CurrencyV currencyV = currencyVService.getCurrencyBy(this.currencyCode);
		if (currencyV==null)
			return "";
		return currencyV.getCurrencyName();
	}
	public void setCurrencyName(String currencyName) {
		this.currencyName = currencyName;
	}
	public String getCurrencyCode() {
		return currencyCode;
	}
	public void setCurrencyCode(String currencyCode) {
		this.currencyCode = currencyCode;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getPrNo() {
		return prNo;
	}
	public void setPrNo(String prNo) {
		this.prNo = prNo;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public Date getPrDate() {
		return prDate;
	}
	public void setPrDate(Date prDate) {
		this.prDate = prDate;
	}
	public String getPrDateStr() {
		return DateTimeUtils.formatDateTime(this.prDate);
	}
	public void setPrDateStr(String prDate) {
		this.prDate = DateTimeUtils.getDate(prDate);
	}
	public String getNeedReason() {
		return needReason;
	}
	public void setNeedReason(String needReason) {
		this.needReason = needReason;
	}
	public String getApplBy() {
		return applBy;
	}
	public void setApplBy(String applBy) {
		this.applBy = applBy;
	}
	public String getApproveStatus() {
		return approveStatus;
	}
	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}
	public Long getAgentId() {
		return agentId;
	}
	public void setAgentId(Long agentId) {
		this.agentId = agentId;
	}
	public Double getPoRate() {
		return poRate;
	}
	public void setPoRate(Double poRate) {
		this.poRate = poRate;
	}
	public String getApplByName() {
		return applByName;
	}
	public void setApplByName(String applByName) {
		this.applByName = applByName;
	}
}
    

