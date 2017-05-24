package cn.suntak.ems.partinfo.service.impl;




import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import cn.oz.UserContextHolder;
import cn.oz.config.domain.DataDict;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.config.service.DataDictService;
import cn.oz.dao.Page;
import cn.oz.exception.EntityNotUniqueException;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.partinfo.dao.PartInfoTreeDao;
import cn.suntak.ems.partinfo.domain.PartInfoTree;
import cn.suntak.ems.partinfo.service.PartInfoTreeService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoTreeServiceImpl extends CRUDServiceImpl< PartInfoTree, Long,  PartInfoTreeDao> implements  PartInfoTreeService{

	@Override
	public PartInfoTree create() throws OzException {
		PartInfoTree partInfoTree = new PartInfoTree();
		partInfoTree.setIsExclusive(0);
		partInfoTree.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		return partInfoTree;
	}
	@Override
	public void save(PartInfoTree partInfoTree) throws EntityNotUniqueException, OzException {
		if(null != partInfoTree.getParent() && partInfoTree.getParent().isNew())
			partInfoTree.setParent(null);

		// 唯一性判断
		//	if(!this.simpleDao.isUnique(dataDict))
		//		throw new EntityNotUniqueException();

		this.simpleDao.save(partInfoTree);

		userLogger.log(this.getLogMessage("oz.core.userlog.action.save"),
				this.getLogMessage("oz.core.userlog.logcontext.save", partInfoTree),
				String.valueOf(partInfoTree.getId()));
	}

	@Override
	public List<PartInfoTree> findByParent(long parentId) {
		return this.simpleDao.findByParent(parentId);
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId,Long equipmentId,boolean flag) {
		this.simpleDao.getPage(page, dbftSearchParams, searchQuery,  parentId,equipmentId,flag);
	}
	@Override
	public Boolean updateReplaceDate(Date replanceDate, Long equipmentId,
			Long partId) {
		// TODO Auto-generated method stub
		if(equipmentId == null)
			return false;
		PartInfoTree bean = null;
		Set<PartInfoTree> childs = null;
		PartInfoTree childPartInfoTree = null;
		boolean inFactry = true;
		if(partId != null){
			inFactry = false; 
		}
		bean = this.simpleDao.loadByEquipmentId(equipmentId);
		if(bean != null){
			childs = bean.getChilds();
		}
		if(childs != null && !childs.isEmpty()){
			Iterator<PartInfoTree> it = childs.iterator();
			while (it.hasNext()) {
			  childPartInfoTree = it.next();
			  if(childPartInfoTree != null && childPartInfoTree.getUsePeriod() != null){
				 if(inFactry){     //入厂
					 childPartInfoTree.setReplaceDate(replanceDate);
					 childPartInfoTree.setNextReDate(this.getPartNextReDate(replanceDate, childPartInfoTree.getUsePeriod()));
					 this.save(childPartInfoTree);
				 }else{            //配件跟换
					if(childPartInfoTree.getPartId() == partId) {
						childPartInfoTree.setReplaceDate(replanceDate);
						childPartInfoTree.setNextReDate(this.getPartNextReDate(replanceDate, childPartInfoTree.getUsePeriod()));
						this.save(childPartInfoTree);
					}
				 }
			  }
			}
		}
		return true;
	}
	
	private Date getPartNextReDate(Date replanceDate,Integer usePeriod){
		Calendar cl = Calendar.getInstance();  
        cl.setTime(replanceDate);  
        cl.add(Calendar.MONTH, usePeriod);  
        return cl.getTime(); 
	}
	@Override
	public Integer findDatePartNum(String beginDate, String endDate) {
		// TODO Auto-generated method stub
		List<PartInfoTree> list = this.simpleDao.getNextReplaceByDate(beginDate, endDate);
		if(list == null || list.isEmpty())
			return 0;
		return list.size();
	}
	@Override
	public List<PartInfoTree> getNextReplaceByDate(String beginDate,
			String endDate) {
		// TODO Auto-generated method stub
		return this.simpleDao.getNextReplaceByDate(beginDate, endDate);
	}
	@Override
	public PartInfoTree loadByEquipmentId(Long equipmentId) {
		// TODO Auto-generated method stub
		return this.simpleDao.loadByEquipmentId(equipmentId);
	}
	@Override
	public void synchroDataDict(Long parentId, String section,
			DataDictService dataDictService,EquipmentDetailsService equipmentDetailsService) {
		// TODO Auto-generated method stub
		if(parentId != -1 && !StringUtils.isNullString(section)){
			PartInfoTree parentTree = this.load(parentId);
			if(parentTree != null && parentTree.getEquipmentId() != null){
				Long equipmentId = parentTree.getEquipmentId();
				DataDict rootDict = DataDictHelper.getDataDict(null, "SBFD");
				DataDict equipmentDict = DataDictHelper.getDataDict("SBFD", equipmentId+"");
				DataDict sectionDict = DataDictHelper.getDataDict(equipmentId + "", section);
				EquipmentDetails equipmentDetail = equipmentDetailsService.load(equipmentId);
				if(equipmentDetail != null){
					if(equipmentDict == null){
						equipmentDict = new DataDict();
						equipmentDict.setParent(rootDict);
						equipmentDict.setName(equipmentDetail.getEquipmentName());
						equipmentDict.setValue(equipmentDetail.getId()+"");
						equipmentDict.setDefaultFlag("N");
						equipmentDict.setInnerFlag("N");
						equipmentDict.setOrderNo("EQUIPMENT"+equipmentDetail.getId());
						dataDictService.save(equipmentDict);
					}
					if(sectionDict == null){
						Integer max = 0;
						if(equipmentDict.getChilds() != null && !equipmentDict.getChilds().isEmpty()){
							max = equipmentDict.getChilds().size();
						}
						sectionDict = new DataDict();
						sectionDict.setParent(equipmentDict);
						sectionDict.setName(section);
						sectionDict.setValue(section);
						sectionDict.setDefaultFlag("N");
						sectionDict.setInnerFlag("N");
						sectionDict.setOrderNo("SECTION"+ (max++));
						dataDictService.save(sectionDict);
					}
				}
			}
		}
	}

	
}
