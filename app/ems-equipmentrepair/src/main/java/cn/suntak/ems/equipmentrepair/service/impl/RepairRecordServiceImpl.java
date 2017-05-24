package cn.suntak.ems.equipmentrepair.service.impl;



import java.util.*;

import cn.oz.UserContextHolder;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.module.organize.domain.OzUserInfo;
import cn.oz.organize.UserInfo;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.EmsUserInfoDao;
import cn.suntak.ems.equipmentrepair.dao.RepairRecordDao;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;
import cn.suntak.ems.equipmentrepair.service.RepairRecordService;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.partinfo.domain.OrderHeadTemp;
import cn.suntak.ems.partinfo.domain.OrderLineTemp;
import cn.suntak.ems.partinfo.service.OrderHeadTempService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RepairRecordServiceImpl extends CRUDServiceImpl< RepairRecord, Long,  RepairRecordDao> implements  RepairRecordService{

	private FileNumberService fileNumberService;
	private OrderHeadTempService orderHeadTempService;
	private EmsUserInfoDao groupDao;
	@Override
	public RepairRecord create() throws OzException {
		RepairRecord bean = new RepairRecord();
		bean.setCreatedDate(new Date());
		bean.setMaintenanceTime(new Date());
		bean.setStatus(-1);
		bean.setCreatedDate(new Date());
		bean.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		bean.setMaintenanceApplicant(UserContextHolder.getCurFileAuthor());
		return bean;
	}
	public void setOrderHeadTempService(OrderHeadTempService orderHeadTempService) {
		this.orderHeadTempService = orderHeadTempService;
	}

	public void setFileNumberService(FileNumberService fileNumberService) {
		this.fileNumberService = fileNumberService;
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify) {
		this.simpleDao.getPage(page, dbftSearchParams, searchQuery, equipmentId,classify);
	}

	@Override
	public Integer findDateScapNum(String by, String repair) {
		return this.simpleDao.findDateScapNum(by,repair);
	}

	@Override
	public Boolean updateStatus(Long id, Integer status) {
		return this.simpleDao.updateStatus(id,status);
	}

	@Override
	public List<SelectOption> getFaultClass() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("GZLB", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public List<SelectOption> geteDegree() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("REPAIR-DEGREE", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public List<SelectOption> getMaintenaceLevel() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("REPAIR-LEVEL", null, true, true);
		for(int i=0;i<dict.length;i++)

		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public List<SelectOption> getMaintenaceLevelM() {
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("BYJB", null, true, true);
		for(int i=0;i<dict.length;i++)

		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public List<UserInfo> findAllByCode(String code) {
		List<UserInfo> userInfos = new ArrayList<UserInfo>();
		Set<UserInfo>  userInfoSet = this.groupDao.findAllByCode(code);
		if (userInfoSet!=null){
			for (UserInfo userInfo : userInfoSet){
				userInfos.add(userInfo);
			}
		}
		return userInfos;
	}

	@Override
	public List<SelectOption> getProjectName() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("WBXM", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public void createOrderHeadTemp(RepairRecord repairRecord) {
		Set<PartReplace> partReplaces = repairRecord.getPartReplaces();
		if (repairRecord.getPartReplaces()!=null && repairRecord.getPartReplaces().size()>0) {
			OrderHeadTemp orderHeadTemp = new OrderHeadTemp();
			orderHeadTemp.setEquipmentDetails(repairRecord.getEquipmentDetails());
			orderHeadTemp.setOperation(1);
			orderHeadTemp.setOrderNo(this.fileNumberService.doCreateNumber("CKDH"));
			orderHeadTemp.setDateTime(new Date());
			orderHeadTemp.setOperationType("领用出库");
			orderHeadTemp.setRemark("此单为维修更换配件自动产生，维修单号为：" + repairRecord.getMaintenanceNo());
			orderHeadTemp.setOrganizationId(repairRecord.getOrganizationId());
			orderHeadTemp.setMaintenanceNo(repairRecord.getMaintenanceNo());
			orderHeadTemp.setRepairId(repairRecord.getId());
			orderHeadTemp.setEbsState(-1);
			Set<OrderLineTemp> orderLineTemps = new HashSet<OrderLineTemp>();
			for (PartReplace partReplace : partReplaces){
				OrderLineTemp orderLineTemp = new OrderLineTemp();
				orderLineTemp.setOrganizationId(partReplace.getOrganizationId());
				orderLineTemp.setLineTypeId(partReplace.getLineTypeId());
				orderLineTemp.setPartNo(partReplace.getPartNo());
				orderLineTemp.setPartName(partReplace.getPartName());
				orderLineTemp.setPartId(partReplace.getPartId());
				orderLineTemp.setItemId(partReplace.getItemId());
				orderLineTemp.setOrganizationId(partReplace.getOrganizationId());
				orderLineTemp.setQty(partReplace.getQty());
				orderLineTemp.setPrice(partReplace.getPrice());
				orderLineTemp.setAmount(partReplace.getTotalPrice());
				orderLineTemp.setOrderHeadTemp(orderHeadTemp);
				orderLineTemps.add(orderLineTemp);
			}
			orderHeadTemp.setOrderLineTemps(orderLineTemps);
			this.orderHeadTempService.save(orderHeadTemp);
		}
	}
	@Override
	public List<SelectOption> getIntervalSelect() {
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption so = null;
		for(int i=1;i<=12;i++)
		{
			so = new SelectOption();
			so.setName(i+"");
			so.setValue(i+"");
			selectOptions.add(so);
		}
		return selectOptions;

	}

	@Override
	public void getSViewPage(Page page, Long equipmentId) {
		this.simpleDao.getSViewPage(page,equipmentId);
	}

	public void setGroupDao(EmsUserInfoDao groupDao) {
		this.groupDao = groupDao;
	}
}
