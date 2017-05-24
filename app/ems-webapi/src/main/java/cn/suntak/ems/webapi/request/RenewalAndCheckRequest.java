package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;

public class RenewalAndCheckRequest extends AbstractRequest{
  
    private RenewalAndCheck renewalAndCheck;

	public RenewalAndCheck getRenewalAndCheck() {
		return renewalAndCheck;
	}

	public void setRenewalAndCheck(RenewalAndCheck renewalAndCheck) {
		this.renewalAndCheck = renewalAndCheck;
	}
}
