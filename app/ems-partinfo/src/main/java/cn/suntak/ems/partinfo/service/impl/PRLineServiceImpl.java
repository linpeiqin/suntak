package cn.suntak.ems.partinfo.service.impl;



import java.util.List;
import java.util.Set;

import org.apache.poi.util.SystemOutLogger;

import cn.oz.exception.OzException;
import cn.oz.json.JSONObject;
import cn.oz.org.json.JSONArray;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.common.domain.LineTypeV;
import cn.suntak.ems.common.service.LineTypeVService;
import cn.suntak.ems.partinfo.dao.PRLineDao;
import cn.suntak.ems.partinfo.domain.PRLine;
import cn.suntak.ems.partinfo.service.PRLineService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRLineServiceImpl extends CRUDServiceImpl< PRLine, Long,  PRLineDao> implements  PRLineService{

	private LineTypeVService lineTypeVService = null;
	@Override
	public PRLine create() throws OzException {

		return new PRLine();
	}
	@Override
	public JSONArray getLineTypeArray() {
		List<LineTypeV> list = this.lineTypeVService.getLineTypeList();
		JSONArray array = new JSONArray();
		for(int i=0;i<list.size();i++){
			if(list.get(i).getLineTypeName().equals("外协加工"))
			{
				continue;
			}
			JSONObject json = new JSONObject();
			json.put("lineTypeId", list.get(i).getLineTypeId());
			json.put("lineTypeName", list.get(i).getLineTypeName());
			array.put(json);
		}
		
		return array;
	}
	public void setLineTypeVService(LineTypeVService lineTypeVService) {
		this.lineTypeVService = lineTypeVService;
	}
	public LineTypeVService getLineTypeVService() {
		return lineTypeVService;
	}
	public Set<PRLine> loadByHeadId(Long headId) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().loadByHeadId(headId);
	}
	@Override
	public List<PRLine> getPRLineList() {
		return this.getSimpleDao().getPRLineList();
	}

	@Override
	public List<PRLine> getPRLineListByDate(String date) {
		return this.getSimpleDao().getPRLineListByDate(date);
	}
}
