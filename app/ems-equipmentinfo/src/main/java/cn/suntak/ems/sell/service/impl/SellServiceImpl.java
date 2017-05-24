package cn.suntak.ems.sell.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.sell.dao.SellDao;
import cn.suntak.ems.sell.domain.Sell;
import cn.suntak.ems.sell.service.SellService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class SellServiceImpl extends EMSCRUD2ServiceImpl< Sell, Long,  SellDao> implements  SellService{

	@Override
	public Sell create() throws OzException {
		
		Sell sell = new Sell();
		sell.setType("sell");
		sell.setProcessState(0);
		return sell;
	}

}
