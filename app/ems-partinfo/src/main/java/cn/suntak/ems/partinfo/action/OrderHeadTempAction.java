package cn.suntak.ems.partinfo.action;


import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.exception.CannotDeleteEntityException;
import cn.oz.exception.OzException;
import cn.oz.web.util.ActionUtils;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.partinfo.domain.PRHead;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.json.JSONObject;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONException;
import cn.oz.util.BeanUtils;
import cn.oz.util.DateTimeUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.partinfo.domain.OrderHeadTemp;
import cn.suntak.ems.partinfo.domain.OrderLineTemp;
import cn.suntak.ems.partinfo.service.OrderHeadTempService;
import org.springframework.dao.DataAccessException;


/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderHeadTempAction extends EMSCRUDAction<OrderHeadTemp, OrderHeadTempService> {
    private FileNumberService fileNumberService;

    @Override
    public void initAction() {
        super.initAction();
        this.fileNumberService = this.getServiceBean("fileNumberService");
    }

    @Override
    protected void save(HttpServletRequest request, ActionForm form, OrderHeadTemp domain) throws Exception {
        if (domain.getOrderNo()==null || domain.getOrderNo().equals("")) {
            String orderNo = this.fileNumberService.doCreateNumber("CKDH");
            domain.setOrderNo(orderNo);
        }
        super.save(request, form, domain);
    }

    @Override
    protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, OrderHeadTemp domain, JSONObject json) throws Exception {
        json.put("orderNo",domain.getOrderNo());
    }

    @Override
    protected void afterSubmitEBS(Long id, String fileName, JSONObject json) {
        OrderHeadTemp orderHeadTemp = this.getService().load(id);
        if (json.get("flag").equals("Y")){
            orderHeadTemp.setEbsState(OrderHeadTemp.SUCCESS);
        } else {
            if(!orderHeadTemp.getEbsState().equals(OrderHeadTemp.SUCCESS)){
                orderHeadTemp.setEbsState(OrderHeadTemp.FAIL);
            }
        }
        this.getService().save(orderHeadTemp);
    }

    @Override
    public OrderHeadTemp getDomain(HttpServletRequest request, ActionForm form) throws Exception {
        long id = this.getFileId(request);
        OrderHeadTemp domain = null;
        if (this.isBlankId(id)) {
            domain = this.createDomain(request, form);
        } else {
            domain = this.loadDomain(request, form, id);
        }

        if (null == domain) {
            return null;
        } else {
            BeanUtils.copyProperties(domain, form);
            String orderLineTempsStr = RequestUtils.getStringParameter(request, "orderLineTemps1", "");
            Long orgId = Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode());
            if (!orderLineTempsStr.equals("")) {
                JSONArray array = new JSONArray(orderLineTempsStr);
                Set<OrderLineTemp> orderLineTempSet = null;
                if (domain.getOrderLineTemps() == null) {
                    orderLineTempSet = new HashSet<OrderLineTemp>();
                } else {
                    orderLineTempSet = domain.getOrderLineTemps();
                    orderLineTempSet.clear();
                }
                for (int i = 0; i < array.length(); i++) {
                    OrderLineTemp orderLineTemp = new OrderLineTemp();
                    this.setOrderLineTempInfo(orderLineTemp, array.getJSONObject(i));
                    orderLineTemp.setOrganizationId(orgId);
                    orderLineTemp.setOrderHeadTemp(domain);
                    orderLineTempSet.add(orderLineTemp);
                }
                domain.setOrderLineTemps(orderLineTempSet);
            }
            return domain;
        }
    }
    private void setOrderLineTempInfo(OrderLineTemp orderLineTemp, cn.oz.org.json.JSONObject obj) {
        JSONArray names = obj.names();
        for (int j = 0; j < names.length(); j++) {
            String fieldName = null;
            try {
                fieldName = names.get(j).toString();
                if (fieldName.equals("orderHeadTemp")) continue;
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            String fieldValue = null;

            try {
                fieldValue = obj.get(names.get(j).toString()).toString();
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            Field field = null;
            try {
                field = orderLineTemp.getClass().getDeclaredField(fieldName);
            } catch (SecurityException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (NoSuchFieldException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            if (field != null) {
                Class<?> clas = field.getType();
                field.setAccessible(true);
                if (clas.toString().equals("class java.util.Date")) {
                    try {
                        field.set(orderLineTemp, DateTimeUtils.getDate(fieldValue));
                    } catch (IllegalArgumentException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    continue;
                }
                if (clas.toString().equals("class java.lang.Integer")) {
                    try {
                        field.set(orderLineTemp, Integer.valueOf(fieldValue));
                    } catch (IllegalArgumentException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    continue;
                }
                if (clas.toString().equals("class java.lang.Long")) {
                    try {
                        field.set(orderLineTemp, Long.valueOf(fieldValue));
                    } catch (IllegalArgumentException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    continue;
                }
                if (clas.toString().equals("class java.lang.Double")) {
                    try {
                        field.set(orderLineTemp, Double.parseDouble(fieldValue));
                    } catch (NumberFormatException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IllegalArgumentException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    continue;
                }
                try {
                    field.set(orderLineTemp, fieldValue);
                } catch (IllegalArgumentException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }

    public ActionForward getOrderLineTempJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        long id = this.getFileId(request);
        JSONObject json = new JSONObject();
        OrderHeadTemp orderHead = this.getService().load(id);
        if (orderHead==null){
            return null;
        }
        Set<OrderLineTemp> orderLineTemps = orderHead.getOrderLineTemps();
        if(orderLineTemps!=null&&orderLineTemps.size()>0){
            json.put("total",orderLineTemps.size());
            cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
            for(OrderLineTemp orderLineTemp: orderLineTemps){
                JSONObject row = new JSONObject();
                Field[] fields = orderLineTemp.getClass().getDeclaredFields();
                for(Field field :fields){
                    field.setAccessible(true);
                    try {
                        row.put(field.getName(), field.get(orderLineTemp));
                    } catch (IllegalArgumentException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    }
                }
                array.add(row);
            }
            json.put("rows", array);
        }else{
            json.put("total", 0);
            json.put("rows", new JSONArray());
        }
        return this.renderJson(response, json);
    }
    @Override
    public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
            throws Exception
    {
        JSONObject json = new JSONObject();
        json.put("result", Boolean.valueOf(true));
        json.put("msg", ActionUtils.getDeleteMsg());

        Long[] deleteIds = ActionUtils.getFileIds(request);
        if ((null != deleteIds) && (deleteIds.length > 0)) {
            try
            {
                OrderHeadTemp orderHeadTemp = null;
                List<Long> idList = new ArrayList<Long>();
                for(int i = 0 ;i<deleteIds.length ;i++){
                    orderHeadTemp = this.getService().load(deleteIds[i]);
                    if(orderHeadTemp.getEbsState().equals(orderHeadTemp.SUCCESS))
                    {
                        continue;
                    }
                    idList.add(deleteIds[i]);
                }
                if(idList != null && !idList.isEmpty()){
                    Long[] ids = (Long[])idList.toArray(new Long[idList.size()]);
                    beforeDelete(request, form, ids);
                    delete(request, form, ids);
                }else{
                    json.put("result", Boolean.valueOf(false));
                    json.put("msg", "已经同步的不能删除");
                }

            } catch (DataAccessException e) {
                this.logger.error(e.getMessage(), e);
                return renderExceptionWithAjax(response, new CannotDeleteEntityException());
            } catch (OzException e) {
                this.logger.error(e.getMessage(), e);
                return forwardErrorWithAjax(response, e.getMessage());
            } catch (Exception e) {
                this.logger.error(e.getMessage(), e);
                return renderExceptionWithAjax(response, e);
            }
        }
        return renderJson(response, json.toString());
    }
}