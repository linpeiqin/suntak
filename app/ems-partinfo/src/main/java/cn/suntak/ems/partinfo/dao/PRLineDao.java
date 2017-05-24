package cn.suntak.ems.partinfo.dao;



import java.util.List;
import java.util.Set;

import cn.oz.dao.SimpleDao;
import cn.suntak.ems.partinfo.domain.PRLine;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PRLineDao extends SimpleDao<PRLine, Long> {

	Set<PRLine> loadByHeadId(Long headId);
	List<PRLine> getPRLineList();
	List<PRLine> getPRLineListByDate(String date);
}