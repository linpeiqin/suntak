package cn.suntak.ems.equipmentdetails.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;

import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EquipmentDetailsService extends SimpleService<EquipmentDetails, Long>{

    public static Integer EQUIPMENT_OFF = 9;
    public static Integer EQUIPMENT_ON = 2;
    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Integer type, Integer scrapState);

    void save(List<EquipmentDetails> edl);

    Boolean disableEquip(Long id);

    Boolean enableEquip(Long id);

    List<EquipmentDetails> getIntoFactoryEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);

    List<EquipmentDetails> getIntoFactoryCheckEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);

    void getPageForEQ(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId);

    void getPageForEQList(Page page, String dbftSearchParams, SearchQuery searchQuery, Long id,String method);

    Boolean addRelation(Long equipmentId, Long parentId);

    Boolean deleteRelation(Long equipmentId, Long parentId);

    List<EquipmentDetails> getScrapEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);

    List<EquipmentDetails> getInernalTransferEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);

    void changeType(EquipmentDetails eq, int equipmentType);

    EquipmentDetails loadByAssetId(String assetId);

    List<EquipmentDetails> getRenewalEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);

    List<EquipmentDetails> getRenewalCheckEquipment(String contractNo, String fixedAssetsName, String specificationModel, Long lifeCycleId);


}
