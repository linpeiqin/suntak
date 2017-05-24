package cn.suntak.ems.equipmentdetails.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentdetails.dao.EquipmentDetailsDao;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentDetailsDaoImpl extends SimpleDaoImpl<EquipmentDetails, Long> implements EquipmentDetailsDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"equipmentName","equipmentNo","specificationModel","equipmentType","contractNo","ebsEntity.userD","assetId"};
	}
	

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery,Integer type,Integer scrapState) {
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "equipmentDetails", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("equipmentDetails", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
		hql += "and equipmentDetails.organizationId = ? ";
		args.add(Long.valueOf(orgId));
		if (!type.equals(-1)){
			hql += "and equipmentDetails.type= ? ";
			args.add(type);
		}

		if (!scrapState.equals(-1)){
			hql += "and equipmentDetails.scrapState= ? ";
			args.add(scrapState);
		} else {
			hql += "and equipmentDetails.scrapState= 0 ";
		}
		hql = hql.replaceAll("ebsEntity_","ebsEntity.");
		this.getPage(page, hql, args.toArray(), "equipmentDetails", page.getOrder());

	}


	@Override
	public Boolean addRelation(Long equipmentId, Long parentId) {
		EquipmentDetails  equipmentDetails = this.get(equipmentId);
		equipmentDetails.setParentId(parentId);
		return true;
	}

	@Override
	public Boolean deleteRelation(Long equipmentId, Long parentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		if(!equipmentId.equals(-1L) && !parentId.equals(-1L)){
			hql+= "and equipmentDetails.id = ? ";
			hql+= "and equipmentDetails.parentId = ? ";
			args.add(equipmentId);
			args.add(parentId);
		}
		EquipmentDetails  equipmentDetails = this.findUnique(hql, args.toArray());
		equipmentDetails.setParentId(-1L);
		return true;
	}





	@Override
	public void getPageForEQ(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId) {
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "equipmentDetails", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("equipmentDetails", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
		hql += "and equipmentDetails.organizationId = ? ";
		args.add(Long.valueOf(orgId));
		if (!parentId.equals(-1)){
			hql += "and equipmentDetails.parentId= ? ";
			args.add(parentId);
		}
		hql = hql.replaceAll("ebsEntity_","ebsEntity.");
		this.getPage(page, hql, args.toArray(), "equipmentDetails", page.getOrder());
	}

	@Override
	public void getPageForEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id) {
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "equipmentDetails", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("equipmentDetails", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
				}
		}
		hql += "and equipmentDetails.organizationId = ? ";
		hql+=" and equipmentDetails.scrapState = 0 and equipmentDetails.type = 2 ";
		args.add(Long.valueOf(orgId));
		if (!id.equals(-1)){
			hql += " and equipmentDetails.id != ? ";
			args.add(id);
		}
		hql += " and (equipmentDetails.parentId is null or equipmentDetails.parentId = -1)";
		hql = hql.replaceAll("ebsEntity_","ebsEntity.");
		this.getPage(page, hql, args.toArray(), "equipmentDetails", page.getOrder());
	}
	@Override
	public void getPageForMainAddEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id) {
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "equipmentDetails", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("equipmentDetails", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
		hql += "and equipmentDetails.organizationId = ? ";
		hql+=" and equipmentDetails.scrapState = 0 and equipmentDetails.type = 2 ";
		args.add(Long.valueOf(orgId));
		if (!id.equals(-1)){
			hql += " and equipmentDetails.id != ? ";
			args.add(id);
		}
		this.getPage(page, hql, args.toArray(), "equipmentDetails", page.getOrder());
	}

	@Override
	public EquipmentDetails loadByAssetId(String assetId) {
		List<EquipmentDetails> list = this.findBy("assetId",assetId);
		if(list!=null&&list.size()>0)
			return list.get(0);
		return null;
	}

	@Override
	public List<EquipmentDetails> getEquipmentForLifeCycle(String contractNo, String fixedAssetsName, String specificationModel, int equipmentType) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from EquipmentDetails equipmentDetails where 1=1 ";
		if(!contractNo.equals("")){
			hql+= "and equipmentDetails.contractNo = ? ";
			args.add(contractNo);
		}
		if(!fixedAssetsName.equals("")){
			hql+= "and equipmentDetails.equipmentName = ? ";
			args.add(fixedAssetsName);
		}
		if(!specificationModel.equals("")){
			hql+= "and equipmentDetails.specificationModel = ? ";
			args.add(specificationModel);
		}
		hql+=" and equipmentDetails.scrapState = 0 and equipmentDetails.type = ? ";
		args.add(equipmentType);
		if(equipmentType==EquipmentDetailsDao.INTO_FACTORY){
			hql+=" and equipmentDetails.equipmentNo is null";
		}else{
			hql+=" and equipmentDetails.equipmentNo is not null";
		}
		hql+=" and equipmentDetails.organizationId = ?";
		args.add(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		return this.find(hql, args.toArray());
	}

	@Override
	public List<EquipmentDetails> getEquipmentForRenewal(String contractNo, String fixedAssetsName, String specificationModel, int equipmentType) {
		List<Object> args = new ArrayList<Object>();
		String hql = "select equipmentDetails from EquipmentDetails equipmentDetails join equipmentDetails.renewalContracts renewalContracts where 1=1 ";
		if(!contractNo.equals("")){
			hql+= "and renewalContracts.contractNo = ? ";
			args.add(contractNo);
		}
		if(!fixedAssetsName.equals("")){
			hql+= "and equipmentDetails.equipmentName = ? ";
			args.add(fixedAssetsName);
		}
		if(!specificationModel.equals("")){
			hql+= "and equipmentDetails.specificationModel = ? ";
			args.add(specificationModel);
		}
		hql+=" and equipmentDetails.scrapState = 0 and equipmentDetails.type = ? ";
		args.add(equipmentType);
		hql+=" and equipmentDetails.equipmentNo is not null";
		return this.find(hql, args.toArray());
	}


}