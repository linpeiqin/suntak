package cn.suntak.ems.partinfo.domain;

import java.util.Date;
import java.util.Set;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.partinfo.service.PartInfoService;


@SuppressWarnings("serial")
public class PartInfoTree extends FileEntity {

	private Long  equipmentId;
	private Long  partId;
	private PartInfoTree  parent;
    private Long organizationId;
	private Set<PartInfoTree> childs;
	private Integer qty;
    private Integer isExclusive;
	private Integer type;
	private String section;             //分段
	private Integer usePeriod;          //使用周期（月）
	private Date replaceDate;          //更换时间
	private Date nextReDate;           //下次更换时间
	

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}



    public boolean hasChild(){
        return !(null == this.getChilds() || this.getChilds().isEmpty());
    }

    public Integer getIsExclusive() {
        return isExclusive;
    }

    public void setIsExclusive(Integer isExclusive) {
        this.isExclusive = isExclusive;
    }

    public String getEquipmentName() {
		EquipmentDetailsService equipmentDetailsService = AppContext.getServiceFactory().getService("equipmentDetailsService");
		if (this.equipmentId==null)
			return "";
		EquipmentDetails equipment = equipmentDetailsService.load(this.equipmentId);
		if (equipment==null)
			return "";
		return equipment.getEquipmentName();
	}
	public String getParentName() {
		
		if(null == this.parent)
			return "";
		Integer parentType = this.parent.getType();
		if (parentType==null){
			return "";
		}
		if (parentType==0){
			return this.parent.getEquipmentName();
		}
		return this.parent.getPartName();

	}
	public String getName(){
		if (this.type == 0) return this.getEquipmentName();
		return this.getPartName();
	}
	public String getPartName() {
		PartInfoService partInfoService = AppContext.getServiceFactory().getService("partInfoService");
		if (this.partId==null)
			return "";
		PartInfo partInfo = partInfoService.load(this.partId);
		if (partInfo == null){
			return "";
		}
		return partInfo.getPartName();
	}

	

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public Set<PartInfoTree> getChilds() {
		return childs;
	}

	public void setChilds(Set<PartInfoTree> childs) {
		this.childs = childs;
	}

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}

	
	public PartInfoTree getParent() {
		return parent;
	}
	public void setParent(PartInfoTree parent) {
		this.parent = parent;
	}
	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}
	public Long getPartId() {
		return partId;
	}
	public void setPartId(Long partId) {
		this.partId = partId;
	}

	
	public Integer getUsePeriod() {
		return usePeriod;
	}

	public void setUsePeriod(Integer usePeriod) {
		this.usePeriod = usePeriod;
	}

	public Date getReplaceDate() {
		return replaceDate;
	}

	public void setReplaceDate(Date replaceDate) {
		this.replaceDate = replaceDate;
	}
	
	public String getReplaceDateTime(){
		return DateTimeUtils.formatDate(replaceDate);
	}
	public void setReplaceDateTime(String replaceDate) {
		this.replaceDate = DateTimeUtils.getDate(replaceDate);
	}

	public Date getNextReDate() {
		return nextReDate;
	}

	public void setNextReDate(Date nextReDate) {
		this.nextReDate = nextReDate;
	}
	public String getNextReDateTime(){
		return DateTimeUtils.formatDate(nextReDate);
	}
	public void setNextReDateTime(String nextReDate) {
		this.nextReDate = DateTimeUtils.getDate(nextReDate);
	}
	
	
	
}