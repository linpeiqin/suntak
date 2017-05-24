package cn.suntak.ems.equipmentrepair.service;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.MaintainContent;

public interface MaintainContentService extends SimpleService<MaintainContent, Long>{

	public int delByMaintainId(Long maintainId);
}
