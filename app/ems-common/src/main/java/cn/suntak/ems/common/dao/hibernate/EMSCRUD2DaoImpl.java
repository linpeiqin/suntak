package cn.suntak.ems.common.dao.hibernate;

import cn.oz.IdEntity;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.common.dao.EMSCRUD2Dao;

import java.io.Serializable;

/**
 * Created by linking on 2016/10/13.
 */
public abstract class EMSCRUD2DaoImpl<T, PK extends Serializable> extends SimpleDaoImpl<T, PK> implements EMSCRUD2Dao<T, PK> {

    @SuppressWarnings("unchecked")
	@Override
    public <T1 extends IdEntity> T1 loadByCycleId(Long lifeCycleId) {
        return (T1) this.findUniqueBy("equipmentLifeCycle.id",lifeCycleId);
    }
    @SuppressWarnings("unchecked")
	@Override
    public <T1 extends IdEntity> T1 loadByProcessId(String processId) {
        return (T1) this.findUniqueBy("processId",processId);
    }
    
}
