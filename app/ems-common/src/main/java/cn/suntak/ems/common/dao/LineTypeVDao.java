package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.LineTypeV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface LineTypeVDao {

	List<LineTypeV> getLineTypeList();

	LineTypeV getLineTypeBy(String lineTypeId);
}
