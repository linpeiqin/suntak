package cn.suntak.ems.filenumber.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.suntak.ems.filenumber.dao.FileNumberDao;
import cn.suntak.ems.filenumber.domain.FileNumber;
import cn.oz.security.PermissionVerifier;
import cn.oz.service.CRUDServiceImpl;


public class FileNumberServiceImpl extends CRUDServiceImpl<FileNumber, Long, FileNumberDao> implements FileNumberService {
	static String OUCode="{OUCode}";
	static String OUName="{OUName}";
	static String UnitCode="{UnitCode}";
	static String UnitName="{UnitName}";
	
	protected PermissionVerifier sysAdminVerifier = null;
	protected PermissionVerifier unitAdminVerifier = null;	
	

	public void setSysAdminVerifier(PermissionVerifier sysAdminVerifier) {
		this.sysAdminVerifier = sysAdminVerifier;
	}


	public void setUnitAdminVerifier(PermissionVerifier unitAdminVerifier) {
		this.unitAdminVerifier = unitAdminVerifier;
	}

	
	//////////////////////////////


	public FileNumber create() throws OzException {
		FileNumber FileNumber = new FileNumber();
		FileNumber.init(UserContextHolder.get().getCurUserInfo().toFileAuthor());
		FileNumber.setUnitId(UserContextHolder.get().getCurUserInfo().getUnitId());
		return FileNumber;
	}

	public void delete(Long id) throws OzException {
		FileNumber FileNumber = this.getSimpleDao().get(id);
		if (null == FileNumber)
			return;
		
		this.getSimpleDao().delete(FileNumber);
	}

	public void delete(Long[] ids) throws OzException {
		if (null == ids || ids.length == 0)
			return;
		Map<String, List<Integer>> relFileNumbers = new HashMap<String, List<Integer>>();
		List<FileNumber> newFileNumbers = new ArrayList<FileNumber>();
		for (Long id : ids) {
			FileNumber sourceDomain = this.load(id);
			
			this.getSimpleDao().delete(sourceDomain);
		}
	}

	
	public void getPage(Page page, String unitId){
		this.getSimpleDao().getPage(page, unitId);
	}
	

	/**
	 * 产生一个编号
	 * 
	 * @param code
	 * @return
	 */	
	public String doCreateNumber(String code){
		String unitId = UserContextHolder.get().getCurUserInfo().getUnitId();
		return this.doCreateNumber(unitId,code);
	}

	
	/**
	 * 获取下一个编号
	 * 
	 * @param code
	 * @return
	 */
	public String doCreateNumber(String unitId, String code) {
		// 得到当前未使用的最小记录编号

		FileNumber fileNumber=this.findUnique(unitId, code);
		if (null==fileNumber){
			return "";
		}
		
		
		String strPre = this.getFormatString( fileNumber.getNumberPrefix() );		
		String strPost =  this.getFormatString( fileNumber.getNumberPostfix());
		
		int iSerial = updateSerial(fileNumber);
		
		String strSerial=String.valueOf( iSerial );
		
		String strZero="";
		for (int i=strSerial.length();i<fileNumber.getNumberLength();i++){
			strZero += "0";
		}
		
		strSerial = strZero + strSerial;		
		
		String strResult = strPre + strSerial + strPost;
		
		return strResult;
		
		
	}

	@Override
	public List<FileNumber> findByIDs(Long[] ids) {
		return this.getSimpleDao().findByIDs(ids);
	}

	@Override
	public int updateStatus(long id, int fileNumberStatus) {
		return this.getSimpleDao().updateStatus(id, fileNumberStatus);
	}
	
