package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.intofactoryandcheck.domain.IntoFactoryAndCheck;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;

public class IntoFactoryAndCheckRequest extends AbstractRequest{
  
    private IntoFactoryAndCheck intoFactoryAndCheck;

	public IntoFactoryAndCheck getIntoFactoryAndCheck() {
		return intoFactoryAndCheck;
	}

	public void setIntoFactoryAndCheck(IntoFactoryAndCheck intoFactoryAndCheck) {
		this.intoFactoryAndCheck = intoFactoryAndCheck;
	}
}
