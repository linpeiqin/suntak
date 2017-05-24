package cn.suntak.ems.equipmentrepair.service.impl;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import cn.oz.AppContext;
import cn.oz.UserContextHolder;
import cn.oz.config.domain.DataDict;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.DateUtils;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.service.RepairPlanRuleService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RepairPlanServiceImpl extends CRUDServiceImpl< RepairPlan, Long,  RepairPlanDao> implements  RepairPlanService{

	private RepairPlanTimeService repairPlanTimeService;
	
	public void setRepairPlanTimeService(RepairPlanTimeService repairPlanTimeService) {
		this.repairPlanTimeService = repairPlanTimeService;
	}

	@Override
	public RepairPlan create() throws OzException {
		RepairPlan repairPlan = new RepairPlan();
		repairPlan.setCreatedDate(new Date());
		repairPlan.setIsOff(0);
		repairPlan.setType("MAINTAIN");
//		repairPlan.setIntervalUnit(2);
		return repairPlan;
	}


	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId, String classify) {
		this.simpleDao.getPage(page, dbftSearchParams, searchQuery, equipmentId,classify);
	}

	@Override
	public List<RepairPlanTime> findDateScap(Date startDate, Date endDate) {
		return this.simpleDao.findDateScap(startDate, endDate);
	}

	@Override
	public Integer findDateScapNum(String scap, String type) {
		return this.simpleDao.findDateScapNum(scap,type);

	}


	@Override
	public RepairPlan loadByEquipment(Long equipmentId,String type) {
		// TODO Auto-generated method stub
		return this.simpleDao.loadByEquipment(equipmentId,type);
	}


	@Override
	public void updateNextTime(Long equipmentId, String type) {
		// TODO Auto-generated method stub
		if(equipmentId != -1 && !StringUtils.isNullString(type)){
			RepairPlan bean = this.loadByEquipment(equipmentId, type);
			if(bean != null){
			    this.setDomainData(bean,new Date());
			    this.save(bean);
			}
		}
	}
	
	 private void setDomainData(RepairPlan bean,Date lastDate){
		
	 }


	@Override
	public List<RepairPlan> loadAll() {
		// TODO Auto-generated method stub
		return this.simpleDao.loadAll();
	}

	@Override
	public void getSViewPage(Page page, Long equipmentId) {
		this.simpleDao.getSViewPage( page,  equipmentId);
	}

	@Override
	public List<RepairPlanTime> findAllByPlanId(Long planId) {
		return this.simpleDao.findAllByPlanId( planId);
	}

	@Override
	public void getPageTime(Page page, String dbftSearchParams, SearchQuery searchQuery, Long planId) {
		this.simpleDao.getPageTime(page,dbftSearchParams,searchQuery,planId);
	}


	@Override
	public void setPlanTimeByYear(String year,String orgId) {
		// TODO Auto-generated method stub
		List<RepairPlan> repairPlans = loadAllByOrgId(orgId);
		if(repairPlans != null && !repairPlans.isEmpty()){
			RepairPlanTimeService repairPlanTimeService = AppContext.getServiceFactory().getService("repairPlanTimeService");
			for(RepairPlan repairPlan : repairPlans){
				if(repairPlan != null){
					List<RepairPlanRule> repairPlanRules = repairPlan.getRepairPlanRules();
					Integer startIndex = repairPlan.getStartIndex();
					if(repairPlanRules != null && !repairPlanRules.isEmpty()){
						repairPlanRules = orderByLevel(repairPlan.getRepairPlanRules(),0);
						for(RepairPlanRule rpr : repairPlanRules){
							if(rpr != null){
								boolean isExistByYear = repairPlanTimeService.isExistByRuleAndYear(rpr.getId(),year);
								if(!isExistByYear){      //不存在  则生成
									setPlanTime(rpr, startIndex, Integer.parseInt(year));
								}
								startIndex ++;
							}
						}
					}
					setPlanRuleAfter(repairPlanRules);
					repairPlan.setRepairPlanRules(repairPlanRules);
					this.save(repairPlan);
				}
			}
		}
	}
	
	private void setPlanRuleAfter(List<RepairPlanRule> repairPlanRules) {
		// TODO Auto-generated method stub
		if(repairPlanRules != null && !repairPlanRules.isEmpty()){
			List<String> planList = new ArrayList<String>();
			repairPlanRules = orderByLevel(repairPlanRules, 1);
			for(RepairPlanRule rule : repairPlanRules){
				List<RepairPlanTime> newRepairPlanTimes = new ArrayList<RepairPlanTime>();
				List<RepairPlanTime> repairPlanTimes = rule.getRepairPlanTimes();
				String planStr = null;
				if(repairPlanTimes != null && !repairPlanTimes.isEmpty()){
					for(RepairPlanTime rpt : repairPlanTimes){
						planStr = toPlanStr(rpt);
						if(!planList.contains(planStr)){
							planList.add(planStr);
							newRepairPlanTimes.add(rpt);
						}
					}
					rule.setRepairPlanTimes(newRepairPlanTimes);
				}
			}
			
		}
	}
	
	private String toPlanStr(RepairPlanTime repairPlanTime){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");  
		if(repairPlanTime != null){
			return format.format(repairPlanTime.getPlanDate());
		}
		return null;
	}


	private RepairPlanRule setPlanTime(RepairPlanRule repairPlanRule,Integer startIndex,Integer year){
		Integer dayNum = repairPlanRule.getDayNum();
		Integer interval = repairPlanRule.getInterval();
		List<RepairPlanTime> repairPlanTimes = repairPlanRule.getRepairPlanTimes();
		if(repairPlanTimes == null){
			repairPlanTimes = new ArrayList<RepairPlanTime>();
		}
		int initMon = startIndex;
		int fastMon = startIndex;
		Calendar now = Calendar.getInstance();
		int mon = initMon-1;
		int lastDay = this.getLastDayOfMonth(year,initMon);
		int initDay = dayNum>lastDay?lastDay:dayNum;
		now.set(year, mon, initDay);
		repairPlanTimes.add(this.creRepairPlanTime(repairPlanRule, now.getTime()));
		while(initMon < 12){         //后推
			initMon += interval;
			mon = initMon-1;
			lastDay = this.getLastDayOfMonth(year,initMon);
			initDay = dayNum>lastDay?lastDay:dayNum;
			now.set(year, mon, initDay);
			if(initMon < 13){
				repairPlanTimes.add(this.creRepairPlanTime(repairPlanRule, now.getTime()));
			}
		}
		while(fastMon > 0){         //前推
			fastMon -= interval;
			mon = fastMon-1;
			lastDay = this.getLastDayOfMonth(year,initMon);
			initDay = dayNum>lastDay?lastDay:dayNum;
			now.set(year, mon, initDay);
			if(fastMon > 0){
				repairPlanTimes.add(this.creRepairPlanTime(repairPlanRule, now.getTime()));
			}
		}
		repairPlanRule.setRepairPlanTimes(repairPlanTimes);
		return repairPlanRule;
	}
	
	public int getLastDayOfMonth(int year,int month)
	{
		Calendar cal = Calendar.getInstance();
		//设置年份
		cal.set(Calendar.YEAR,year);
		//设置月份
		cal.set(Calendar.MONTH, month-1);
		//获取某月最大天数
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	private RepairPlanTime creRepairPlanTime(RepairPlanRule repairPlanRule,Date date){
		RepairPlanTime bean = new RepairPlanTime();
		bean.setRepairPlanRule(repairPlanRule);
		bean.setPlanDate(date);
		bean.setActualDate(date);
		bean.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		bean.setStatus(RepairPlanTime.STATUS_WAIT_VALUE);
		return bean;
	}
	/**
	 * List排序        orderState：1  DESC  0：ASC     
	 * @param repairPlanRules
	 * @param orderState
	 * @return
	 */
	private List<RepairPlanRule> orderByLevel(List<RepairPlanRule> repairPlanRules,final int orderState){
		Collections.sort(repairPlanRules, new Comparator<RepairPlanRule>(){
			@Override
			public int compare(RepairPlanRule o1, RepairPlanRule o2) {
				String lvl1 = o1.getMaintenaceLevel();
				String lvl2 = o2.getMaintenaceLevel();
                if (lvl1.compareTo(lvl2)<0) {
                	if(orderState == 1)
                		return 1;
                	else
                		return -1;
                } else if (lvl1.compareTo(lvl2)==0) {  
                    return 0;  
                } else {  
                	if(orderState == 1)
                		return -1;
                	else
                		return 1;
                }    
			}
			
		});
		return repairPlanRules;
	}


	@Override
	public void newOrEdit(HttpServletRequest request, RepairPlan domain,
			boolean newFlag) {
		// TODO Auto-generated method stub
		RepairPlanRuleService repairPlanRuleService = AppContext.getServiceFactory().getService("repairPlanRuleService");
		List<DataDict> byjhList = DataDictHelper.findDataDicts("BYJB");
		 List<RepairPlanRule> repairPlanRules = new ArrayList<RepairPlanRule>();
		String dvalue = "";
	    String maintenaceLevel = null;
	    String dayNum = null;
	    String interval = null;
	    int tempIndex = 0;
	    List<String> isExtRule = new ArrayList<String>();
	    String startIndex = request.getParameter("startIndex");
	    if(StringUtils.isNullString(startIndex)){
	    	startIndex = "1";
	    }
	    tempIndex = Integer.parseInt(startIndex);
	    if(byjhList != null && !byjhList.isEmpty()){
        	for(DataDict dd : byjhList){
        		if(dd != null){
        			dvalue = dd.getValue();
        			RepairPlanRule repairPlanRule = null;
        			maintenaceLevel = request.getParameter("maintenaceLevel_"+dvalue);
        			if(!StringUtils.isNullString(maintenaceLevel)){
        				isExtRule.add(maintenaceLevel);
        				dayNum = request.getParameter("dayNum_"+dvalue);
        				interval = request.getParameter("interval_"+dvalue);
        				boolean isSon = false;    //是否为新子项标识
        				if(!newFlag){ //新建计划
        					repairPlanRule = new RepairPlanRule();
        				}else{        //编辑计划
        					repairPlanRule = repairPlanRuleService.selRepairPlanRule(domain.getId(),maintenaceLevel);
        					if(repairPlanRule == null){        //判断是否已存在此计划
	        					repairPlanRule = new RepairPlanRule();
        					}else{
        						isSon = true;
        						if(domain.getStartIndex()==Integer.parseInt(startIndex) 
        								&& compareRuleProperty(repairPlanRule, Integer.parseInt(dayNum),Integer.parseInt(interval))){
        							repairPlanRules.add(repairPlanRule);
        							tempIndex ++;
        							continue;
        						}
        					}
        				}
        				setRuleProperty(domain, repairPlanRule, Integer.parseInt(dayNum), Integer.parseInt(interval), maintenaceLevel);
        				repairPlanRules.add(setSon(repairPlanRule,isSon,tempIndex));
        				tempIndex ++;
        			}
        		}
        	}
	    }
	    this.setAfter(repairPlanRules,isExtRule);
		domain.setRepairPlanRules(repairPlanRules);
	}

	/**
	 * 比较规则属性是否有改动
	 * @param repairPlanRule
	 * @param dayNum
	 * @param interval
	 * @param startIndex
	 * @return
	 */
	private boolean compareRuleProperty(RepairPlanRule repairPlanRule,Integer dayNum,Integer interval){
		if(repairPlanRule.getDayNum() == dayNum && repairPlanRule.getInterval() == interval 
				&& repairPlanRule.getStatus() == repairPlanRule.STATUS_ENABLE_VALUE)
			return true;
		return false;
	}
	
	private void setRuleProperty(RepairPlan repairPlan,RepairPlanRule repairPlanRule,Integer dayNum,Integer interval,String maintenaceLevel){
		repairPlanRule.setRepairPlan(repairPlan);
		repairPlanRule.setMaintenaceLevel(maintenaceLevel);
		repairPlanRule.setCirculationMode(1);
		repairPlanRule.setDayNum(dayNum);
		repairPlanRule.setInterval(interval);
		repairPlanRule.setStatus(RepairPlanRule.STATUS_ENABLE_VALUE);
	}
	
	private RepairPlanRule setSon(RepairPlanRule repairPlanRule,boolean newOrEdit,Integer startIndex){
		Integer dayNum = repairPlanRule.getDayNum();
		Integer interval = repairPlanRule.getInterval();
		List<RepairPlanTime> repairPlanTimes = repairPlanRule.getFinishRepairPlanTimes();
		if(repairPlanTimes == null){
			repairPlanTimes = new ArrayList<RepairPlanTime>();
		}
		Calendar now = Calendar.getInstance();
		int year = DateUtils.getYear(new Date());
		int initMon = startIndex;
		if(newOrEdit){
			Long planRuleId = repairPlanRule.getId();
			repairPlanTimeService.delByRuleId(planRuleId,RepairPlanTime.STATUS_WAIT_VALUE);     //删除未执行记录
			RepairPlanTime lastFinishTime = repairPlanTimeService.selLastFinishByRuleId(planRuleId,RepairPlanTime.STATUS_FINISH_VALUE); //获取最近执行的记录
			if(lastFinishTime != null){
				now.setTime(lastFinishTime.getPlanDate());
				if(now.get(Calendar.YEAR) == year)
					initMon = now.get(Calendar.MONTH) + 1;
			}
		}
		int lastDay = this.getLastDayOfMonth(year,initMon);
		int initDay = dayNum>lastDay?lastDay:dayNum;
		now.set(year, initMon-1, initDay);
		repairPlanTimes.add(this.creRepairPlanTime(repairPlanRule, now.getTime()));
		while(initMon < 12){         //后推
			initMon += interval;
			lastDay = this.getLastDayOfMonth(year,initMon);
			initDay = dayNum>lastDay?lastDay:dayNum;
			now.set(year, initMon-1, initDay);
			if(initMon < 13){
				repairPlanTimes.add(this.creRepairPlanTime(repairPlanRule, now.getTime()));
			}
		}
		repairPlanRule.setRepairPlanTimes(repairPlanTimes);
		return repairPlanRule;
	}
	
	
	/**
	 * 非物理删除未选中规则并删除未执行记录
	 * @param repairPlanRules
	 * @param isExtRule
	 */
	private void setAfter(List<RepairPlanRule> repairPlanRules,
			List<String> isExtRule) {
		// TODO Auto-generated method stub
		if(isExtRule != null && !isExtRule.isEmpty() && repairPlanRules != null && !repairPlanRules.isEmpty()){
			List<String> planList = new ArrayList<String>();
			repairPlanRules = this.orderByLevel(repairPlanRules, 1);
			for(RepairPlanRule rule : repairPlanRules){
				if(!isExtRule.contains(rule.getMaintenaceLevel())){
					rule.setStatus(RepairPlanRule.STATUS_DEL_VALUE);
					repairPlanTimeService.delByRuleId(rule.getId(),RepairPlanTime.STATUS_WAIT_VALUE);     //删除未执行记录
				}
				this.setPlanList(rule,planList);
			}
			
		}
	}

	private void setPlanList(RepairPlanRule rule, List<String> planList) {
		// TODO Auto-generated method stub
		List<RepairPlanTime> newRepairPlanTimes = new ArrayList<RepairPlanTime>();
		List<RepairPlanTime> repairPlanTimes = rule.getRepairPlanTimes();
		String planStr = null;
		if(repairPlanTimes != null && !repairPlanTimes.isEmpty()){
			for(RepairPlanTime rpt : repairPlanTimes){
				planStr = toPlanStr(rpt);
				if(!planList.contains(planStr)){
					planList.add(planStr);
					newRepairPlanTimes.add(rpt);
				}
			}
			rule.setRepairPlanTimes(newRepairPlanTimes);
		}
		
	}

	@Override
	public List<RepairPlan> loadAllByOrgId(String orgId) {
		// TODO Auto-generated method stub
		return this.simpleDao.loadAllByOrgId(orgId);
	}
	
	
	
}
