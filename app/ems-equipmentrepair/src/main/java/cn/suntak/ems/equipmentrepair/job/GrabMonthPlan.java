package cn.suntak.ems.equipmentrepair.job;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import cn.oz.exception.OzException;
import cn.oz.job.Job;
import cn.suntak.ems.equipmentrepair.service.RepairMonthPlanService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;

public class GrabMonthPlan implements Job{

	private RepairMonthPlanService repairMonthPlanService;

	public void setRepairMonthPlanService(
			RepairMonthPlanService repairMonthPlanService) {
		this.repairMonthPlanService = repairMonthPlanService;
	}




	@Override
	public void execute() throws OzException {
		// TODO Auto-generated method stub
		String nextMonthDate = dateFormat(new Date(), 1);
		String nextMonthStr = nextMonthDate.substring(0, 7);
		repairMonthPlanService.grabPlanByMonth(nextMonthStr,null);
	}
	
	
	
	/**
	 * 实现日期月数的加/减
	 * @param date
	 * @param monthNum
	 * @return
	 */
	public static String dateFormat(Date date,int monthNum) {  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cl = Calendar.getInstance();  
        cl.setTime(date);  
        cl.add(Calendar.MONTH, monthNum);  
        date = cl.getTime();  
        return sdf.format(date);  
    }  

}
