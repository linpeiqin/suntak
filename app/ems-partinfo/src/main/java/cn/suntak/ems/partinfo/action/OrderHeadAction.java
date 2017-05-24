package cn.suntak.ems.partinfo.action;


import java.lang.reflect.Field;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.suntak.ems.partinfo.service.OrderLineService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.json.JSONObject;
import cn.oz.org.json.JSONArray;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.partinfo.domain.OrderHead;
import cn.suntak.ems.partinfo.domain.OrderLine;
import cn.suntak.ems.partinfo.service.OrderHeadService;


/**
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderHeadAction extends EMSCRUDAction<OrderHead, OrderHeadService> {

    private OrderLineService orderLineService;

    @Override
    public void initAction() {
        super.initAction();
        this.orderLineService = this.getServiceBean("orderLineService");
    }

    public ActionForward getOrderLineJson(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = this.getFileId(request);
        JSONObject json = new JSONObject();
        OrderHead orderHead = this.getService().load(id);
        if (orderHead == null) {
            return null;
        }
        List<OrderLine> orderLines = this.orderLineService.findByHeadId(id);
        if (orderLines != null && orderLines.size() > 0) {
            json.put("total", orderLines.size());
            cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
            for (OrderLine orderLine : orderLines) {
                JSONObject row = new JSONObject();
                Field[] fields = orderLine.getClass().getDeclaredFields();
                for (Field field : fields) {
                    field.setAccessible(true);
                    try {
                        row.put(field.getName(), field.get(orderLine));
                    } catch (IllegalArgumentException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    }
                }
                array.add(row);
            }
            json.put("rows", array);
        } else {
            json.put("total", 0);
            json.put("rows", new JSONArray());
        }
        return this.renderJson(response, json);
    }
}