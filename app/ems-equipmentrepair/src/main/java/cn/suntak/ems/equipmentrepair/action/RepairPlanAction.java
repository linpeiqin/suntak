package cn.suntak.ems.equipmentrepair.action;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.AppContext;
import cn.oz.UserContextHolder;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.json.JSONArray;
import cn.oz.json.JSONObject;
import cn.oz.util.BeanUtils;
import cn.oz.util.DateTimeUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.service.RepairPlanService;
import cn.suntak.ems.equipmentrepair.service.RepairRecordService;

/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RepairPlanAction extends EMSCRUDAction<RepairPlan, RepairPlanService> {
    private RepairRecordService repairRecordService;

    @Override
    public void initAction() {
        super.initAction();
        this.repairRecordService = this.getServiceBean("repairRecordService");
    }
    
    @Override
    protected void initForm(HttpServletRequest request, ActionForm form,
    		RepairPlan domain, boolean canEdit) {
    	// TODO Auto-generated method stub
    	request.setAttribute("maintenaceLevelSelect",DataDictHelper.findDataDicts("BYJB"));
    	request.setAttribute("intervalSelect", this.repairRecordService.getIntervalSelect());
    	request.setAttribute("projectName",this.repairRecordService.getProjectName());
    	Long id = RequestUtils.getLongParameter("id", -1);
    	Map<String,RepairPlanRule> map = new HashMap<String, RepairPlanRule>();
    	if(id != -1){
    		RepairPlan bean = this.getService().load(id);
    		if(bean != null){
    			List<RepairPlanRule> repairPlanRules = bean.getRepairPlanRules();
    			if(repairPlanRules != null && !repairPlanRules.isEmpty()){
    				for(RepairPlanRule rpr : repairPlanRules){
    					if(rpr != null)
    						map.put(rpr.getMaintenaceLevel(), rpr);
    				}
    			}
    		}
    	}
    	Long equipmentId = RequestUtils.getLongParameter("equipmentId", -1);
    	boolean barShow = RequestUtils.getBooleanParameter("barShow", true);
    	boolean selShow = true;
    	if(equipmentId != -1){
    		EquipmentDetailsService equipmentDetailsService = AppContext.getServiceFactory().getService("equipmentDetailsService");
    		domain.setEquipmentDetails(equipmentDetailsService.load(equipmentId));
    		selShow = false;
    	}
    	request.setAttribute("selShow",selShow);
    	request.setAttribute("barShow",barShow);
    	request.setAttribute("ruleMap",map);
    }

    @Override
    protected String getViewForwardName(HttpServletRequest request, ActionForm form) {
        return this.getDefaultViewForwardName() + ActionUtils.getViewType(request, "");
    }

    @Override
    protected void beforeDisplay(HttpServletRequest request, ActionForm form) throws Exception {
         request.setAttribute("RMType",RequestUtils.getStringParameter(request, "RMType", "other"));
         request.setAttribute("classify",RequestUtils.getStringParameter(request, "classify", "other"));
    }
    
    @Override
    protected void beforeOpen(HttpServletRequest request, ActionForm form)
    		throws Exception {
    	// TODO Auto-generated method stub
    	super.beforeOpen(request, form);
    	Long id = RequestUtils.getLongParameter("id", -1);
    	if(id != -1){
    		request.setAttribute("bean", this.getService().load(id));
    	}
    }

    @Override
    protected String getFormToolbarBtns(HttpServletRequest request, ActionForm form, RepairPlan domain, boolean canEdit) {
        if (!canEdit) {
            if (domain.getIsOff().equals(1)) {
                return "btnSeeMaintain";
            }
            return "btnEdit";
        }
        return "";
    }

    /**
     * 获取日程数据
     *
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public ActionForward getScheduleDatas(ActionMapping mapping, ActionForm form,
                                          HttpServletRequest request,
                                          HttpServletResponse response) throws Exception {
        try {
            Date startDate = DateTimeUtils.getDate(RequestUtils.getStringParameter(request, "startDate", null));
            Date endDate = DateTimeUtils.getDate(RequestUtils.getStringParameter(request, "endDate", null));
            JSONArray scheduleJsonArray = new JSONArray();
            List<RepairPlanTime> repairPlanTimes = this.getService().findDateScap(startDate, endDate);
            Map<String, List<RepairPlanTime>> repairPlanInfos = new HashMap<String, List<RepairPlanTime>>();
            if (null != repairPlanTimes && repairPlanTimes.size() > 0) {
                Calendar startCalendar = Calendar.getInstance();
                startCalendar.setTime(DateTimeUtils.getStartDate(startDate));
                while ((startCalendar.getTime()).before(endDate) || DateTimeUtils.isSameDay(startCalendar.getTime(), endDate)) {
                    String date = "d" + DateTimeUtils.formatDateTime(startCalendar.getTime(), "yyyyMMdd");
                    repairPlanInfos.put(date, this.getRepairPlansInfos(repairPlanTimes, startCalendar.getTime()));
                    startCalendar.add(Calendar.DATE, 1);
                }

                for (String date : repairPlanInfos.keySet()) {
                    List<RepairPlanTime> tmpRepairPlanInfos = repairPlanInfos.get(date);
                    if (null == tmpRepairPlanInfos || tmpRepairPlanInfos.isEmpty())
                        continue;

                    // 进行排序
                    Collections.sort(tmpRepairPlanInfos, new RepairPlanComparator());

                    JSONArray infos = new JSONArray();
                    for (RepairPlanTime info : tmpRepairPlanInfos) {
                        JSONObject json = new JSONObject();
                        json.put("equipmentName", info.getRepairPlanRule().getRepairPlan().getEquipmentDetails().getEquipmentName());
                        json.put("level", info.getRepairPlanRule().getMaintenaceLevel());
                        json.put("actualDate", info.getActualDate());
                        json.put("planDate", info.getPlanDate());
                        json.put("status", info.getStatus());
                        json.put("id", info.getRepairPlanRule().getRepairPlan().getId());
                        infos.put(json);
                    }

                    JSONObject dateJson = new JSONObject();
                    dateJson.put("date", date);
                    dateJson.put("schedules", infos);
                    scheduleJsonArray.put(dateJson);
                }
            }
            return renderJson(response, scheduleJsonArray.toString());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return renderExceptionWithAjax(response, e);
        }
    }

    private List<RepairPlanTime> getRepairPlansInfos(List<RepairPlanTime> repairPlanTimes, Date time) {
        List<RepairPlanTime> reRepairPlanTimes = new ArrayList<RepairPlanTime>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String timeStr = sdf.format(time);
        for (RepairPlanTime repairPlanTime : repairPlanTimes) {
            String actualDate = sdf.format(repairPlanTime.getActualDate());
            if (actualDate.equals(timeStr)) {
                reRepairPlanTimes.add(repairPlanTime);
            }
        }
        return reRepairPlanTimes;
    }

    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
        String classify = RequestUtils.getStringParameter(request, "classify", "other");
//        String viewType = RequestUtils.getStringParameter(request, "viewType", "other");
//        if (viewType.equals("other"))
            this.getService().getPage(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request), equipmentId,classify);
//        else
//            this.getService().getSViewPage(page, equipmentId);
    }

    @Override
    protected void save(HttpServletRequest request, ActionForm form, RepairPlan domain) throws Exception {
        domain.setCreatedDate(new Date());
        domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        
        this.getService().save(domain);
    }
    
    @Override
    protected RepairPlan getDomain(HttpServletRequest request, ActionForm form)
    		throws Exception {
    	// TODO Auto-generated method stub
    	Long equipmentId = RequestUtils.getLongParameter("equipmentDetails.id", -1);
    	long id = this.getFileId(request);
    	this.validate(equipmentId,id);        //后台验证
    	RepairPlan domain = null;
        if(this.isBlankId(id)) {
            domain = this.createDomain(request, form);
            this.getService().newOrEdit(request,domain,false);
        } else {
            domain = this.loadDomain(request, form, id);
            this.getService().newOrEdit(request,domain,true);
        }
        BeanUtils.copyProperties(domain, form);
        return domain;
    }

    private void validate(Long equipmentId,Long id) throws Exception {
		// TODO Auto-generated method stub
		if(equipmentId == -1){
			throw new Exception("未选择设备！");
		}else{
			if(this.isBlankId(id)){
				RepairPlan bean = this.getService().loadByEquipment(equipmentId, "MAINTAIN");
				if(bean != null){
					throw new Exception("重复保养记录！");
				}
			}
		}
	}

	public ActionForward show(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("showRepairPlan");
    }

    @Override
    protected void afterCreate(HttpServletRequest request, ActionForm form, RepairPlan domain) throws Exception {
        String RMType = RequestUtils.getStringParameter(request, "RMType", "REPAIR");
        domain.setType(RMType);
    }

    private class RepairPlanComparator implements Comparator<RepairPlanTime> {
        @Override
        public int compare(RepairPlanTime ps1, RepairPlanTime ps2) {
            return ps1.getActualDate().compareTo(ps2.getActualDate());
        }
    }
    
    public ActionForward getRMPlanJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject json = new JSONObject();
        //超期未执行
        JSONObject json1 = new JSONObject();
        json1.put("MAINTAIN",this.getService().findDateScapNum("OE","MAINTAIN"));
        json.put("OE",json1);
        //今日到期
        JSONObject json2 = new JSONObject();
        json2.put("MAINTAIN",this.getService().findDateScapNum("MT","MAINTAIN"));
        json.put("MT",json2);
        //明日到期
        JSONObject json3 = new JSONObject();
        json3.put("MAINTAIN",this.getService().findDateScapNum("DT","MAINTAIN"));
        json.put("DT",json3);
        //本月计划
        JSONObject json4 = new JSONObject();
        json4.put("MAINTAIN",this.getService().findDateScapNum("PM","MAINTAIN"));
        json.put("PM",json4);
        json.put("result",true);
        return this.renderJson(response, json);
    }
    
    public ActionForward checkExist(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		Long equipmentId = RequestUtils.getLongParameter("equipmentId", -1);
		String type = request.getParameter("type");
		if(equipmentId != -1){
			RepairPlan bean = this.getService().loadByEquipment(equipmentId,type);
			if(bean != null){
				json.put("result", true);
				json.put("id", bean.getId());
				json.put("msg", "");
			}else{
				json.put("result", false);
				json.put("msg", "");
			}
		}else{
			json.put("result", false);
			json.put("msg", "参数异常！");
		}
		return this.renderJson(response, json);
	}

    public ActionForward displayTime(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("planId",RequestUtils.getStringParameter(request, "planId", "-1"));
        boolean barShow = RequestUtils.getBooleanParameter("barShow", true);
        request.setAttribute("barShow", barShow);
        return mapping.findForward("viewRepairPlanTime");
    }

    public ActionForward pageTime(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long planId = RequestUtils.getLongParameter(request, "planId", -1);
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1);
        if (planId==-1 && equipmentId!=-1){
            RepairPlan repairPlan= this.getService().loadByEquipment(equipmentId, "MAINTAIN");
            if (repairPlan!=null)
                planId = repairPlan.getId();
        }
        Page page = ActionUtils.getPage(request);
        this.getService().getPageTime(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request),planId);
        page.setJsoner(this.getJsoner(request, form));
        String pageJson = ActionUtils.renderJsonPage(page, page.getJsoner());
        return this.renderJson(response, pageJson);
    }
    
    public ActionForward checkData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1);
		RepairPlan bean = null;
		boolean isExt = false;
		Long planId = -1l;
		if(equipmentId != -1){
			bean = this.getService().loadByEquipment(equipmentId, "MAINTAIN");
			if(bean != null){
				isExt = true;
				planId = bean.getId();
			}
		}
		json.put("isExt", isExt);
		json.put("planId", planId);
		return this.renderJson(response, json.toJSONString());
	}
    
    public ActionForward createPlanTimeByYear(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		JSONObject json = new JSONObject();
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		String year = request.getParameter("year");
		this.getService().setPlanTimeByYear(year,orgId);
		json.put("flag", true);
		return this.renderJson(response, json.toJSONString());
	}


}