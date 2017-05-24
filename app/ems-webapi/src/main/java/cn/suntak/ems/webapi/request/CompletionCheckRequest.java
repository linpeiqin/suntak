package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;

public class CompletionCheckRequest extends AbstractRequest{
  
	private CompletionCheck  completionCheck;

	public CompletionCheck getCompletionCheck() {
		return completionCheck;
	}

	public void setCompletionCheck(CompletionCheck completionCheck) {
		this.completionCheck = completionCheck;
	}

}
