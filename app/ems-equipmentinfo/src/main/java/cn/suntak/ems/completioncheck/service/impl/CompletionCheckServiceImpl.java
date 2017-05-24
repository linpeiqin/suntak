package cn.suntak.ems.completioncheck.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.completioncheck.dao.CompletionCheckDao;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;
import cn.suntak.ems.completioncheck.service.CompletionCheckService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class CompletionCheckServiceImpl extends EMSCRUD2ServiceImpl< CompletionCheck, Long,  CompletionCheckDao> implements  CompletionCheckService{

	@Override
	public CompletionCheck create() throws OzException {
		
		CompletionCheck completionCheck = new CompletionCheck();
		completionCheck.setType("completionCheck");
		completionCheck.setProcessState(0);
		return completionCheck;
	}
	
}
