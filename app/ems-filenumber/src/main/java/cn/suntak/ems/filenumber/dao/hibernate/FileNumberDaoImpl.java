package cn.suntak.ems.filenumber.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import cn.oz.SourceFile;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.filenumber.dao.FileNumberDao;
import cn.suntak.ems.filenumber.domain.FileNumber;
import cn.oz.util.StringUtils;

public class FileNumberDaoImpl extends SimpleDaoImpl<FileNumber, Long> implements FileNumberDao {

	public void getPage(Page page, String unitId) {
		String hql = "select alias ";
		List<Object> args = new ArrayList<Object>();
		hql += "from FileNumber alias where alias.unitId = ? ";

		args.add( unitId );
		
		hql += " order by alias.numberOrder  DESC";
		this.getPage(page, hql, args.toArray(),"alias",page.getOrder());
	}
	
	// 查找唯一的流水编号记录
	public FileNumber findUnique(String unitId,String code) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from FileNumber alias where alias.unitId=? ";
		args.add( unitId );

		hql += " and alias.numberCode = ? ";
		args.add( code );
		
		return (FileNumber) this.findUnique(hql, args.toArray());
	}


	public List<FileNumber> findByIDs(Long[] ids) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from FileNumber alias where 1=1 ";
		if (null != ids && ids.length > 0) {
			hql += " and alias.id in( ";
			String tempHql = "";
			for (int i = 0; i < ids.length; i++) {
				if (tempHql.length() > 0)
					tempHql += ",";
				tempHql += " ? ";
				args.add(ids[i]);
			}
			hql += tempHql;
			hql += " ) ";
		}

		hql += " order by alias.numberOrder  DESC";
		return this.find(hql, args.toArray());
	}
	

	public int updateStatus(long id, int value) {
		List<Object> args = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer();
		hql.append("update FileNumber alias");
		hql.append(" set alias.status = ?");
		hql.append(" where alias.id = ?");
		args.add(new Integer(value));
		args.add(new Long(id));
		int count = this.createQuery(hql.toString(), args.toArray()).executeUpdate();
		return count;
	}



	@Override
	protected String[] getDbftSearchFields() {
		return new String[] { "serial", "sourceFile.subject" };
	}
}
