package cn.suntak.ems.equipmentrepair.action;


import java.lang.reflect.Field;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.organize.UserInfo;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentrepair.service.MaintainService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.config.service.DataDictService;
import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONException;
import cn.oz.util.BeanUtils;
import cn.oz.util.DateTimeUtils;
import cn.oz.util.StringUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;
import cn.suntak.ems.equipmentrepair.service.PartReplaceService;
import cn.suntak.ems.equipmentrepair.service.RepairRecordService;
import cn.suntak.ems.filenumber.service.FileNumberService;
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
public class RepairRecordAction extends EMSCRUDAction<RepairRecord, RepairRecordService>{
	private final static String permissionmaintenance = "EMS_DM_MAINTENANCE_OPERATION";
	private final static String permissionDistributor = "EMS_DM_DISTRIBUT_OPERATION";
	private final static String permissionRepair = "EMS_DM_REPAIRED_OPERATION";
	private PartReplaceService partReplaceService;
	private RepairRecordService  repairRecordService;
	private FileNumberService fileNumberService;
	private PartInfoTreeService partInfoTreeService;
	private PartInfoService partInfoService;
	private MaintainService maintainService;
	private DataDictService dataDictService;
	private EquipmentDetailsService equipmentDetailsService;

	public void initAction() {
	        super.initAction();
			this.partReplaceService = this.getServiceBean("partReplaceService");
			this.repairRecordService = this.getServiceBean("repairRecordService");
			this.fileNumberService = this.getServiceBean("fileNumberService");
			this.partInfoTreeService = this.getServiceBean("partInfoTreeService");
			this.partInfoService = this.getServiceBean("partInfoService");
			this.maintainService = this.getServiceBean("maintainService");
			this.dataDictService = this.getServiceBean("dataDictService");
			this.equipmentDetailsService = this.getServiceBean("equipmentDetailsService");
	    }

