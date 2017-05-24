package cn.suntak.ems.equipmentrepair.job;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import cn.oz.exception.OzException;
import cn.oz.job.Job;
import cn.suntak.ems.equipmentrepair.service.MaintainService;

/**
 * 推送保养计划
 * @author wulk
 *
 */
public class PushMaintainJob implements Job{

	private MaintainService maintainService;
	
	
	public void setMaintainService(MaintainService maintainService) {
		this.maintainService = maintainService;
	}




	@Override
	public void execute() throws OzException {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		Date newDate = new Date();
		String beginDateStr = sdf.format(CalculationDate(newDate,-7));
		String enddateStr = sdf.format(newDate);
		maintainService.pushMaintainByDate(beginDateStr,enddateStr);
	}
	
	private Date CalculationDate(Date date,int intervalDay){
		Calendar   calendar   =   new   GregorianCalendar(); 
	     calendar.setTime(date); 
	     calendar.add(calendar.DATE,intervalDay);//把日期往后增加一天.整数往后推,负数往前移动 
	    return date=calendar.getTime();   //这个时间就是日期往后推一天的结果
	}

}
