package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.sell.domain.Sell;

public class SellRequest extends AbstractRequest{
  
	private Sell sell;

	public Sell getSell() {
		return sell;
	}

	public void setSell(Sell sell) {
		this.sell = sell;
	}

    
}
