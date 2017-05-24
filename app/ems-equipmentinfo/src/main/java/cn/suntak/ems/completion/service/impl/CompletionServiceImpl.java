package cn.suntak.ems.completion.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.completion.dao.CompletionDao;
import cn.suntak.ems.completion.domain.Completion;
import cn.suntak.ems.completion.service.CompletionService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class CompletionServiceImpl extends EMSCRUD2ServiceImpl< Completion, Long,  CompletionDao> implements  CompletionService{

	@Override
	public Completion create() throws OzException {
		
		Completion completion = new Completion();
		completion.setType("completion");
		completion.setProcessState(0);
		return completion;
	}

	
}
