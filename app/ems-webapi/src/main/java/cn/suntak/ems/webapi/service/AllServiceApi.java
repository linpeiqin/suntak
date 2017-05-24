/**
 * Copyright (c) 2010 - OZ Wizards Group.
 * <p>
 * All rights reserved.
 * <p>
 * BulletinService.java
 * Created on 202016/10/15 11:01 
 */
package cn.suntak.ems.webapi.service;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;
import cn.suntak.ems.intofactoryandcheck.domain.IntoFactoryAndCheck;
import cn.suntak.ems.intofactoryandcheck.service.IntoFactoryAndCheckService;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;
import cn.suntak.ems.renewalandcheck.service.RenewalAndCheckService;
import cn.suntak.ems.webapi.request.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

import cn.oz.config.domain.DataDict;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.org.json.JSONException;
import cn.oz.zop.constants.IgnoreSignType;
import cn.oz.zop.constants.NeedInSessionType;
import cn.oz.zop.server.annotation.ServiceMethod;
import cn.oz.zop.server.annotation.ServiceMethodBean;
import cn.suntak.ems.completion.domain.Completion;
import cn.suntak.ems.completion.service.CompletionService;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;
import cn.suntak.ems.completioncheck.service.CompletionCheckService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.internaltransfer.domain.InternalTransfer;
import cn.suntak.ems.internaltransfer.service.InternalTransferService;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.intofactory.service.IntoFactoryService;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;
import cn.suntak.ems.intofactorycheck.service.IntoFactoryCheckService;
import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.renewal.service.RenewalService;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;
import cn.suntak.ems.renewalcheck.service.RenewalCheckService;
import cn.suntak.ems.scrap.domain.Scrap;
import cn.suntak.ems.scrap.service.ScrapService;
import cn.suntak.ems.sell.domain.Sell;
import cn.suntak.ems.sell.service.SellService;
import cn.suntak.ems.transdata.service.TransDataService;
import cn.suntak.ems.webapi.response.BaseResponse;
import cn.suntak.ems.webapi.response.ResultData;


/**
 * 公共的API
 *
 * @author linking
 * @version 5.2.1
 * @since 5.2.1
 */