	private Boolean hasPermission(String permission){
		return UserContextHolder.getCurUser().hasPermission(permission);
	}
	@Override
	protected void initForm(HttpServletRequest request, ActionForm form,
			RepairRecord domain, boolean canEdit) {
		// TODO Auto-generated method stub
		request.setAttribute("faultClassSelect",this.repairRecordService.getFaultClass());
		request.setAttribute("eDegreeSelect",this.repairRecordService.geteDegree());
		request.setAttribute("maintenaceLevelSelect",this.repairRecordService.getMaintenaceLevel());
		request.setAttribute("isMaintenancer",this.hasPermission(permissionmaintenance));
		request.setAttribute("isDistributor",this.hasPermission(permissionDistributor));
		request.setAttribute("isRepair",this.hasPermission(permissionRepair));
		if(domain.getStatus().equals(0) && this.hasPermission(permissionDistributor)){
			domain.setDistributor(UserContextHolder.getCurFileAuthor());
		}
		super.initForm(request, form, domain, canEdit);
	}
	public ActionForward show(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("showRepairRecord");
	}
	@Override
	protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, RepairRecord domain, JSONObject json) throws Exception {
		json.put("maintenanceNo",domain.getMaintenanceNo());
	}

	@Override
	protected String getViewToolbarBtns(HttpServletRequest request, ActionForm form) {
		Boolean isMaintenancer = this.hasPermission(permissionmaintenance);
		if (isMaintenancer){
			return "btnBack,btnDelete,btnNew,btnRefresh";
		}
		return "none"/*btnBack,btnDelete,btnNew,btnRefresh*/;
	}

	@Override
	protected String getFormToolbarBtns(HttpServletRequest request, ActionForm form, RepairRecord domain, boolean canEdit) {
		if (canEdit){
			Boolean isMaintenancer = this.hasPermission(permissionmaintenance);
			Boolean isDistributor =  this.hasPermission(permissionDistributor);
			Boolean isRepair =  this.hasPermission(permissionRepair);
			if (isMaintenancer){
				if (domain.getStatus().equals(-1))
					return "btnSave,btnSelectEquipment,btnUpdateRepair";
				if (domain.getStatus().equals(2)){
					return "btnSave,btnUpdateRepair";
				}
			}
			if (isDistributor && domain.getStatus().equals(0)){
				return "btnSave,btnDistribution,btnUpdateRepair";
			}
			if (isRepair){
				if (domain.getStatus().equals(1))
					return "btnSave,btnUpdateRepair";
				if (domain.getStatus().equals(-1))
					return "btnSave,btnSelectEquipment,btnUpdateRepair";
			}
			return "none";
		}
		return "none"/*btnSave,btnSelectEquipment,btnUpdateRepair,btnDistribution*/;
	}

	@Override
	protected boolean openOrEdit(HttpServletRequest request, ActionForm form, RepairRecord domain) throws Exception {
		if (domain.getStatus() == RepairRecord.ALREADY_CLOSED){
			return false;
		}
		return true;
	}

	@Override
	protected void beforeDisplay(HttpServletRequest request, ActionForm form) throws Exception {
		request.setAttribute("classify",RequestUtils.getStringParameter(request, "classify", "other"));
	}

	@Override
	protected void save(HttpServletRequest request, ActionForm form, RepairRecord domain) throws Exception {
		if (domain.getMaintenanceNo()==null || domain.getMaintenanceNo().equals("")) {
			String maintenanceNo = this.fileNumberService.doCreateNumber("WXDH");
			domain.setMaintenanceNo(maintenanceNo);
		}
		super.save(request, form, domain);
	}

	public ActionForward page4User(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
			Page page = ActionUtils.getPage(request);
		    String groupCode = RequestUtils.getStringParameter(request, "groupCode", "WXG");
			List<UserInfo>  userInfos = this.getService().findAllByCode(groupCode);
			page.setFileList(userInfos);
			page.setPageSize(10);
			page.setJsoner(this.getJsoner(request, form));
			String pageJson = ActionUtils.renderJsonPage(page, page.getJsoner());
			return this.renderJson(response, pageJson);
	}

	@Override
	protected void getPageData(HttpServletRequest request, Page page) throws Exception {
		Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
		String classify = RequestUtils.getStringParameter(request, "classify", "other");
		String viewType = RequestUtils.getStringParameter(request, "viewType", "other");
		if (viewType.equals("other"))
			this.getService().getPage(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request), equipmentId,classify);
		else
			this.getService().getSViewPage(page, equipmentId);
	}
	public ActionForward getPartReplaceJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		long id = this.getFileId(request);
		RepairRecord repairRecord = this.getService().load(id);
		if (repairRecord==null){
			return null;
		}
		JSONObject json = null;
		if(repairRecord.getPartReplaces() != null && !repairRecord.getPartReplaces().isEmpty()){     //优先读取有更换记录的
			json = getPartReplaceJson(repairRecord.getPartReplaces(),null);
		}else{                                             //无更记录的从配件关系树中初始化
			PartInfoTree parentTree = partInfoTreeService.loadByEquipmentId(repairRecord.getEquipmentDetails().getId());
			if(parentTree != null){
				List<PartInfoTree> partTrees = partInfoTreeService.findByParent(parentTree.getId());
				json = getPartReplaceJson(null,partTrees);
			}
		}
		if(json == null){
			json = new JSONObject();
			json.put("total", 0);
			json.put("rows", new cn.oz.json.JSONArray());
		}
		return this.renderJson(response, json);
	}

	public ActionForward updateStatus(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = RequestUtils.getLongParameter(request, "id", -1L);
		Integer status = RequestUtils.getIntParameter(request, "status", -1);
		JSONObject json = new JSONObject();
		Boolean flag = this.getService().updateStatus(id,status);
		RepairRecord bean = this.getService().load(id);
		json.put("flag",flag);
		if(flag){
			json.put("msg","提交成功"); 
			if(status == RepairRecord.BEEN_REPAIRED) {           //已维修后更新配件关系树
				this.updatePartTree(bean.getEquipmentDetails().getId(), bean.getPartReplaces());    //更新配件关系树
				this.getService().createOrderHeadTemp(bean);//创建领用出库
			}
			return this.renderJson(response, json);
		}
		json.put("msg","提交失败");
		return this.renderJson(response, json);
	}


	public ActionForward getPartReplaceJsonV(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
		Long partId = RequestUtils.getLongParameter(request,"partId",-1L);
		Set<PartReplace> partReplaces = null;
		if (equipmentId!=-1L){
			partReplaces = this.partReplaceService.loadByEquipmentId(equipmentId);
		}
		if (partId!=-1){
			partReplaces = this.partReplaceService.loadByPartId(partId);
		}
		JSONObject json  = getPartReplaceJson(partReplaces,null);
		return this.renderJson(response, json);
	}

	public ActionForward getRMRecordJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		//本月执行
		JSONObject json1 = new JSONObject();
		json1.put("REPAIR",this.getService().findDateScapNum("BY","REPAIR"));
		json1.put("MAINTAIN",this.maintainService.findDateScapNum("BY","MAINTAIN"));
		json.put("BY",json1);
		//上月执行
		JSONObject json2 = new JSONObject();
		json2.put("REPAIR",this.getService().findDateScapNum("SY","REPAIR"));
		json2.put("MAINTAIN",this.maintainService.findDateScapNum("SY","MAINTAIN"));
		json.put("SY",json2);
		json.put("result",true);
		return this.renderJson(response, json);
	}

	private JSONObject getPartReplaceJson(Set<PartReplace> partReplaces,List<PartInfoTree> partTrees){
		JSONObject json = new JSONObject();
		if(partReplaces!=null&&partReplaces.size()>0){
			json.put("total",partReplaces.size());
			cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
			for(PartReplace partReplace: partReplaces){
				JSONObject row = new JSONObject();
				Field[] fields = partReplace.getClass().getDeclaredFields();
				for(Field field :fields){
					field.setAccessible(true);
					if(field.getName().equals("lineTypeName"))
					{
						row.put(field.getName(), partReplace.getLineTypeName());
						continue;
					}
					try {
						row.put(field.getName(), field.get(partReplace));
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				}
				array.add(row);
			}
			json.put("rows", array);
		}else if(partTrees != null && !partTrees.isEmpty()){
			json.put("total",partTrees.size());
			cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
			PartInfo part = null;
            for(PartInfoTree partInfoTree: partTrees){
            	part = partInfoService.load(partInfoTree.getPartId());
            	if(part != null){
            		JSONObject row = new JSONObject();
	            	row.put("partName", part.getPartName());
	            	row.put("partNo", part.getPartNo());
	            	row.put("qty", partInfoTree.getQty());
	            	row.put("equipmentId", partInfoTree.getParent().getEquipmentId());
	            	row.put("organizationId", partInfoTree.getOrganizationId());
	            	row.put("partId", part.getId());
	            	row.put("price", part.getPrice());
					row.put("itemId", part.getItemId());
	            	row.put("section", partInfoTree.getSection());
	            	array.add(row);
            	}
			}
            json.put("rows", array);
		}else{
			json.put("total", 0);
			json.put("rows", new cn.oz.json.JSONArray());
			
		}
		return json;
	}
	@Override
	protected RepairRecord getDomain(HttpServletRequest request, ActionForm form) throws Exception {
		long id = this.getFileId(request);
		RepairRecord domain = null;
		if (this.isBlankId(id)) {
			domain = this.createDomain(request, form);
		} else {
			domain = this.loadDomain(request, form, id);
		}

		BeanUtils.copyProperties(domain, form);
		String partReplacesStr = RequestUtils.getStringParameter(request, "partReplace1", "");
		if (!partReplacesStr.equals("")) {
			JSONArray array = new JSONArray(partReplacesStr);
			Set<PartReplace> partReplaceSet = null;
			if (domain.getPartReplaces() == null) {
				partReplaceSet = new HashSet<PartReplace>();
			} else {
				partReplaceSet = domain.getPartReplaces();
				partReplaceSet.clear();
			}
			for (int i = 0; i < array.length(); i++) {
				PartReplace partReplace = new PartReplace();
				this.setPartReplaceInfo(partReplace, array.getJSONObject(i));
				partReplace.setEquipmentId(domain.getEquipmentDetails().getId());
				partReplace.setRepairRecord(domain);
				partReplaceSet.add(partReplace);
			}

			domain.setPartReplaces(partReplaceSet);
		}
		return domain;
	}

	private void updatePartTree(Long equipmentId, Set<PartReplace> partReplaceSet) {
		// TODO Auto-generated method stub
		if(equipmentId != null){
			PartInfoTree partTree = partInfoTreeService.loadByEquipmentId(equipmentId);
			if(partTree == null){        //此设备在设备关系树中没有配置这新建
				partTree = new PartInfoTree();
				partTree.setEquipmentId(equipmentId);
				partTree.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
				partTree.setIsExclusive(0);
				partTree.setType(0);
				partTree.setUsePeriod(1);
				Date now = new Date();
				partTree.setReplaceDate(now);
				partTree.setNextReDate(this.getPartNextReDate(now, 1));
			}else{
				Date now = new Date();
				partTree.setReplaceDate(now);
				partTree.setNextReDate(this.getPartNextReDate(now, partTree.getUsePeriod()));
			}
			Set<PartInfoTree> childs = partTree.getChilds();
			if(childs == null)
				childs = new HashSet<PartInfoTree>();
			this.updateChilds(childs,partReplaceSet,partTree);            //更新设备下的配件
			partInfoTreeService.save(partTree);
		}
	}
	
	private void updateChilds(Set<PartInfoTree> childs,
			Set<PartReplace> partReplaceSet,PartInfoTree parentTree) {
		// TODO Auto-generated method stub
		PartInfoTree partInfoTree = null;
		if(childs == null || childs.isEmpty()){                        //如果设备下没有自配件则将配件跟换记录全加入设备关系树
			if(partReplaceSet != null && !partReplaceSet.isEmpty()){
				for(PartReplace partReplace : partReplaceSet){
					partInfoTree = this.partReplaceToTree(partReplace, parentTree);
					if(partInfoTree != null){
						childs.add(this.partReplaceToTree(partReplace,parentTree));
						partInfoTreeService.synchroDataDict(parentTree.getId(), partReplace.getSection(), dataDictService, equipmentDetailsService);
					}
				}
			}
			parentTree.setChilds(childs);
		}else{         //如果设备下有配件则将新跟换的配件加入设备关系树
			for(PartReplace partReplace : partReplaceSet){
				boolean isExt = false;
				for(PartInfoTree partTree : childs){
					if(partReplace.getPartId().longValue() == partTree.getPartId().longValue()){
						if(StringUtils.isNullString(partTree.getSection())){  //如果关系树中段位为空   则更新
							partTree.setSection(partReplace.getSection());
							Date now = new Date();
							partTree.setReplaceDate(now);
							partTree.setNextReDate(this.getPartNextReDate(now, partTree.getUsePeriod()));
							partInfoTreeService.synchroDataDict(parentTree.getId(), partReplace.getSection(), dataDictService, equipmentDetailsService);
							isExt = true;
							break;
						}else{
							if(partTree.getSection().equals(partReplace.getSection())){
								isExt = true;
								break;
							}
						}
					}
				}
				if(!isExt){
					partInfoTree = this.partReplaceToTree(partReplace, parentTree);
					if(partInfoTree != null){
						childs.add(this.partReplaceToTree(partReplace,parentTree));
						partInfoTreeService.synchroDataDict(parentTree.getId(), partReplace.getSection(), dataDictService, equipmentDetailsService);
					}
				}
			}
		}
	}

	private PartInfoTree partReplaceToTree(PartReplace partReplace,PartInfoTree parentTree) {
		// TODO Auto-generated method stub
		PartInfoTree partInfoTree = null;
		if(partReplace != null){
			partInfoTree = new PartInfoTree();
			partInfoTree.setPartId(partReplace.getPartId());
			partInfoTree.setParent(parentTree);
			partInfoTree.setOrganizationId(parentTree.getOrganizationId());
			partInfoTree.setQty(partReplace.getQty());
			partInfoTree.setSection(partReplace.getSection());
			partInfoTree.setIsExclusive(0);
			partInfoTree.setType(1);
			partInfoTree.setUsePeriod(1);
			Date now = new Date();
			partInfoTree.setReplaceDate(now);
			partInfoTree.setNextReDate(this.getPartNextReDate(now, 1));
		}
		return partInfoTree;
	}

	private Date getPartNextReDate(Date replanceDate,Integer usePeriod){
		Calendar cl = Calendar.getInstance();  
        cl.setTime(replanceDate);  
        cl.add(Calendar.MONTH, usePeriod);  
        return cl.getTime(); 
	}

	private void setPartReplaceInfo(PartReplace partReplace, cn.oz.org.json.JSONObject obj) {
		JSONArray names = obj.names();
		for (int j = 0; j < names.length(); j++) {
			String fieldName = null;
			try {
				fieldName = names.get(j).toString();
				if (fieldName.equals("editing")) continue;
				if (fieldName.equals("repairRecord")) continue;
				if (fieldName.equals("UOMCode")) continue;
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
				field = partReplace.getClass().getDeclaredField(fieldName);
			} catch (SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchFieldException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (field != null) {
				Class<?> clas = field.getType();
				field.setAccessible(true);
				if (clas.toString().equals("class java.util.Date")) {
					try {
						field.set(partReplace, DateTimeUtils.getDate(fieldValue));
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
						field.set(partReplace, Integer.valueOf(fieldValue));
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
						field.set(partReplace, Long.valueOf(fieldValue));
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
						field.set(partReplace, Double.parseDouble(fieldValue));
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
					field.set(partReplace, fieldValue);
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

	public ActionForward HPEquipmentRepair(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("HPEquipmentRepair");
	}

	public ActionForward HPRepairRemind(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("HPRepairRemind");
	}

	public ActionForward GroupView(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("GroupView");
	}

	public ActionForward HPVEquipmentRepair(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String e = this.getViewToolbarBtns(request, form);
		if(!StringUtils.isNullString(e)) {
			ActionUtils.setBtnToRequest(request, e);
		} else {
			ActionUtils.clearBtnFromRequest(request);
		}
		return mapping.findForward("HPVEquipmentRepair");
	}
	
}