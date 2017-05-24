package cn.suntak.ems.equipmentrepair.dao.hibernate;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.PartReplaceDao;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;

/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartReplaceDaoImpl extends SimpleDaoImpl<PartReplace, Long> implements PartReplaceDao {

    @Override
    protected String[] getDbftSearchFields() {
        return new String[]{};
    }


    @Override
    public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long wId,String type) {
        // TODO Auto-generated method stub
        List<Object> args = new ArrayList<Object>();
        String hql = "from PartReplace partReplace where 1=1 ";

        String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "partReplace", args);
        if(null != fullTextSql) {
            hql += "and " +fullTextSql;
        }
        // 添加其他检索条件
        if (null != searchQuery) {
            String sq = searchQuery.getQueryStatement("partReplace", args);
            if (!StringUtils.isNullString(sq)) {
                hql += "and " + sq;
            }
        }

        if (type.equals("E")){
            hql +="and partReplace.repairRecord.equipmentDetails.id= ? ";
            args.add(wId);
        }
        if (type.equals("P")) {
            hql +="and partReplace.partId= ? ";
            args.add(wId);
        }
        this.getPage(page, hql, args.toArray(), "partReplace", page.getOrder());
    }

    @Override
    public Set<PartReplace> loadByPartId(Long partId) {
        return (Set<PartReplace>) this.findBy("partId", partId);
    }

    @Override
    public Set<PartReplace> loadByEquipmentId(Long equipmentId) {
        return (Set<PartReplace>) this.findBy("equipmentId", equipmentId);
    }
}