@ServiceMethodBean
public class AllServiceApi {
    protected final Logger loger = LoggerFactory.getLogger(getClass());
    private EquipmentDetailsService equipmentDetailsService;
    private CompletionCheckService completionCheckService;
    private CompletionService completionService;
    private InternalTransferService  internalTransferService;
    private IntoFactoryCheckService intoFactoryCheckService;
    private IntoFactoryService   intoFactoryService;
    private RenewalCheckService renewalCheckService;
    private RenewalService renewalService;
    private ScrapService scrapService;
    private SellService sellService;
    private TransDataService transDataService;
    private EquipmentLifeCycleService equipmentLifeCycleService;
    private IntoFactoryAndCheckService intoFactoryAndCheckService;
    private RenewalAndCheckService renewalAndCheckService;
    /**
     * 设备或备件基础信息    linking
     *
     * @param request
     * @return
     */
    @ServiceMethod(method = "purchapser.doExecutiveBriefing", methodName = "获取执行简报信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doExecutiveBriefing(ExecutiveBriefingRequest request) {
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        try {
            List<EquipmentDetails> edl = request.getEDL();
            if (edl == null) {
                result.setResult(false);
                result.setMessage("设备详细信息不正确，请填写完整！");
                result.setStatus(ResultData.Status.PARAMEX.getStatus());
                return result;
            }
            try {
                this.equipmentDetailsService.save(edl);
            } catch (Exception e) {
                result.setResult(false);
                result.setMessage(e.getMessage());
                result.setStatus(ResultData.Status.PARAMEX.getStatus());
                return result;
            }
            result.setResult(true);
            result.setMessage("操作成功！");
            result.setStatus(ResultData.Status.SUCCESS.getStatus());
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        result.setResult(false);
        result.setMessage("请求信息异常，请填写正确的参数！");
        result.setStatus(ResultData.Status.PARAMEX.getStatus());
        return result;
    }

    @ServiceMethod(method = "purchapser.doRenewalContract", methodName = "获取更新改造合同", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doRenewalContract(RenewalContractRequest request) {
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        try {
            List<EquipmentDetails> edl = request.getEDL();
            if (edl == null) {
                result.setResult(false);
                result.setMessage("设备详细信息不正确，请填写完整！");
                result.setStatus(ResultData.Status.PARAMEX.getStatus());
                return result;
            }
            try {

                this.equipmentDetailsService.save(edl);
            } catch (Exception e) {
                result.setResult(false);
                result.setMessage(e.getMessage());
                result.setStatus(ResultData.Status.PARAMEX.getStatus());
                return result;
            }
            result.setResult(true);
            result.setMessage("操作成功！");
            result.setStatus(ResultData.Status.SUCCESS.getStatus());
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        result.setResult(false);
        result.setMessage("请求信息异常，请填写正确的参数！");
        result.setStatus(ResultData.Status.PARAMEX.getStatus());
        return result;
    }

    @ServiceMethod(method = "equipmentmanager.doCompletionCheck", methodName = "获取完工检验信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doCompletionCheck(CompletionCheckRequest request) {
    	CompletionCheck completionCheck = request.getCompletionCheck();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (completionCheck == null) {
            result.setResult(false);
            result.setMessage("完工检验信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            CompletionCheck entity = (CompletionCheck) this.equipmentLifeCycleService.getBeanByProcessIdAndType(completionCheck.getType(),completionCheck.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		
        		copyPropertiesIgnoreNull( entity,completionCheck);
        		completionCheck = entity;
        		completionCheck.setId(id);
        		completionCheck.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	completionCheck.getEquipmentLifeCycle().setOaType(2);
        	completionCheck.getEquipmentLifeCycle().setRemark(data.getName());
            this.completionCheckService.save(completionCheck);
            
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(completionCheck.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    @ServiceMethod(method = "equipmentmanager.doCompletion", methodName = "获取完工信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doCompletion(CompletionRequest request) {
    	Completion completion = request.getCompletion();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (completion == null) {
            result.setResult(false);
            result.setMessage("完工信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            Completion entity = (Completion) this.equipmentLifeCycleService.getBeanByProcessIdAndType(completion.getType(),completion.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull( entity,completion);
        		completion = entity;
        		completion.setId(id);
        		completion.setProcessState(2); 
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	completion.getEquipmentLifeCycle().setOaType(2);
        	completion.getEquipmentLifeCycle().setRemark(data.getName());
            this.completionService.save(completion);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(completion.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    
    @ServiceMethod(method = "equipmentmanager.doInternalTransfer", methodName = "获取内部转移信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doInternalTransfer(InternalTransferRequest request) {
    	InternalTransfer internalTransfer = request.getInternalTransfer();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (internalTransfer == null) {
            result.setResult(false);
            result.setMessage("内部转移信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            InternalTransfer entity = (InternalTransfer) this.equipmentLifeCycleService.getBeanByProcessIdAndType(internalTransfer.getType(),internalTransfer.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull( entity,internalTransfer);
        		internalTransfer = entity;
        		internalTransfer.setId(id);
        		internalTransfer.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	internalTransfer.getEquipmentLifeCycle().setOaType(2);
        	internalTransfer.getEquipmentLifeCycle().setRemark(data.getName());
            this.internalTransferService.save(internalTransfer);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(internalTransfer.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }

    @ServiceMethod(method = "equipmentmanager.doIntoFactory", methodName = "获取入厂信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doIntoFactory(IntoFactoryRequest request) {
    	IntoFactory intoFactory = request.getIntoFactory();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (intoFactory == null) {
            result.setResult(false);
            result.setMessage("入厂信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            IntoFactory entity = (IntoFactory) this.equipmentLifeCycleService.getBeanByProcessIdAndType(intoFactory.getType(),intoFactory.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull( entity,intoFactory);
        		intoFactory = entity;
        		intoFactory.setId(id);
        		intoFactory.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
            EquipmentLifeCycle equipmentLifeCycle = intoFactory.getEquipmentLifeCycle();
            equipmentLifeCycle.setOaType(2);
            equipmentLifeCycle.setRemark(data.getName());
            intoFactory.setEquipmentLifeCycle(equipmentLifeCycle);
            this.intoFactoryService.save(intoFactory);

        } catch (Exception e) {
        	e.printStackTrace();
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(intoFactory.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    @ServiceMethod(method = "equipmentmanager.doIntoFactoryCheck", methodName = "获取入厂检验信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doIntoFactoryCheck(IntoFactoryCheckRequest request) {
        	IntoFactoryCheck intoFactoryCheck = request.getIntoFactoryCheck();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (intoFactoryCheck == null) {
            result.setResult(false);
            result.setMessage("入厂检验信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            IntoFactoryCheck entity = (IntoFactoryCheck) this.equipmentLifeCycleService.getBeanByProcessIdAndType(intoFactoryCheck.getType(),intoFactoryCheck.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull( entity,intoFactoryCheck);
        		intoFactoryCheck = entity;
        		intoFactoryCheck.setId(id);
        		intoFactoryCheck.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	intoFactoryCheck.getEquipmentLifeCycle().setOaType(2);
        	intoFactoryCheck.getEquipmentLifeCycle().setRemark(data.getName());
            this.intoFactoryCheckService.save(intoFactoryCheck);

        } catch (Exception e) {
                result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(intoFactoryCheck.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }

    @ServiceMethod(method = "equipmentmanager.doIntoFactoryAndCheck", methodName = "获取入厂验收信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doIntoFactoryAndCheck(IntoFactoryAndCheckRequest request) {
        IntoFactoryAndCheck intoFactoryAndCheck = request.getIntoFactoryAndCheck();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (intoFactoryAndCheck == null) {
            result.setResult(false);
            result.setMessage("入厂验收信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            IntoFactoryAndCheck entity = (IntoFactoryAndCheck) this.equipmentLifeCycleService.getBeanByProcessIdAndType(intoFactoryAndCheck.getType(),intoFactoryAndCheck.getProcessId());
            if(entity!=null){
                Long id = entity.getId();
                copyPropertiesIgnoreNull( entity,intoFactoryAndCheck);
                intoFactoryAndCheck = entity;
                intoFactoryAndCheck.setId(id);
                intoFactoryAndCheck.setProcessState(2);
            }
            DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
            intoFactoryAndCheck.getEquipmentLifeCycle().setOaType(2);
            intoFactoryAndCheck.getEquipmentLifeCycle().setRemark(data.getName());
            this.intoFactoryAndCheckService.save(intoFactoryAndCheck);

        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(intoFactoryAndCheck.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }

    @ServiceMethod(method = "equipmentmanager.doRenewalCheck", methodName = "获取更新改造检验信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doRenewalCheck(RenewalCheckRequest request) {
    	RenewalCheck renewalCheck = request.getRenewalCheck();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (renewalCheck == null) {
            result.setResult(false);
            result.setMessage("更新改造检验信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            RenewalCheck entity = (RenewalCheck) this.equipmentLifeCycleService.getBeanByProcessIdAndType(renewalCheck.getType(),renewalCheck.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull(entity, renewalCheck);
        		renewalCheck = entity;
        		renewalCheck.setId(id);
        		renewalCheck.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	renewalCheck.getEquipmentLifeCycle().setOaType(2);
        	renewalCheck.getEquipmentLifeCycle().setRemark(data.getName());
            Set<EquipmentDetails> equipmentDetailses = renewalCheck.getEquipmentLifeCycle().getEquipmentDetails();
            for(EquipmentDetails eq :equipmentDetailses){
                eq.setType(2);
            }
            this.renewalCheckService.save(renewalCheck);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(renewalCheck.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }

    @ServiceMethod(method = "equipmentmanager.doRenewalAndCheck", methodName = "获取更新改造检验信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doRenewalAndCheck(RenewalAndCheckRequest request) {
        RenewalAndCheck renewalAndCheck = request.getRenewalAndCheck();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (renewalAndCheck == null) {
            result.setResult(false);
            result.setMessage("更新改造检验信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            RenewalAndCheck entity = (RenewalAndCheck) this.equipmentLifeCycleService.getBeanByProcessIdAndType(renewalAndCheck.getType(),renewalAndCheck.getProcessId());
            if(entity!=null){
                Long id = entity.getId();
                copyPropertiesIgnoreNull(entity, renewalAndCheck);
                renewalAndCheck = entity;
                renewalAndCheck.setId(id);
                renewalAndCheck.setProcessState(2);
            }
            DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
            renewalAndCheck.getEquipmentLifeCycle().setOaType(2);
            renewalAndCheck.getEquipmentLifeCycle().setRemark(data.getName());
            Set<EquipmentDetails> equipmentDetailses = renewalAndCheck.getEquipmentLifeCycle().getEquipmentDetails();
            for(EquipmentDetails eq :equipmentDetailses){
                eq.setType(2);
            }
            this.renewalAndCheckService.save(renewalAndCheck);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(renewalAndCheck.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    @ServiceMethod(method = "equipmentmanager.doRenewal", methodName = "获取更新改造信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doRenewal(RenewalRequest request) {
    	Renewal renewal = request.getRenewal();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (renewal == null) {
            result.setResult(false);
            result.setMessage("更新改造信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            Renewal entity = (Renewal) this.equipmentLifeCycleService.getBeanByProcessIdAndType(renewal.getType(),renewal.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();

        		copyPropertiesIgnoreNull(entity, renewal);
        		renewal = entity;
        		renewal.setId(id);
        		renewal.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	renewal.getEquipmentLifeCycle().setOaType(2);
        	renewal.getEquipmentLifeCycle().setRemark(data.getName());
            this.renewalService.save(renewal);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(renewal.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    @ServiceMethod(method = "equipmentmanager.doScrap", methodName = "获取报废信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doScrap(ScrapRequest request) {
    	Scrap scrap = request.getScrap();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (scrap == null) {
            result.setResult(false);
            result.setMessage("报废信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            Scrap entity = (Scrap) this.equipmentLifeCycleService.getBeanByProcessIdAndType(scrap.getType(),scrap.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
                String fixedAssetsName = entity.getFixedAssetsName();//OA bug，暂时在系统维护
        		copyPropertiesIgnoreNull(entity, scrap);
        		scrap = entity;
                scrap.setFixedAssetsName(fixedAssetsName);
        		scrap.setId(id);
        		scrap.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	scrap.getEquipmentLifeCycle().setOaType(2);
        	scrap.getEquipmentLifeCycle().setRemark(data.getName());
            this.scrapService.save(scrap);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(scrap.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    @ServiceMethod(method = "equipmentmanager.doSell", methodName = "获取出售信息", version = "1.0", needInSession = NeedInSessionType.NO, ignoreSign = IgnoreSignType.YES)
    public Object doSell(SellRequest request) {
    	Sell sell = request.getSell();
        ResultData<BaseResponse> result = new ResultData<BaseResponse>();
        if (sell == null) {
            result.setResult(false);
            result.setMessage("出售信息为空，请填写完整！");
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        try {
            Sell entity = (Sell) this.equipmentLifeCycleService.getBeanByProcessIdAndType(sell.getType(),sell.getProcessId());
        	if(entity!=null){
        		Long id = entity.getId();
        		copyPropertiesIgnoreNull( entity,sell);
        		sell = entity;
        		sell.setId(id);
        		sell.setProcessState(2);
        	}
        	DataDict data = DataDictHelper.getDataDict("OASPZT", "2");
        	sell.getEquipmentLifeCycle().setOaType(2);
        	sell.getEquipmentLifeCycle().setRemark(data.getName());
            this.sellService.save(sell);
        } catch (Exception e) {
            result.setResult(false);
            result.setMessage(e.getMessage());
            result.setStatus(ResultData.Status.PARAMEX.getStatus());
            return result;
        }
        BaseResponse br = new BaseResponse();
        br.setFormId(sell.getId());
        result.setData(br);
        result.setResult(true);
        result.setMessage("操作成功！");
        result.setStatus(ResultData.Status.SUCCESS.getStatus());
        return result;
    }
    public EquipmentDetailsService getEquipmentDetailsService() {
        return equipmentDetailsService;
    }

    public void setEquipmentDetailsService(EquipmentDetailsService equipmentDetailsService) {
        this.equipmentDetailsService = equipmentDetailsService;
    }


	public CompletionCheckService getCompletionCheckService() {
		return completionCheckService;
	}

	public void setCompletionCheckService(
			CompletionCheckService completionCheckService) {
		this.completionCheckService = completionCheckService;
	}

	public CompletionService getCompletionService() {
		return completionService;
	}

	public void setCompletionService(CompletionService completionService) {
		this.completionService = completionService;
	}

	public InternalTransferService getInternalTransferService() {
		return internalTransferService;
	}

	public void setInternalTransferService(
			InternalTransferService internalTransferService) {
		this.internalTransferService = internalTransferService;
	}

	public IntoFactoryCheckService getIntoFactoryCheckService() {
		return intoFactoryCheckService;
	}

	public void setIntoFactoryCheckService(
			IntoFactoryCheckService intoFactoryCheckService) {
		this.intoFactoryCheckService = intoFactoryCheckService;
	}

	public IntoFactoryService getIntoFactoryService() {
		return intoFactoryService;
	}

	public void setIntoFactoryService(IntoFactoryService intoFactoryService) {
		this.intoFactoryService = intoFactoryService;
	}

	public RenewalCheckService getRenewalCheckService() {
		return renewalCheckService;
	}

	public void setRenewalCheckService(RenewalCheckService renewalCheckService) {
		this.renewalCheckService = renewalCheckService;
	}

	public RenewalService getRenewalService() {
		return renewalService;
	}

	public void setRenewalService(RenewalService renewalService) {
		this.renewalService = renewalService;
	}

	public ScrapService getScrapService() {
		return scrapService;
	}

	public void setScrapService(ScrapService scrapService) {
		this.scrapService = scrapService;
	}

	public SellService getSellService() {
		return sellService;
	}

	public void setSellService(SellService sellService) {
		this.sellService = sellService;
	}
    
	public static String[] getNullPropertyNames (Object source) {
        final BeanWrapper src = new BeanWrapperImpl(source);
        java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();

        Set<String> emptyNames = new HashSet<String>();
        for(java.beans.PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) emptyNames.add(pd.getName());
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }

    public static void copyPropertiesIgnoreNull(Object target, Object src){
    	 org.springframework.beans.BeanUtils.copyProperties(src, target, getNullPropertyNames(src));
    }

	public void setTransDataService(TransDataService transDataService) {
		this.transDataService = transDataService;
	}

	public TransDataService getTransDataService() {
		return transDataService;
	}

    public EquipmentLifeCycleService getEquipmentLifeCycleService() {
        return equipmentLifeCycleService;
    }

    public void setEquipmentLifeCycleService(EquipmentLifeCycleService equipmentLifeCycleService) {
        this.equipmentLifeCycleService = equipmentLifeCycleService;
    }

    public IntoFactoryAndCheckService getIntoFactoryAndCheckService() {
        return intoFactoryAndCheckService;
    }

    public void setIntoFactoryAndCheckService(IntoFactoryAndCheckService intoFactoryAndCheckService) {
        this.intoFactoryAndCheckService = intoFactoryAndCheckService;
    }

    public RenewalAndCheckService getRenewalAndCheckService() {
        return renewalAndCheckService;
    }

    public void setRenewalAndCheckService(RenewalAndCheckService renewalAndCheckService) {
        this.renewalAndCheckService = renewalAndCheckService;
    }
}
