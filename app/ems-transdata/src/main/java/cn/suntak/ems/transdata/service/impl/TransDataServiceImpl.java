package cn.suntak.ems.transdata.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import cn.oz.json.JSONObject;
import org.springframework.core.io.Resource;
import org.springframework.util.xml.DomUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import cn.suntak.ems.transdata.dao.TransDataDao;
import cn.suntak.ems.transdata.service.TransDataService;

public class TransDataServiceImpl implements TransDataService {
    private Logger logger;
    private Resource[] configLocations;
    private TransDataDao transDataDao;
    private Map<String,Map<String,List<String>>> tableMap = null;

    public Map<String,Map<String,List<String>>> initTableMap(){
        if (tableMap==null){
            tableMap = new HashMap<String, Map<String, List<String>>>();
        }
        return tableMap;
    }

    public void setTransDataDao(TransDataDao transDataDao) {
        this.transDataDao = transDataDao;
    }

    public void setConfigLocations(Resource[] configLocations) {
        this.configLocations = configLocations;
    }

    public JSONObject exeSql(Long id , String fileName){
        JSONObject json = new JSONObject();
        try{
            initTableMap();
            initialize(fileName);
            Long ebsId = this.transDataDao.generateId();
            //从实体表插入数据到ebs临时表
            String sql;
            String subTable = this.getMapKey(fileName, 3);
            if(subTable!=null&&!subTable.equals("")){
                sql = initSqls(id,fileName);
                id = ebsId;
            }else{
                sql = initSql(id,fileName);
            }
            sql = sql.replaceAll("EMS_EBS_SEQUENCE.NEXTVAL", ebsId.toString());
            String sqlDelete = getDeleteSql(id,fileName);
            if(fileName.equals("pRHead")){
                sqlDelete = "delete from ems.cux_requisitions_t where cux_pr_id = "+id;
            }
            this.transDataDao.excuteSql(sqlDelete);
            int msgCode = this.transDataDao.excuteSql(sql);
            String msgAndCode = null;
            //如果数据插入成功
            if (msgCode>=1){
                //调用ebs的校验方法，也就是存储过程，接口
                msgAndCode = this.transDataDao.calEBS(id,this.getMapKey(fileName, 2));
                String code = msgAndCode.substring(0,msgAndCode.indexOf("-"));
                String msg = msgAndCode.substring(msgAndCode.indexOf("-")+1,msgAndCode.length());
                json.put("code",code);
                json.put("msg" ,msg);
                if (code.equals("0")){
                    if(fileName.equals("intoFactory")||fileName.equals("intoFactoryAndCheck")){
                        updateToEquipmentDetails(id,fileName);
                        //验收
                        if(fileName.equals("intoFactoryAndCheck")){
                            json =   this.exeSql(id, "intoFactoryAndCheck_Check");
                        }
                    }
                }

                return json;
            }
        }catch(Exception e){
            json.put("code",-1);
            json.put("msg",e.getMessage());
        }

        return json;
    }
    private void updateToEquipmentDetails(Long id, String fileName) throws SQLException, ClassNotFoundException {
        String sql = null;
        sql = "update ems_dm_equipment_details set Asset_id = (" +
                "select asset_id from CUX_INTOFACTORY_T where" +
                " ems_dm_equipment_details.id = CUX_INTOFACTORY_T.CUX_TRANSACTION_ID)" +
                "where ems_dm_equipment_details.id in" +
                " (select CUX_TRANSACTION_ID from  CUX_INTOFACTORY_T where  batch_id = "+id+" )" ;
        this.transDataDao.excuteSql(sql);
    }
    private String getDeleteSql(Long id, String fileName) {
        Map<String ,List<String>> tableFieldMap = tableMap.get(fileName);
        String toTable = this.getMapKey(fileName, 1);
        String sql = "delete from "+toTable+" where batch_id = "+id;
        return sql;
    }
    @Override
    public JSONObject submitEBS(Long id, String type) {
        JSONObject json = new JSONObject();
        String msgAndCode = "";
        if (type.equals("partLYCK")){
            msgAndCode  = this.transDataDao.calEBS(id,"apps.EMS_WEB_SERVICE_PKG.PRO_MISCELL_TRANSACTION");
        }

        if (!msgAndCode.equals("")) {
            String code = msgAndCode.substring(0, msgAndCode.indexOf("-"));
            String msg = msgAndCode.substring(msgAndCode.indexOf("-") + 1, msgAndCode.length());
            json.put("code",code);
            json.put("msg",msg);
            return json;
        }
        json.put("code",-1);
        json.put("msg","此文件不能导入");
        //如何调用接口返回0成功
        return json;
    }

