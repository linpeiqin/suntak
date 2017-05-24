package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.scrap.domain.Scrap;

public class ScrapRequest extends AbstractRequest{
  
    private Scrap  scrap;

	public Scrap getScrap() {
		return scrap;
	}

	public void setScrap(Scrap scrap) {
		this.scrap = scrap;
	}

    
}
