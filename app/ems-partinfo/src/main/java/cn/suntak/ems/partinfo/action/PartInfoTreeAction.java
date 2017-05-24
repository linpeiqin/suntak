package cn.suntak.ems.partinfo.action;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.AppContext;
import cn.oz.UserContextHolder;
import cn.oz.config.domain.DataDict;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.config.service.DataDictService;
import cn.oz.dao.Page;
import cn.oz.json.JSONArray;
import cn.oz.json.JSONObject;
import cn.oz.util.BeanUtils;
import cn.oz.util.DateUtils;
import cn.oz.util.StringUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.partinfo.domain.PartInfo;
import cn.suntak.ems.partinfo.domain.PartInfoTree;
import cn.suntak.ems.partinfo.service.PartInfoService;
import cn.suntak.ems.partinfo.service.PartInfoTreeService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoTreeAction extends EMSCRUDAction<PartInfoTree, PartInfoTreeService>{
	
	private EquipmentDetailsService equipmentDetailsService;
	private PartInfoService partInfoService;
	private DataDictService dataDictService;
	
	@Override
	public void initAction() {
		// TODO Auto-generated method stub
		super.initAction();
		equipmentDetailsService = this.getServiceBean("equipmentDetailsService");
		partInfoService = this.getServiceBean("partInfoService");
		dataDictService = this.getServiceBean("dataDictService");
	}
	
	@Override
	protected void initForm(HttpServletRequest request, ActionForm form,
			PartInfoTree domain, boolean canEdit) {
		// TODO Auto-generated method stub
		Long id = RequestUtils.getLongParameter(request, "id", -1);              
		Long parentId = RequestUtils.getLongParameter(request, "parentId", -1); 
		PartInfoTree parentTree = null;
		if(id != -1){              //编辑
			PartInfoTree partInfoTree = this.getService().load(id);
			if(partInfoTree != null && partInfoTree.getType() == 1){       //配件
				parentTree = partInfoTree.getParent();
			}
		}
		if(parentId != -1){        //新建
			parentTree = this.getService().load(parentId);
		}
		Long equipmentId = null;
		if(parentTree != null)
			equipmentId = parentTree.getEquipmentId();
		if(equipmentId != null){
			DataDict equipmentDict = DataDictHelper.getDataDict("SBFD", equipmentId+"");
			if(equipmentDict != null){
				Set<DataDict> sections = equipmentDict.getChilds();
				request.setAttribute("sections", sections);
			}
		}
	}

    @Override
    protected PartInfoTree createDomain(HttpServletRequest request, ActionForm form) throws Exception {
        PartInfoTree partInfoTree = this.getService().create();
        Long parentId = RequestUtils.getLongParameter(request, "parentId", -1);
        Integer type = RequestUtils.getIntParameter(request, "type", 0);
        if(parentId != -1){
            PartInfoTree parent = this.getService().load(parentId);
            if(null != parent)
                partInfoTree.setParent(parent);
        }
        partInfoTree.setType(type);
        request.setAttribute("type",type);
        return partInfoTree;
    }
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long parentId = RequestUtils.getLongParameter(request, "parentId", -1);
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1);
        boolean flag = RequestUtils.getBooleanParameter("flag", false);
        this.getService().getPage(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),parentId,equipmentId,flag);
    }

    
    @Override
    protected void beforeDisplay(HttpServletRequest request, ActionForm form)
    		throws Exception {
    	// TODO Auto-generated method stub
    	long parentId = RequestUtils.getLongParameter(request, "parentId", -1);
    	String flag = request.getParameter("flag");
    	request.setAttribute("parentId", parentId);
    	request.setAttribute("flag", flag);
    }

    /**
     * 获取分类树
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ActionForward getParentTree(ActionMapping mapping, ActionForm form,
                                       HttpServletRequest request,
                                       HttpServletResponse response) throws Exception {
        long parentId = RequestUtils.getLongParameter(request, "id", -1);
        JSONArray jsonArray = new JSONArray();
        List<PartInfoTree> pits = this.getService().findByParent(parentId);
        if(null != pits && pits.size() > 0){
            for (PartInfoTree partInfoTree : pits) {
                JSONObject json = new JSONObject();
                json.put("id", String.valueOf(partInfoTree.getId()));
                json.put("text", StringUtils.nullToString(partInfoTree.getName()));
                json.put("type",partInfoTree.getType());
                if(partInfoTree.hasChild())
                    json.put("state", "closed");
                else
                    json.put("children", "");
                jsonArray.put(json);
            }
        }

      /*  if(showRoot){
            JSONArray jsonRootArray = new JSONArray();
            PartInfoTree parent = this.getService().load(parentId);
            JSONObject root = new JSONObject();
            if(null == parent){
                root.put("id", "-1");
                root.put("text","配件关联树");
            }else{
                root.put("id", String.valueOf(parent.getId()));
                root.put("text", StringUtils.nullToString(parent.getName()));
            }
            root.put("children", jsonArray);
            jsonRootArray.put(root);
            return this.renderJson(response, jsonRootArray.toString());
        }
        */
        return this.renderJson(response, jsonArray.toString());

    }
    
    public ActionForward getPartWarnJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	JSONObject json = new JSONObject();
    	SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");
  		Date sysDate = new Date();
  		Calendar date = Calendar.getInstance();
  		date.setTime(sysDate);
  		date.set(Calendar.DATE, date.get(Calendar.DATE) - 3);
  		String beginDate = dft.format(date.getTime());
  		String endDate = dft.format(sysDate);
  		//更换预警
        JSONObject json1 = new JSONObject();
        List<PartInfoTree> list = this.getService().getNextReplaceByDate(beginDate,endDate);
        List<Map<String,Object>> packageData = new ArrayList<Map<String,Object>>();
        Integer partNum = 0;
        if(list != null && !list.isEmpty()){
        	for(PartInfoTree part : list){
        		if(part != null){
        			Map<String,Object> map = this.packPart(part);
        			if(map != null && !map.isEmpty()){
        				packageData.add(map);
        				partNum++;
        			}
        		}
        	}
        }
        json1.put("PART",partNum);
        json1.put("PARTINFO",packageData);
        json.put("GH",json1);
        json.put("result",true);
        return this.renderJson(response, json);
    }
    
    private Map<String,Object> packPart(PartInfoTree part){
    	Map<String,Object> map = null;
    	EquipmentDetailsService equipmentDetailsService = AppContext.getServiceFactory().getService("equipmentDetailsService");
    	PartInfoService partInfoService = AppContext.getServiceFactory().getService("partInfoService");
    	EquipmentDetails equipmentDetails = null;
    	PartInfo partInfo = null;
    	if(part.getParent() != null && part.getParent().getEquipmentId() != null)
    		equipmentDetails = equipmentDetailsService.load(part.getParent().getEquipmentId());
    	if(part.getPartId() != null)
    		partInfo = partInfoService.load(part.getPartId());
    	if(partInfo != null && equipmentDetails != null){
    		map = new HashMap<String, Object>();
    		map.put("equipmentId", equipmentDetails.getId());
    		map.put("equipmentName", equipmentDetails.getEquipmentName());
    		map.put("partId", partInfo.getId());
    		map.put("partName", partInfo.getPartName());
    		map.put("pathName", equipmentDetails.getEquipmentName() + ">>" + partInfo.getPartName());
    		map.put("parentId", part.getParent().getId());
    	}
    	return map;
    }
    
    public ActionForward partDisplay(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
	throws Exception {
    	try
        {
          beforeDisplay(request, form);
          ActionUtils.forwardViewType(request);

          String btnIDs = getViewToolbarBtns(request, form);
          if (!StringUtils.isNullString(btnIDs))
            ActionUtils.setBtnToRequest(request, btnIDs);
          else {
            ActionUtils.clearBtnFromRequest(request);
          }

          String columns = getDisplayColumns(request, form);
          if (!StringUtils.isNullString(columns))
            ActionUtils.setColumnsToRequest(request, columns);
          else {
            ActionUtils.clearColumnFromRequest(request);
          }

          String viewForwardName = getViewForwardName(request, form);
          if (StringUtils.isNullString(viewForwardName)) {
            viewForwardName = getDefaultViewForwardName();
          }

          if (this.logger.isDebugEnabled())
            this.logger.debug("displayAction forward to " + viewForwardName);
          return mapping.findForward("partDisplay");
        } catch (Exception e) {
          this.logger.error(e.getMessage(), e);
          return renderException(mapping, request, e);
        }
    }
    
    public ActionForward customCreate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
	throws Exception {
    	Long equipmentId = RequestUtils.getLongParameter("equipmentId", -1);
    	if(equipmentId != -1){
    		EquipmentDetails equipmentDetails = equipmentDetailsService.load(equipmentId);
    		if(equipmentDetails != null){
    			request.setAttribute("equipmentDetails", equipmentDetails);
    		}
    		DataDict equipmentDict = DataDictHelper.getDataDict("SBFD", equipmentId+"");
			if(equipmentDict != null){
				Set<DataDict> sections = equipmentDict.getChilds();
				request.setAttribute("sections", sections);
			}
    	}
    	return mapping.findForward("customCreate");
    }
    
    public ActionForward ajaxSave(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response){
    	JSONObject json = new JSONObject();
    	Long equipmentId = RequestUtils.getLongParameter("equipmentId", -1);
    	Long partId = RequestUtils.getLongParameter("partId", -1);
    	if(equipmentId == -1 || partId == -1){
    		json.put("result",false);
    		json.put("msg","参数异常");
    		return this.renderJson(response, json);
    	}
    	EquipmentDetails equipmentDetails = equipmentDetailsService.load(equipmentId);
    	PartInfo partInfo = partInfoService.load(partId);
    	if(equipmentDetails == null || partInfo == null){
    		json.put("result",false);
    		json.put("msg","对象未找到");
    		return this.renderJson(response, json);
    	}
    	String isExclusive = request.getParameter("isExclusive");
    	Integer isExclusiveNum = StringUtils.isNullString(isExclusive)?0:Integer.parseInt(isExclusive);
    	String qty = request.getParameter("qty");
    	Integer qtyNum = StringUtils.isNullString(qty)?0:Integer.parseInt(qty);
    	String usePeriod = request.getParameter("usePeriod");
    	Integer usePeriodNum = StringUtils.isNullString(usePeriod)?0:Integer.parseInt(usePeriod);
    	String replaceDateStr = request.getParameter("replaceDate");
    	Date replaceDate = null;
    	if(!StringUtils.isNullString(replaceDateStr)){
    		replaceDate = DateUtils.getDate(replaceDateStr);
    	}
    	PartInfoTree parentTree = this.getService().loadByEquipmentId(equipmentId);
    	String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
    	Long org = null;
    	if(!StringUtils.isNullString(orgId))
    		org = Long.valueOf(orgId);
    	if(parentTree == null){
    		parentTree = new PartInfoTree();
    		parentTree.setOrganizationId(org);
    		parentTree.setEquipmentId(equipmentId);
    		parentTree.setIsExclusive(isExclusiveNum);
    		parentTree.setType(0);
    		parentTree.setUsePeriod(usePeriodNum);
    		parentTree.setReplaceDate(replaceDate);
    		parentTree.setNextReDate(this.getPartNextReDate(replaceDate, usePeriodNum));
    		this.getService().save(parentTree);
    	}
    	PartInfoTree partTree = new PartInfoTree();
    	partTree.setPartId(partId);
    	partTree.setParent(parentTree);
    	partTree.setOrganizationId(org);
    	partTree.setQty(qtyNum);
    	partTree.setIsExclusive(isExclusiveNum);
    	partTree.setType(1);
    	partTree.setUsePeriod(usePeriodNum);
    	partTree.setReplaceDate(replaceDate);
    	partTree.setNextReDate(this.getPartNextReDate(replaceDate, usePeriodNum));
		this.getService().save(partTree);
    	json.put("result",true);
        return this.renderJson(response, json);
    }
    
	private Date getPartNextReDate(Date replanceDate,Integer usePeriod){
		Calendar cl = Calendar.getInstance();  
        cl.setTime(replanceDate);  
        cl.add(Calendar.MONTH, usePeriod);  
        return cl.getTime(); 
	}
	
	@Override
	protected PartInfoTree getDomain(HttpServletRequest request, ActionForm form)
			throws Exception {
		// TODO Auto-generated method stub
		long id = this.getFileId(request);
		PartInfoTree domain = null;
		if (this.isBlankId(id)) {
			domain = this.createDomain(request, form);
		} else {
			domain = this.loadDomain(request, form, id);
		}
		BeanUtils.copyProperties(domain, form);
		Long parentId = RequestUtils.getLongParameter(request, "parent.id", -1);
		String section = request.getParameter("section");
		this.getService().synchroDataDict(parentId,section,dataDictService,equipmentDetailsService);
		return domain;
	}

    
    
}