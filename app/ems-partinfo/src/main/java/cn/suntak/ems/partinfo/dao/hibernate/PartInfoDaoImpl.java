package cn.suntak.ems.partinfo.dao.hibernate;


import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.PartInfoDao;
import cn.suntak.ems.partinfo.domain.PartInfo;

/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoDaoImpl extends SimpleDaoImpl<PartInfo, Long> implements PartInfoDao {

    @Override
    protected String[] getDbftSearchFields() {
        return new String[]{"partName", "partNo"};
    }


    @Override
    public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long orgId) {
        // TODO Auto-generated method stub
        List<Object> args = new ArrayList<Object>();
        String hql = "from PartInfo partInfo where 1=1 ";
        String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "partInfo", args);
        if (null != fullTextSql) {
            hql += "and " + fullTextSql;
        }
        // 添加其他检索条件
        if (null != searchQuery) {
            String sq = searchQuery.getQueryStatement("partInfo", args);
            if (!StringUtils.isNullString(sq)) {
                String shq = sq.replace('_', '.');
                hql += "and " + shq;
            }
        }
        hql += "and partInfo.organizationId = ?";
        args.add(orgId);
        this.getPage(page, hql, args.toArray(), "partInfo", page.getOrder());
    }


	@Override
	public PartInfo getPartInfoBy(long partId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("id",partId);
	}
}