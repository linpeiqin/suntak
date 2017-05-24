package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.completion.domain.Completion;

public class CompletionRequest extends AbstractRequest{
  
    private Completion completion;


	public Completion getCompletion() {
		return completion;
	}

	public void setCompletion(Completion completion) {
		this.completion = completion;
	}

    
    
}
