package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;

public class RenewalCheckRequest extends AbstractRequest{
  
    private RenewalCheck  renewalCheck;

	public RenewalCheck getRenewalCheck() {
		return renewalCheck;
	}

	public void setRenewalCheck(RenewalCheck renewalCheck) {
		this.renewalCheck = renewalCheck;
	}
    
}
