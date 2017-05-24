package cn.suntak.ems.partinfo.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.PartInfoTreeDao;
import cn.suntak.ems.partinfo.domain.PartInfoTree;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoTreeDaoImpl extends SimpleDaoImpl<PartInfoTree, Long> implements PartInfoTreeDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[]{};
	}


    @Override
    public List<PartInfoTree> findByParent(long parentId) {
        List<Object> args = new ArrayList<Object>();
        String hql = "from PartInfoTree partInfoTree ";
        if(parentId > 0){
            hql += "where partInfoTree.parent.id = ? ";
            args.add(parentId);
        }else{
            hql += "where partInfoTree.parent is null ";
        }
        String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
        hql += "and partInfoTree.organizationId = ?";
        args.add(Long.valueOf(orgId));
        return this.find(hql, args.toArray());
    }

    @Override
    public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId,Long equipmentId,boolean flag) {
        String hql = "from PartInfoTree partInfoTree where 1 = 1 ";
        List<Object> args = new ArrayList<Object>();
        if(equipmentId > 0){
        	hql += "and partInfoTree.parent.id = (select max(id) from partInfoTree where equipmentId = ?) ";
        	args.add(equipmentId);
        }else{
        	if(parentId > 0){
                hql += "and partInfoTree.parent.id = ? ";
                args.add(new Long(parentId));
            }else{
            	if(flag){
            		hql += "and 1=2";
            	}else{
            		hql += "and partInfoTree.parent is null ";
            	}
            }
        }
        String[] fullTextSearchFields= this.getDbftSearchFields();
        String fullTextSql = this.getDbftSearchCondition(fullTextSearchFields, dbftSearchParams, "partInfoTree", args);
        if(null != fullTextSql)
            hql += "and " + fullTextSql;

        // 添加其他检索条件
        if (null != searchQuery) {
            String sq = searchQuery.getQueryStatement("partInfoTree", args);
            if (!StringUtils.isNullString(sq)) {
                String shq = sq.replace('_', '.');
                hql += "and " + shq;
            }
        }
        String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
        hql += "and partInfoTree.organizationId = ?";
        args.add(Long.valueOf(orgId));
        this.getPage(page, hql, args.toArray(), "partInfoTree", page.getOrder());
    }


	@Override
	public PartInfoTree loadByEquipmentId(Long equipmentId) {
		// TODO Auto-generated method stub
		String hql = "FROM PartInfoTree WHERE equipmentId = ? AND type = 0";
		Query q = this.getSession().createQuery(hql).setLong(0, equipmentId);
		q.setFirstResult(0);
		q.setMaxResults(1);
		@SuppressWarnings("unchecked")
		List<PartInfoTree> list = q.list();
		if(list != null && !list.isEmpty())
			return list.get(0);
		return null;
	}


	@Override
	public List<PartInfoTree> getNextReplaceByDate(String beginDate,
			String endDate) {
		// TODO Auto-generated method stub
		String hql = "FROM PartInfoTree WHERE to_char(nextReDate,'yyyy-MM-dd') between ? and ? and organizationId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(beginDate);
		args.add(endDate);
        args.add(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		return this.find(hql, args.toArray());
	}

}