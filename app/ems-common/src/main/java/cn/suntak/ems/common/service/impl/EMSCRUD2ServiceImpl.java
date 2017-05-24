package cn.suntak.ems.common.service.impl;



import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;

import cn.oz.IdEntity;
import cn.oz.dao.Page;
import cn.oz.exception.EntityNotUniqueException;
import cn.oz.exception.OzException;
import cn.oz.service.SimpleServiceImpl;
import cn.oz.userlog.UserLogger;
import cn.oz.userlog.UserLoggerFactory;
import cn.oz.util.ReflectionUtils;
import cn.suntak.ems.common.dao.EMSCRUD2Dao;
import cn.suntak.ems.common.service.EMSCRUD2Service;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public  abstract class EMSCRUD2ServiceImpl<T extends IdEntity, PK extends Serializable, D extends EMSCRUD2Dao<T, PK >> extends SimpleServiceImpl implements EMSCRUD2Service<T,PK> {
	@Override
	public <T1 extends IdEntity> T1 loadByCycleId(Long lifeCycleId) {
		return this.simpleDao.loadByCycleId(lifeCycleId);
	}
	@Override
	public <T1 extends IdEntity> T1 loadByProcessId(String processId) {
		return this.simpleDao.loadByProcessId(processId);
	}
	
	protected UserLogger userLogger = UserLoggerFactory.getUserLogger(this.getEntityName());
	protected D simpleDao;

	public EMSCRUD2ServiceImpl() {
	}

	public D getSimpleDao() {
		return this.simpleDao;
	}

	@Autowired
	public void setSimpleDao(D simpleDao) {
		this.simpleDao = simpleDao;
	}

	@SuppressWarnings("rawtypes")
	protected String getEntityName() {
		Class entityClass = ReflectionUtils.getSuperClassGenricType(this.getClass());
		return entityClass.getName();
	}

	public void getPage(Page page, String searchCondition) {
		this.simpleDao.getPage(page, searchCondition);
	}

	public T load(PK id) throws OzException {
		return this.simpleDao.get(id);
	}

	public void save(T entity) throws EntityNotUniqueException, OzException {
		this.simpleDao.save(entity);
		this.addUserLog4Save(entity);
	}

	public void delete(PK id) throws OzException {
		this.delete(this.simpleDao.get(id));
	}

	@SuppressWarnings("unchecked")
	public void delete(PK[] ids) throws OzException {
		if(null != ids && ids.length != 0) {
			Serializable[] arr$ = ids;
			int len$ = ids.length;

			for(int i$ = 0; i$ < len$; ++i$) {
				Serializable id = arr$[i$];
				this.delete((PK) id);
			}

		}
	}

	protected void addUserLog4Save(T entity) {
		this.userLogger.log(this.getLogMessage("oz.core.userlog.action.save"), this.getLogMessage("oz.core.userlog.logcontext.save", new Object[]{entity}), String.valueOf(entity.getId()));
	}

	protected void delete(T entity) throws OzException {
		if(null != entity) {
			this.addUserLog4Delete(entity);
			this.simpleDao.delete(entity);
		}
	}

	protected void addUserLog4Delete(T entity) {
		this.userLogger.log(this.getLogMessage("oz.core.userlog.action.delete"), this.getLogMessage("oz.core.userlog.logcontext.delete", new Object[]{entity}), String.valueOf(entity.getId()));
	}
}
