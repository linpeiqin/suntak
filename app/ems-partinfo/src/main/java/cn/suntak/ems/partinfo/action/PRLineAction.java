package cn.suntak.ems.partinfo.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.AppContext;
import cn.oz.json.JSONObject;
import cn.suntak.ems.common.domain.PRLinesV;
import cn.suntak.ems.common.service.PRLinesVService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.partinfo.domain.PartInfo;
import cn.suntak.ems.partinfo.domain.PartInfoTree;
import cn.suntak.ems.partinfo.service.PartInfoService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.org.json.JSONArray;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.partinfo.domain.PRLine;
import cn.suntak.ems.partinfo.service.PRLineService;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRLineAction extends EMSCRUDAction<PRLine, PRLineService>{

    public ActionForward openPR(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        return mapping.findForward("readPRLine");
    }
    public ActionForward editPR(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("editPRLine");
    }
    
    public ActionForward getLineTypeList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	JSONArray array = this.getService().getLineTypeArray();
    	return this.renderJson(response, array.toString());
    }
    public ActionForward getPRLineJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject json = new JSONObject();
        SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");
        Date sysDate = new Date();
        String endDate = dft.format(sysDate);
        //备件申购预警
        JSONObject json1 = new JSONObject();
        List<PRLine> list = this.getService().getPRLineListByDate(endDate);
        List<Map<String,Object>> packageData = new ArrayList<Map<String,Object>>();
        Integer partNum = 0;
        if(list != null && !list.isEmpty()){
            partNum = list.size();
            for(PRLine pRline : list){
                if(pRline != null){
                    packageData.add(this.packPart(pRline));
                }
            }
        }
        json1.put("PART",partNum);
        json1.put("PARTINFO",packageData);
        json.put("PR",json1);
        json.put("result",true);
        return this.renderJson(response, json);
    }
    private Map<String,Object> packPart(PRLine part){
        Map<String,Object> map = new HashMap<String, Object>();
        PRLine partInfo = part;
        if(partInfo != null){
            map.put("headId", partInfo.getpRHead().getId());
            map.put("itemName", partInfo.getItemName());
            map.put("qty", partInfo.getQty());
        }
        return map;
    }
}