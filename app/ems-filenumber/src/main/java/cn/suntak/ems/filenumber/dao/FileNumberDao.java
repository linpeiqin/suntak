package cn.suntak.ems.filenumber.dao;

import java.util.List;

import cn.oz.SourceFile;
import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.suntak.ems.filenumber.domain.FileNumber;

/**
 * 编号管理的Dao对象。
 * 
 * @author yanxuehui
 * @version 5.2.0
 */
public interface FileNumberDao extends SimpleDao<FileNumber, Long> {

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

}
