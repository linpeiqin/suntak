package cn.suntak.ems.equipmentdetails.dao;



import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EquipmentDetailsDao extends SimpleDao<EquipmentDetails, Long> {

	/***
	 *
	 * @param page
	 * @param dbftSearchParams
	 * @param searchQuery
	 * @param type
     * @param scrapState
     */
	/**
	 * 入厂
	 */
	public static int INTO_FACTORY=0;
	public static int INTO_FACTORY_CHECK=1;
	public static int RENEWAL=5;
	public static int RENEWAL_CHECK=6;
	public static int COMPLETION=7;
	public static int COMPLETION_CHECK=8;
	public static int SCRAP=2;
	public static int INTERNAL_TRANSFER=2;


	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Integer type, Integer scrapState);
	
	void getPageForEQ(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId);

	void getPageForEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id);

    Boolean addRelation(Long equipmentId, Long parentId);

	Boolean deleteRelation(Long equipmentId, Long parentId);

	void getPageForMainAddEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id);

	EquipmentDetails loadByAssetId(String assetId);

	List<EquipmentDetails> getEquipmentForLifeCycle(String contractNo, String fixedAssetsName, String specificationModel, int equipmentType);

	List<EquipmentDetails> getEquipmentForRenewal(String contractNo, String fixedAssetsName, String specificationModel, int renewal);
}