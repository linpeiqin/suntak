package cn.suntak.ems.equipmentrepair.job;

import java.text.SimpleDateFormat;
import java.util.Date;

import cn.oz.exception.OzException;
import cn.oz.job.Job;
import cn.suntak.ems.equipmentrepair.service.RepairYearPlanService;



public class GrabYearPlan implements Job{
	private RepairYearPlanService repairYearPlanService;


	public void setRepairYearPlanService(RepairYearPlanService repairYearPlanService) {
		this.repairYearPlanService = repairYearPlanService;
	}




	@Override
	public void execute() throws OzException {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		String nowdateStr = sdf.format(new Date());
		String year = nowdateStr.substring(0, 4);
		repairYearPlanService.grabPlanByYear(year,null);
		
	}
}
	

