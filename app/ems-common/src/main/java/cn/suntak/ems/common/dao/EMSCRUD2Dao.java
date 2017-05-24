package cn.suntak.ems.common.dao;

import java.io.Serializable;

import cn.oz.IdEntity;
import cn.oz.dao.SimpleDao;

/**
 * Created by linking on 2016/10/13.
 */
public interface EMSCRUD2Dao<T, PK extends Serializable>  extends SimpleDao<T, PK> {
    <T1 extends IdEntity> T1 loadByCycleId(Long lifeCycleId);
    <T1 extends IdEntity> T1 loadByProcessId(String processId);
    
}
