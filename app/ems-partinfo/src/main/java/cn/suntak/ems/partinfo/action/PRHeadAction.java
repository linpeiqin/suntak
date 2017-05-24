package cn.suntak.ems.partinfo.action;


import java.applet.AppletContext;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.AppContext;
import cn.oz.dao.Page;
import cn.oz.exception.CannotDeleteEntityException;
import cn.oz.exception.OzException;
import cn.oz.web.AppConfig;
import cn.oz.web.util.ActionUtils;
import cn.suntak.ems.common.domain.PRLinesV;
import cn.suntak.ems.common.service.PRLinesVService;
import cn.suntak.ems.filenumber.service.FileNumberService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.json.JSONObject;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONException;
import cn.oz.util.BeanUtils;
import cn.oz.util.DateTimeUtils;
import cn.oz.util.SelectOption;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.common.service.VendorSiteAddrVService;
import cn.suntak.ems.common.service.VendorSitePersVService;
import cn.suntak.ems.partinfo.domain.PRHead;
import cn.suntak.ems.partinfo.domain.PRLine;
import cn.suntak.ems.partinfo.service.PRHeadService;
import cn.suntak.ems.partinfo.service.PRLineService;
import org.springframework.dao.DataAccessException;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRHeadAction extends EMSCRUDAction<PRHead, PRHeadService>{
	private PRLineService  pRLineService;
	private FileNumberService fileNumberService;
	public void initAction() {
        super.initAction();
		this.fileNumberService = this.getServiceBean("fileNumberService");
		this.pRLineService = this.getServiceBean("pRLineService");
    }
	public ActionForward HPPartRemind(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		return mapping.findForward("HPPartRemind");
	}
	public ActionForward getPRLineJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		long id = this.getFileId(request);
		PRHead pRHead = this.getService().load(id);
		if (pRHead==null){
			return null;
		}
		JSONObject json = getPRLineJson(pRHead.getpRLines());
		return this.renderJson(response, json);
	}
	private JSONObject getPRLineJson(Set<PRLine> pRLines){
		JSONObject json = new JSONObject();
		if(pRLines!=null&&pRLines.size()>0){
			json.put("total",pRLines.size());
			cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
			for(PRLine pRLine: pRLines){
				JSONObject row = new JSONObject();
				Field[] fields = pRLine.getClass().getDeclaredFields();
				for(Field field :fields){
					field.setAccessible(true);
					if(field.getName().equals("urgentText"))
					{
						row.put(field.getName(),pRLine.getUrgentText());
						continue;
					}
					if(field.getName().equals("lineTypeName"))
					{
						row.put(field.getName(), pRLine.getLineTypeName());
						continue;
					}
					if(field.getName().equals("itemNo"))
					{
						row.put(field.getName(), pRLine.getItemNo());
						continue;
					}
					if(field.getName().equals("itemName"))
					{
						row.put(field.getName(), pRLine.getItemName());
						continue;
					}
					try {
						row.put(field.getName(), field.get(pRLine));
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				}
				array.add(row);
			}
			json.put("rows", array);
		}else{
			json.put("total", 0);
			json.put("rows", new cn.oz.json.JSONArray());
		}
		return json;
	}
	public ActionForward getPRLineJsonV(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long headId = RequestUtils.getLongParameter(request,"id",-1L);
		Set<PRLine> pRLines = null;
		if (headId!=-1){
			pRLines = this.pRLineService.loadByHeadId(headId);
		}
		JSONObject json  = getPRLineJson(pRLines);
		return this.renderJson(response, json);
	}
	
	protected void save(HttpServletRequest request, ActionForm form, PRHead domain) throws Exception {
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		domain.setOrgId(orgId);
		if (domain.getPrNo()==null || domain.getPrNo().equals("")) {
			String prNo = this.fileNumberService.doCreateNumber("SGDH");
			domain.setPrNo(prNo);
		}
		this.getService().save(domain);
	}
	protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, PRHead domain, JSONObject json) throws Exception {
		json.put("prNo",domain.getPrNo());
	}

	@Override
	protected void initForm(HttpServletRequest request, ActionForm form, PRHead domain, boolean canEdit) {
		PRLinesVService pRLinesVService = AppContext.getServiceFactory().getService("pRLinesVService");
		PRLinesV pRLinesV = null;
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
			domain.setOrgId(orgId);
			if(domain != null && domain.getEbsState()==1){
				Set<PRLine> list = domain.getpRLines();
				if(list != null) {
					for (PRLine pRLine : list) {
						if (pRLine.getIsUrgent().equals("Y") && pRLine != null && pRLine.getNeedDate() == null) {
							pRLinesV = pRLinesVService.getPRLinesVBy(pRLine.getId());
							if (pRLinesV != null && pRLinesV.getReceiveDate() != null)
								pRLine.setNeedDate(pRLinesV.getReceiveDate());
						}
					}
				}
			}
		super.initForm(request, form, domain, canEdit);
	}

	@Override
	protected void afterSubmitEBS(Long id, String fileName, JSONObject json) {
		PRHead pRHead = this.getService().load(id);
		if (json.get("flag").equals("Y")){
			pRHead.setEbsState(PRHead.SUCCESS);
		} else {
			if(!pRHead.getEbsState().equals(PRHead.SUCCESS)){
				pRHead.setEbsState(PRHead.FAIL);
			}
		}
		this.getService().save(pRHead);

	}

	@Override
	protected String getFormToolbarBtns(HttpServletRequest request, ActionForm form, PRHead domain, boolean canEdit) {
		if (domain.getEbsState().equals(PRHead.SUCCESS)){
			return "none";
		}
		return super.getFormToolbarBtns(request, form, domain, canEdit);
	}

	@Override
	protected boolean openOrEdit(HttpServletRequest request, ActionForm form, PRHead domain) throws Exception {
		if (domain.getEbsState().equals(PRHead.SUCCESS)){
			return false;
		}
		return true;
	}

	@Override
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception
	{
		JSONObject json = new JSONObject();
		json.put("result", Boolean.valueOf(true));
		json.put("msg", ActionUtils.getDeleteMsg());

		Long[] deleteIds = ActionUtils.getFileIds(request);
		if ((null != deleteIds) && (deleteIds.length > 0)) {
			try
			{
				PRHead  pRHead = null;
				List<Long> idList = new ArrayList<Long>();
				for(int i = 0 ;i<deleteIds.length ;i++){
					pRHead = this.getService().load(deleteIds[i]);
					if(pRHead.getEbsState().equals(PRHead.SUCCESS))
					{
						continue;
					}
					idList.add(deleteIds[i]);
				}
				if(idList != null && !idList.isEmpty()){
					Long[] ids = (Long[])idList.toArray(new Long[idList.size()]);
					beforeDelete(request, form, ids);
					delete(request, form, ids);
				}else{
					json.put("result", Boolean.valueOf(false));
					json.put("msg", "已经同步的不能删除");
				}

			} catch (DataAccessException e) {
				this.logger.error(e.getMessage(), e);
				return renderExceptionWithAjax(response, new CannotDeleteEntityException());
			} catch (OzException e) {
				this.logger.error(e.getMessage(), e);
				return forwardErrorWithAjax(response, e.getMessage());
			} catch (Exception e) {
				this.logger.error(e.getMessage(), e);
				return renderExceptionWithAjax(response, e);
			}
		}
		return renderJson(response, json.toString());
	}


	protected PRHead getDomain(HttpServletRequest request, ActionForm form) throws Exception {
		long id = this.getFileId(request);
		PRHead domain = null;
		if (this.isBlankId(id)) {
			domain = this.createDomain(request, form);
		} else {
			domain = this.loadDomain(request, form, id);
		}

		BeanUtils.copyProperties(domain, form);
		String pRLineStr = RequestUtils.getStringParameter(request, "pRLine1", "");
		if (!pRLineStr.equals("")) {
			JSONArray array = new JSONArray(pRLineStr);
			Set<PRLine> pRLineSet = null;
			if (domain.getpRLines() == null) {
				pRLineSet = new HashSet<PRLine>();
			} else {
				pRLineSet = domain.getpRLines();
				pRLineSet.clear();
			}
			for (int i = 0; i < array.length(); i++) {
				PRLine pRLine = new PRLine();
				this.setPRLineInfo(pRLine, array.getJSONObject(i));
				pRLine.setpRHead(domain);
				pRLineSet.add(pRLine);
			}

			domain.setpRLines(pRLineSet);
		}
		return domain;
	}



	private void setPRLineInfo(PRLine pRLine, cn.oz.org.json.JSONObject obj) {
		JSONArray names = obj.names();
		for (int j = 0; j < names.length(); j++) {
			String fieldName = null;
			try {
				fieldName = names.get(j).toString();
				if (fieldName.equals("editing")) continue;
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String fieldValue = null;

			try {
				fieldValue = obj.get(names.get(j).toString()).toString();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Field field = null;
			try {
				field = pRLine.getClass().getDeclaredField(fieldName);
			} catch (SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchFieldException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (field != null) {
				if(fieldName.equals("pRHead"))
					continue;
				Class<?> clas = field.getType();
				field.setAccessible(true);
					if (clas.toString().equals("class java.util.Date")) {
					try {
						field.set(pRLine, DateTimeUtils.getDate(fieldValue));
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					continue;
				}
				if (clas.toString().equals("class java.lang.Integer")) {
					try {
						field.set(pRLine, Integer.valueOf(fieldValue));
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					continue;
				}
				if (clas.toString().equals("class java.lang.Long")) {
					try {
						field.set(pRLine, Long.valueOf(fieldValue));
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					continue;
				}
				if (clas.toString().equals("class java.lang.Double")) {
					try {
						field.set(pRLine, Double.parseDouble(fieldValue));
					} catch (NumberFormatException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					continue;
				}
				try {
					field.set(pRLine, fieldValue);
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
}