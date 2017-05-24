package cn.suntak.ems.equipmentdetails.service.impl;



import java.lang.reflect.Field;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.json.JSONArray;
import cn.oz.json.JSONObject;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentdetails.dao.TechnicalParamsDao;
import cn.suntak.ems.equipmentdetails.domain.TechnicalParams;
import cn.suntak.ems.equipmentdetails.service.TechnicalParamsService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class TechnicalParamsServiceImpl extends CRUDServiceImpl< TechnicalParams, Long,  TechnicalParamsDao> implements  TechnicalParamsService{

	@Override
	public TechnicalParams create() throws OzException {
		
		return new TechnicalParams();
	}

	@Override
	public void getPage(Page page, SearchQuery searchQuery) {

		this.getSimpleDao().getPage(page, searchQuery);
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId) {
		this.getSimpleDao().getPage(page, dbftSearchParams,searchQuery,equipmentId);
	}

	@Override
	public JSONObject getTechParaJson(String dbftSearchParams,
			SearchQuery searchQuery, Long equipmentId) {
		List<TechnicalParams> list = this.getSimpleDao().getTechParaList(searchQuery,equipmentId);
		JSONObject json = new JSONObject();
		if(list!=null&&list.size()>0){
			json.put("total",list.size());
			JSONArray array = new JSONArray();
			for(TechnicalParams biInfo: list){
				JSONObject row = new JSONObject();
				Field[] fields = biInfo.getClass().getDeclaredFields();
				row.put("id", biInfo.getId());
				if(fields!=null&&fields.length>0){
					for(Field field :fields){
						field.setAccessible(true);
						try {
							row.put(field.getName(), field.get(biInfo));
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						}
					}
				}
				array.add(row);
			}
			json.put("rows", array);
		}else{
			json.put("total", 0);
			json.put("rows", new JSONArray());
		}
		return json;
	}

}