	public boolean isAdmin(){
		boolean isAdmin = this.sysAdminVerifier.verify(UserContextHolder.get().getCurUser());
		if(!isAdmin){
			isAdmin = this.unitAdminVerifier.verify(UserContextHolder.get().getCurUser());
		}
		if(isAdmin){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public FileNumber findUnique(String unitId, String code) {
		return this.getSimpleDao().findUnique(unitId, code);
	}
	
	private int updateSerial(FileNumber fileNumber){
		String strSerial=fileNumber.getSerial();
		int iSerial = 0;
		try{
			iSerial = Integer.parseInt( strSerial ); 
		}catch(Exception e){
			
		}
		if (iSerial<=0){
			iSerial=1;
		}
		
		Date date=new Date();
		
		if (null != fileNumber.getNumberDate()){

			Date numberDate = fileNumber.getNumberDate();
			
			if (fileNumber.getNumberRule()==FileNumber.STATUS_YEAR){
				if (numberDate.getYear()!=date.getYear()){
					iSerial = 1;
				}
			}else if (fileNumber.getNumberRule()==FileNumber.STATUS_MONTH){
				if (numberDate.getYear()!=date.getYear() ||  numberDate.getMonth()!=date.getMonth()){
					iSerial = 1;
				}
			}else if (fileNumber.getNumberRule()==FileNumber.STATUS_DAY){
				if (numberDate.getYear()!=date.getYear() ||  numberDate.getMonth()!=date.getMonth() ||  numberDate.getDay()!=date.getDay()){
					iSerial = 1;
				}
			}			
		}
		
		fileNumber.setSerial( String.valueOf( iSerial + 1 ) );
		fileNumber.setNumberDate( date );
		
		this.getSimpleDao().save( fileNumber );
		
		return iSerial;
		
	}
	
	private String getFormatString(String str){
		if (null==str || str.length()==0)
			return "";
		
		
		UserContextHolder.get().getCurUserInfo().getOuInfo();
		UserContextHolder.get().getCurUserInfo().getOuInfo().getUnit();
		
		//取用户的单位名
		String curUnitCode = "";
		String curUnitName = "";
		try{
			curUnitCode = UserContextHolder.get().getCurUserInfo().getOuInfo().getUnit().getCode();
			curUnitName = UserContextHolder.get().getCurUserInfo().getOuInfo().getUnit().getName();
		}catch(Exception e){
			
		}
		//替换编号中的用户单位信息
		str=this.replaceCode(str,this.UnitCode, curUnitCode);
		str=this.replaceCode(str,this.UnitName, curUnitName);
		
		str=this.replaceCode(str,this.OUCode, UserContextHolder.get().getCurUserInfo().getOuInfo().getCode());
		str=this.replaceCode(str,this.OUName, UserContextHolder.get().getCurUserInfo().getOuInfo().getName());
		
		String strChange="";
		
		int iBegin=str.indexOf("{");
		
		while (iBegin>=0){
			
			
			int iBegin2=iBegin-1;
			
			if (iBegin>0){
				iBegin2=iBegin-1;
				
				iBegin2=str.indexOf("\\{");
			}
			
			if (iBegin2>=0 && iBegin2==iBegin-1){
				//前面有有\符号，不需转换
				strChange += str.substring(0,iBegin+1);
				str = str.substring( iBegin + 1 );
			}else{
				iBegin2 = iBegin;
				
				iBegin2=str.indexOf("}",iBegin2);
				int iBegin3=str.indexOf("\\}",iBegin2);
													
				while (iBegin2>=0 && iBegin3>=0 &&  iBegin3==iBegin2-1  ){
					iBegin2++;
					iBegin2=str.indexOf("}",iBegin2);
					iBegin3=str.indexOf("\\}",iBegin2);
				}
				
				if (iBegin2>=0){
					String strRelpace=str.substring(iBegin+1,iBegin2);
					strChange += str.substring(0,iBegin);
					
					strChange += replaceTime(strRelpace);
					
					str = str.substring( iBegin2 + 1 );
					
					
				}else{
					//后面没有单独的}号了，则整个字符串拷贝，不做处理
					strChange += str;
					str = "";
				}
			}

			iBegin=str.indexOf("{");
			
		}
		
		strChange += str;
		
		strChange = strChange.replace("\\{", "{");
		strChange = strChange.replace("\\}", "}");
		
		return strChange;
		
	}
	
	private String replaceTime(String str){
		if (null==str || str.length()==0)
			return "";
		
		DateFormat format1 = new SimpleDateFormat(str);
        String strResult = format1.format(new Date());
        return strResult;
		
	}
	
	private String replaceCode(String str, String strSrc, String strTo){
		
		if (null==str || str.length()==0)
			return "";
		
		if (null==strSrc || strSrc.length()==0)
			return str;
		
		if (null==strTo )
			strTo = "";
		
		int iBegin=str.indexOf(strSrc);
		
		while (iBegin>=0){
			int iBegin2=str.indexOf("\\"+strSrc); 
			
			if (iBegin2>=0 && (iBegin2+1==iBegin)){
				//前面有有\符号，不需转换
			}else{
				String str1="";
				if (iBegin>0){
					str1=str.substring(0,iBegin-1);
				}
				String str2=str.substring(iBegin + strSrc.length()  );
				
				str=str1 + strTo + str2;
				
			}
			
			iBegin=str.indexOf( strSrc );
		}
		
		return str;
	}
	

}
