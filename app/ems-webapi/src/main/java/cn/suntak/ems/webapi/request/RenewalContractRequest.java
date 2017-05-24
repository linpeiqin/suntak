package cn.suntak.ems.webapi.request;

import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONException;
import cn.oz.util.DateTimeUtils;
import cn.oz.zop.server.impl.AbstractRequest;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.renewal.domain.RenewalContract;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class RenewalContractRequest extends AbstractRequest{
    private String equipmentDetailsStr;
    private EquipmentDetailsService equipmentDetailsService ;

    public String getEquipmentDetailsStr() {
        return equipmentDetailsStr;
    }

    public void setEquipmentDetailsStr(String equipmentDetailsStr) {
        this.equipmentDetailsStr = equipmentDetailsStr;
    }

    public List<EquipmentDetails> getEDL() throws JSONException {

        String eds = getEquipmentDetailsStr();
        List<EquipmentDetails> edl = new ArrayList<EquipmentDetails>();
        if (eds!=null && !eds.equals("")){
            JSONArray array = new JSONArray(eds);
            for (int i=0;i<array.length();i++){
                cn.oz.org.json.JSONObject json = array.getJSONObject(i);
                Integer qty = json.getInt("qty");
                for(int j=0;j<qty;j++){
                	 EquipmentDetails equipmentDetails = new EquipmentDetails();
                	this.setEquipmentDetailsInfo(equipmentDetails, array.getJSONObject(i));
                	EquipmentDetails entity = this.equipmentDetailsService.loadByAssetId(equipmentDetails.getAssetId());
                    if(entity!=null){
                        entity.setType(5);
                        RenewalContract renewalContract = new RenewalContract();
                        renewalContract.setContractNo(equipmentDetails.getContractNo());
                        renewalContract.setSupplier(equipmentDetails.getSuppliers());
                        renewalContract.setSupplierId(equipmentDetails.getSuppliersId());
                        renewalContract.setWorth(equipmentDetails.getOriginalValue());
                        renewalContract.setCurrency(equipmentDetails.getCurrency());
                        entity.getRenewalContracts().add(renewalContract);
                        edl.add(entity);
                    }

                }
            }
        }
        return edl;
    }
    private void setEquipmentDetailsInfo(EquipmentDetails equipmentDetails, cn.oz.org.json.JSONObject obj) {
        JSONArray names = obj.names();
        for (int j = 0; j < names.length(); j++) {
            String fieldName = null;
            try {
                fieldName = names.get(j).toString();
                if (fieldName.equals("qty")){
                    continue;
                    //  Integer qty = Integer.valueOf(obj.get(names.get(j).toString()).toString());
                }
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
                field = equipmentDetails.getClass().getDeclaredField(fieldName);
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
                        field.set(equipmentDetails, DateTimeUtils.getDate(fieldValue));
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
                        field.set(equipmentDetails, Integer.valueOf(fieldValue));
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
                        field.set(equipmentDetails, Long.valueOf(fieldValue));
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
                        field.set(equipmentDetails, Double.parseDouble(fieldValue));
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
                    field.set(equipmentDetails, fieldValue);
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

    public EquipmentDetailsService getEquipmentDetailsService() {
        return equipmentDetailsService;
    }

    public void setEquipmentDetailsService(EquipmentDetailsService equipmentDetailsService) {
        this.equipmentDetailsService = equipmentDetailsService;
    }
}
