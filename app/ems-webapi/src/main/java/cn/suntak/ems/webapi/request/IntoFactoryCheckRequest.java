package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;

public class IntoFactoryCheckRequest extends AbstractRequest{
  
    private IntoFactoryCheck  intoFactoryCheck;

	public IntoFactoryCheck getIntoFactoryCheck() {
		return intoFactoryCheck;
	}

	public void setIntoFactoryCheck(IntoFactoryCheck intoFactoryCheck) {
		this.intoFactoryCheck = intoFactoryCheck;
	}

    
    
}
