package cn.suntak.ems.partinfo.service;

import java.util.List;
import java.util.Set;

import cn.oz.org.json.JSONArray;
import cn.oz.service.SimpleService;
import cn.suntak.ems.partinfo.domain.PRLine;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PRLineService extends SimpleService<PRLine, Long>{

	JSONArray getLineTypeArray();

	Set<PRLine> loadByHeadId(Long headId);
	List<PRLine> getPRLineList();
	List<PRLine> getPRLineListByDate(String date);

}
