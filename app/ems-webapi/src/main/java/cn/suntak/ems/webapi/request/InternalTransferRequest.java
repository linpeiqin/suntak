package cn.suntak.ems.webapi.request;

import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.internaltransfer.domain.InternalTransfer;

public class InternalTransferRequest extends AbstractRequest{
  
    private InternalTransfer internalTransfer;

	public InternalTransfer getInternalTransfer() {
		return internalTransfer;
	}

	public void setInternalTransfer(InternalTransfer internalTransfer) {
		this.internalTransfer = internalTransfer;
	}
    
}
