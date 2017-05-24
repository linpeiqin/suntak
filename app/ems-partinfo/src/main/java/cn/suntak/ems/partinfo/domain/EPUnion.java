package cn.suntak.ems.partinfo.domain;

import cn.oz.FileEntity;

import java.util.Set;


@SuppressWarnings("serial")
public class EPUnion extends FileEntity {

	private long  equipmentId;
	private Set<PartInfo> partInfos;
    private Long organizationId;

	public Long getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}


	public Set<PartInfo> getPartInfos() {
		return partInfos;
	}

	public void setPartInfos(Set<PartInfo> partInfos) {
		this.partInfos = partInfos;
	}

	public long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(long equipmentId) {
		this.equipmentId = equipmentId;
	}

}