package cn.suntak.ems.common.service;

import java.io.Serializable;

import cn.oz.IdEntity;
import cn.oz.service.SimpleService;

/**
 * Created by linking on 2016/10/13.
 */
public interface EMSCRUD2Service<T,PK extends Serializable> extends SimpleService<T, PK> {

    @SuppressWarnings("hiding")
	<T extends IdEntity> T loadByCycleId(Long lifeCycleId);
    
    @SuppressWarnings("hiding")
	<T extends IdEntity> T loadByProcessId(String processId);
}
