package cn.suntak.ems.filenumber.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.json.JSONer;
import cn.suntak.ems.filenumber.domain.FileNumber;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.oz.util.DateTimeUtils;
import cn.oz.web.struts.action.CRUD2Action;
import cn.oz.web.util.RequestUtils;

/**
 * 编号管理Action
 * 
 * @author yanxuehui
 * @version 5.2.0
 */
public class FileNumberAction extends CRUD2Action<FileNumber, FileNumberService> {
	
	FileNumberService fileNumberService = null;

	public void setServlet(ActionServlet actionServlet) {
		super.setServlet(actionServlet);
		this.fileNumberService = this.getServiceBean("fileNumberService");
	}
	
	@Override
	protected String getViewToolbarBtns(HttpServletRequest request, ActionForm form) {

		if (this.getService().isAdmin())
			return "";
		return "btnBack";
	}

	@Override
	protected String getFormToolbarBtns(HttpServletRequest request, ActionForm form,FileNumber fileNumber, boolean canEdit) {		
		
		if (this.getService().isAdmin())
			return "";
		return "btnBack";
	}
	
	protected void getPageData(HttpServletRequest request, Page page) throws Exception {
		String unitId = RequestUtils.getStringParameter(request, "unitId", "-1");
		if ("-1".equals(unitId)) {
			unitId = UserContextHolder.get().getCurUserInfo().getUnitId();
	
		}
		this.getService().getPage(page, unitId);
	}


	protected JSONer<FileNumber> getJsoner(HttpServletRequest request, ActionForm form) {
		return new JSONer<FileNumber>() {
			public String toJSON(FileNumber fileNumber, int index, Page page) throws Exception {
				JSONObject json = new JSONObject();
				json.put("id", String.valueOf(fileNumber.getId()));
				json.put("status", String.valueOf(fileNumber.getStatus()));
				json.put("subject", fileNumber.getNumberName());
				json.put("numberName", fileNumber.getNumberName());
				json.put("numberCode", fileNumber.getNumberCode());
				json.put("serial", fileNumber.getSerial());
				
				json.put("author_name", fileNumber.getAuthor().getName());
				json.put("numberDate", DateTimeUtils.formatDateTime(fileNumber.getNumberDate()));
				json.put("fileDate", fileNumber.getCreatedDateTime());
				
				json.put("numberPrefix", fileNumber.getNumberPrefix());
				json.put("numberOrder", fileNumber.getNumberOrder());
				json.put("numberPostfix", fileNumber.getNumberPostfix());
				return json.toString();
			}
		};
	}
	
	
	public ActionForward CreateNumber(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String code = RequestUtils.getStringParameter(request, "code", "");
		String unitId = RequestUtils.getStringParameter(request, "unitId", "-1");
		if ("-1".equals(unitId)) {
			unitId = UserContextHolder.get().getCurUserInfo().getUnitId();
	
		}
		
		JSONObject result = new JSONObject();
		result.put("result", true);
		
		String fileNumber=this.fileNumberService.doCreateNumber(unitId,code);
		
		result.put("fileNumber", fileNumber);

		
		return this.renderJson(response, result.toString());
	}

}
