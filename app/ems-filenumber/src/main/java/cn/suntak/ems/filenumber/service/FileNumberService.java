package cn.suntak.ems.filenumber.service;

import java.util.List;

import cn.oz.SourceFile;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.suntak.ems.filenumber.domain.FileNumber;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;

/**
 * 文字编号Service
 * 
 * @author KingChen
 * 
 */
public interface FileNumberService extends SimpleService<FileNumber, Long> {
	public List<FileNumber> findByIDs(Long[] ids);

	/**
	 * 更新编号的状态
	 * 
	 * @param id 字号ID
	 * @param fileNumberStatus 状态
	 */
	public int updateStatus(long id, int fileNumberStatus);

	/**
	 * 根据单位和编号Code信息查找是否有指定的编号信息
	 * 
	 * @param unitID 单位ID
	 * @param code 编号
	 * @return
	 */
	public FileNumber findUnique(String unitId,String code);


	public void getPage(Page page, String unitId);
	
	/**
	 * 判断用户是否系统管理员或单位管理员
	 * 
	 * @return
	 */
	public boolean isAdmin();
	
	/**
	 * 产生一个编号
	 * 
	 * @param code
	 * @return
	 */	
	public String doCreateNumber(String unitId, String code);
	
	/**
	 * 产生一个编号
	 * 
	 * @param code
	 * @return
	 */	
	public String doCreateNumber(String code);
}
