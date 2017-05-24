package cn.suntak.ems.scrap.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.scrap.dao.ScrapDao;
import cn.suntak.ems.scrap.domain.Scrap;
import cn.suntak.ems.scrap.service.ScrapService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class ScrapServiceImpl extends EMSCRUD2ServiceImpl< Scrap, Long,  ScrapDao> implements  ScrapService{

	@Override
	public Scrap create() throws OzException {
		
		Scrap scrap = new Scrap();
		scrap.setType("scrap");
		scrap.setProcessState(0);
		return scrap;
	}
	
}
