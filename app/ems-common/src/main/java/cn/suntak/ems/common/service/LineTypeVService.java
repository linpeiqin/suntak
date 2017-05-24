package cn.suntak.ems.common.service;

import java.util.List;

import cn.suntak.ems.common.domain.LineTypeV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface LineTypeVService {
    List<LineTypeV> getLineTypeList();

    LineTypeV getLineTypeVBy(String lineTypeId);
}
