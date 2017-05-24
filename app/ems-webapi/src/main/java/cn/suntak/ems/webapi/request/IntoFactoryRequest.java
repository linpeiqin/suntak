package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.intofactory.domain.IntoFactory;

public class IntoFactoryRequest extends AbstractRequest{
  
    private IntoFactory  intoFactory;

	public IntoFactory getIntoFactory() {
		return intoFactory;
	}

	public void setIntoFactory(IntoFactory intoFactory) {
		this.intoFactory = intoFactory;
	}
}
