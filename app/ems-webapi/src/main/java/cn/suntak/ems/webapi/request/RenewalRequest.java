package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.renewal.domain.Renewal;

public class RenewalRequest extends AbstractRequest{
  
    private Renewal  renewal;

	public Renewal getRenewal() {
		return renewal;
	}

	public void setRenewal(Renewal renewal) {
		this.renewal = renewal;
	}


    
    
    
}
