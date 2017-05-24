package cn.suntak.ems.transdata.service;


import cn.oz.json.JSONObject;

public interface TransDataService {

    JSONObject exeSql(Long id, String fileName);

    JSONObject submitEBS(Long id, String type);
}
