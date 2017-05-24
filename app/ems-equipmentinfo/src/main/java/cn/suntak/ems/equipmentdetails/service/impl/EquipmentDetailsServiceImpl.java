package cn.suntak.ems.equipmentdetails.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentdetails.dao.EquipmentDetailsDao;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;
import cn.suntak.ems.renewal.domain.RenewalContract;

import java.util.*;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentDetailsServiceImpl extends CRUDServiceImpl< EquipmentDetails, Long,  EquipmentDetailsDao> implements  EquipmentDetailsService{


	public EquipmentLifeCycleService getEquipmentLifeCycleService() {
		return equipmentLifeCycleService;
	}

	public void setEquipmentLifeCycleService(EquipmentLifeCycleService equipmentLifeCycleService) {
		this.equipmentLifeCycleService = equipmentLifeCycleService;
	}

	private EquipmentLifeCycleService equipmentLifeCycleService;
	@Override
	public EquipmentDetails create() throws OzException {
		
		return new EquipmentDetails();
	}


	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery,Integer type,Integer scrapState) {
		this.getSimpleDao().getPage(page,dbftSearchParams, searchQuery,type,scrapState);
	}

	@Override
	public void save(List<EquipmentDetails> edl) {
		this.simpleDao.save(edl);
	}

	@Override
	public Boolean disableEquip(Long id) {
		EquipmentDetails equipmentDetails = this.simpleDao.get(id);
		if(equipmentDetails.getType()==EQUIPMENT_ON)
		equipmentDetails.setType(EQUIPMENT_OFF);
		this.save(equipmentDetails);
		return true;
	}

	@Override
	public Boolean enableEquip(Long id) {
		EquipmentDetails equipmentDetails = this.simpleDao.get(id);
		if(equipmentDetails.getType()==EQUIPMENT_OFF)
		equipmentDetails.setType(EQUIPMENT_ON);
		this.save(equipmentDetails);
		return true;
	}

	@Override
	public List<EquipmentDetails> getIntoFactoryEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		EquipmentLifeCycle equipmentLifeCycle  = this.equipmentLifeCycleService.load(lifeCycleId);
		Set<EquipmentDetails> add = new HashSet<EquipmentDetails>();
		List<EquipmentDetails> removeEquipment = new ArrayList<EquipmentDetails>();
		if(equipmentLifeCycle!=null){
			add = equipmentLifeCycle.getEquipmentDetails();
		}
		List<EquipmentDetails>  list = this.simpleDao.getEquipmentForLifeCycle(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.INTO_FACTORY);
		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				if(ed.containLifeCycle("intoFactory","intoFactoryAndCheck")){
					removeEquipment.add(ed);
				}
			}
		}
		list.removeAll(removeEquipment);
		list.addAll(0,add);
		return list;
	}

	@Override
	public List<EquipmentDetails> getIntoFactoryCheckEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		EquipmentLifeCycle equipmentLifeCycle  = this.equipmentLifeCycleService.load(lifeCycleId);
		Set<EquipmentDetails> add = new HashSet<EquipmentDetails>();
		List<EquipmentDetails> removeEquipment = new ArrayList<EquipmentDetails>();
		if(equipmentLifeCycle!=null){
			add = equipmentLifeCycle.getEquipmentDetails();
		}
		List<EquipmentDetails>  list = this.simpleDao.getEquipmentForLifeCycle(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.INTO_FACTORY_CHECK);
		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				Set<EquipmentLifeCycle> elcs = ed.getEquipmentLifeCycles();
				for(EquipmentLifeCycle elc:elcs){
					if(elc.getType().equals("intoFactoryCheck")){
						removeEquipment.add(ed);
						break;
					}
				}
			}
		}
		list.removeAll(removeEquipment);
		list.addAll(0,add);
		return list;
	}

	@Override
	public void getPageForEQ(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId) {
		this.getSimpleDao().getPageForEQ(page,dbftSearchParams, searchQuery,parentId);
	}

	@Override
	public void getPageForEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id,String method) {
		if(method.equals("addMain")){
			this.getSimpleDao().getPageForMainAddEQList(page,dbftSearchParams, searchQuery,id);
		}else{
			this.getSimpleDao().getPageForEQList(page,dbftSearchParams, searchQuery,id);
		}

	}

	@Override
	public Boolean addRelation(Long equipmentId, Long parentId) {
		return this.getSimpleDao().addRelation(equipmentId,parentId);
	}

	@Override
	public Boolean deleteRelation(Long equipmentId, Long parentId) {
		return this.getSimpleDao().deleteRelation(equipmentId,parentId);
	}

	@Override
	public List<EquipmentDetails> getScrapEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		EquipmentLifeCycle equipmentLifeCycle  = this.equipmentLifeCycleService.load(lifeCycleId);
		Set<EquipmentDetails> add = new HashSet<EquipmentDetails>();
		List<EquipmentDetails> removeEquipment = new ArrayList<EquipmentDetails>();
		if(equipmentLifeCycle!=null){
			add = equipmentLifeCycle.getEquipmentDetails();
		}
		List<EquipmentDetails>  list = this.simpleDao.getEquipmentForLifeCycle(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.SCRAP);
		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				Set<EquipmentLifeCycle> elcs = ed.getEquipmentLifeCycles();
				for(EquipmentLifeCycle elc:elcs){
					if(elc.getType().equals("scrap")){
						removeEquipment.add(ed);
						break;
					}
				}
			}
		}
		list.removeAll(removeEquipment);
		list.addAll(0,add);
		return list;
	}

	@Override
	public List<EquipmentDetails> getInernalTransferEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		return this.simpleDao.getEquipmentForLifeCycle(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.INTERNAL_TRANSFER);
	}

	@Override
	public void changeType(EquipmentDetails eq, int i) {
		eq.setType(i);
		this.save(eq);
	}

	@Override
	public EquipmentDetails loadByAssetId(String assetId) {
		return this.simpleDao.loadByAssetId(assetId);
	}

	@Override
	public List<EquipmentDetails> getRenewalEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		EquipmentLifeCycle equipmentLifeCycle  = this.equipmentLifeCycleService.load(lifeCycleId);
		Set<EquipmentDetails> add = new HashSet<EquipmentDetails>();
		List<EquipmentDetails> removeEquipment = new ArrayList<EquipmentDetails>();
		if(equipmentLifeCycle!=null){
			add = equipmentLifeCycle.getEquipmentDetails();
		}
		List<EquipmentDetails> list = this.simpleDao.getEquipmentForRenewal(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.RENEWAL);

		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				Set<EquipmentLifeCycle> elcs = ed.getEquipmentLifeCycles();
				for(EquipmentLifeCycle elc : elcs){
					if(elc.getType().equals("renewal")){
						if(elc.getRenewal().getContractNumber()!=null&&elc.getRenewal().getContractNumber().equals(contractNo)){
							removeEquipment.add(ed);
							break;
						}
					}else if(elc.getType().equals("renewalAndCheck")){
						if(elc.getRenewalAndCheck().getContractNumber()!=null&&elc.getRenewalAndCheck().getContractNumber().equals(contractNo)){
							removeEquipment.add(ed);
							break;
						}
					}
				}
			}
		}
		list.removeAll(removeEquipment);
		list.addAll(0,add);
		return list;
	}

	@Override
	public List<EquipmentDetails> getRenewalCheckEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId) {
		EquipmentLifeCycle equipmentLifeCycle  = this.equipmentLifeCycleService.load(lifeCycleId);
		Set<EquipmentDetails> add = new HashSet<EquipmentDetails>();
		List<EquipmentDetails> removeEquipment = new ArrayList<EquipmentDetails>();
		if(equipmentLifeCycle!=null){
			add = equipmentLifeCycle.getEquipmentDetails();
		}
		List<EquipmentDetails> list = this.simpleDao.getEquipmentForRenewal(contractNo,fixedAssetsName,specificationModel,EquipmentDetailsDao.RENEWAL_CHECK);

		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				Set<EquipmentLifeCycle> elcs = ed.getEquipmentLifeCycles();
				for(EquipmentLifeCycle elc : elcs){
					if(elc.getType().equals("renewalCheck")){
						if(elc.getRenewalCheck().getContractNumber().equals(contractNo)){
							removeEquipment.add(ed);
							break;
						}
					}
				}
			}
		}
		list.removeAll(removeEquipment);
		list.addAll(0,add);
		return list;
	}
}