    private String getMapKey(String fileName,int index){
    	int i =0;
        for (String key : tableMap.get(fileName).keySet()){
            if (i==index) {
                return key;
            }
            i++;
        }
        return "";
    }

    private String getTargetId(String fileName){
        int i =0;
        for (String key : tableMap.get(fileName).keySet()){
            if (i==1) {
                return tableMap.get(fileName).get(key).get(0);
            }
            i++;
        }
        return "";
    }
    
    private String initSql(Long id, String fileName) {
        
        Map<String ,List<String>> tableFieldMap = tableMap.get(fileName);
        String toTable = this.getMapKey(fileName, 1);
        String fromTable = this.getMapKey(fileName, 0);
        String sql = "insert into "+toTable+"(";
        int i=1;
        for (String field : tableFieldMap.get(toTable)){
            if (i==1)i++;else sql += ",";
            sql += field;
        }
        sql +=") select ";
        for (String field : tableFieldMap.get(fromTable)){
            if (i==2)i++;else sql += ",";
            sql += field;
        }
        sql +=" from ems_dm_equipment_details " +
                "  join ems_dm_el_configure on ems_dm_equipment_details.id = ems_dm_el_configure.eq_id " +
                "  join "+fromTable+" on ems_dm_el_configure.lc_id = "+fromTable+".life_cycle_id where "+fromTable+".id ="+id;
        return sql;
    }
    private String initSqls(Long id, String fileName) {
        
        Map<String ,List<String>> tableFieldMap = tableMap.get(fileName);
        String toTable = this.getMapKey(fileName, 1);
        String fromTable = this.getMapKey(fileName, 0);
        String subTable = this.getMapKey(fileName, 3);
        String sql = "insert into "+toTable+"(";
        int i=1;
        for (String field : tableFieldMap.get(toTable)){
            if (i==1)i++;else sql += ",";
            sql += field;
        }
        sql +=") select ";
        for (String field : tableFieldMap.get(fromTable)){
            if (i==2)i++;else sql += ",";
            sql += field;
        }
        sql +=" from "+fromTable;
        sql +=" left join "+ subTable ;
        sql +=" on "+fromTable+".ID = "+subTable+".pr_head_id";
        sql +=" where "+fromTable+".id="+id;
        return sql;
    }

    public void initialize(String fileName) {
        if (tableMap.containsKey(fileName)){
            return;
        }
        Resource rs = null;
        for (Resource resource : this.configLocations){
            if (resource.getFilename().contains(fileName)) {
                rs = resource;
                break;
            }
        }

        if (rs!=null && rs.exists()) {
            Document doc = null;
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = null;
            try {
                builder = factory.newDocumentBuilder();
                doc = builder.parse(rs.getInputStream());
            } catch (Exception e) {
                e.printStackTrace();
            }
            Element root = doc.getDocumentElement();
            if (root.hasAttribute("form") && root.hasAttribute("to")) {
                Map<String,List<String>> fieldMap = new LinkedHashMap<String, List<String>>();
                String formTable = root.getAttribute("form");
                String toTable = root.getAttribute("to");
                String method = root.getAttribute("method");
                String subTable = root.getAttribute("subTable");
                List<Element> elements = DomUtils.getChildElements(root);
                List<String> formFields = new ArrayList<String>();
                List<String> toFields = new ArrayList<String>();
                List<String> subFields = new ArrayList<String>();
                List<String> idList =  new ArrayList<String>();
                for (Element element : elements){
                	String dyn =  element.getAttribute("dynatic");
                	String source = element.getAttribute("source");
                    String target = element.getAttribute("target");
                    if (source.equals("ID") && target!=null){
                        idList.add(target);
                    }
                   //动态处理
                    if (dyn!= null && dyn.equals("true")){
                    	if(source.equals("ID")){
                    		source = "'"+getIDByDatabase(source).toString()+"'";
                    	}
                    	if(source.equals("")){
                    		source = "'"+getIDByDatabase(source).toString()+"'";
                    	}
                	}
                    if (!source.isEmpty() && !target.isEmpty()){
                        formFields.add(source);
                        toFields.add(target);
                        subFields.add(subTable);
                    }
                }
                fieldMap.put(formTable,formFields);
                fieldMap.put(toTable,toFields);
                fieldMap.put(method,idList);
                fieldMap.put(subTable, subFields);
                tableMap.put(fileName,fieldMap);
            }
        }
    }
    private Long getIDByDatabase(String source){
    	 return this.transDataDao.generateId();
    }
}
