package com.seeyon.www.service;

import java.util.Map;

import cn.oz.service.SimpleService;

import com.seeyon.www.domain.Seeyon;

public interface SeeyonService extends SimpleService<Seeyon, Long>{

	Map<String,String>  callOaInterface(Long id, String templateCode, String fileName,String formMain);

}
