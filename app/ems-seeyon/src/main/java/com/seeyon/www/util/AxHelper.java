package com.seeyon.www.util;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import org.apache.axis2.AxisFault;

import com.seeyon.www.BPMService.BPMServiceStub;
import com.seeyon.www.authorityService.AuthorityServiceStub;
import com.seeyon.www.authorityService.ServiceException;

/**
 * Created by linking on 2016/11/26.
 */
public class AxHelper {
    public static Map<String,String > callOaInterface(String templateCode, String data) {
        //获取身份令牌
        Map<String, String> reMap = new HashMap<String, String>();
        try {
            AuthorityServiceStub authorityStub = new AuthorityServiceStub();
            AuthorityServiceStub.Authenticate authenticate = new AuthorityServiceStub.Authenticate();
            authenticate.setUserName("service-admin");  //接口登录名 service-admin
            authenticate.setPassword("123456");  //接口密码 123456
            AuthorityServiceStub.AuthenticateResponse authenticateResp = authorityStub.authenticate(authenticate);
            AuthorityServiceStub.UserToken userToken = authenticateResp.get_return();  //得到令牌
            String token = userToken.getId();
            //发起流程表单
            BPMServiceStub BPMServiceStub = new BPMServiceStub();
            BPMServiceStub.LaunchFormCollaboration launchFormCollaboration = new BPMServiceStub.LaunchFormCollaboration();
            launchFormCollaboration.setToken(token);
            launchFormCollaboration.setSenderLoginName("ems");  //发起者的登录名（登录协同的登录名）
            launchFormCollaboration.setTemplateCode(templateCode);  //模板编号
            launchFormCollaboration.setSubject("");  //协同的标题
//            System.out.println(data);
            launchFormCollaboration.setData(data);  //XML格式的表单数据
            BPMServiceStub.LaunchFormCollaborationResponse launchFormCollaborationResp = BPMServiceStub.launchFormCollaboration(launchFormCollaboration);
            BPMServiceStub.ServiceResponse serviceResp = launchFormCollaborationResp.get_return();
            Long errorNumber = serviceResp.getErrorNumber();  //错误代码
            String errorMessage = serviceResp.getErrorMessage();  //错误消息
            Long processId = serviceResp.getResult();  //流程ID
//          System.out.println(processId+"  errorNumber "+errorNumber+" errorMessage  "+errorMessage);
            if (errorNumber==0 && processId!=null && processId!=-1){
                reMap.put("flag","s");
                reMap.put("processId",String.valueOf(processId));
                return reMap;
            }
            reMap.put("flag","e");
            reMap.put("errorNumber",String.valueOf(errorNumber));
            reMap.put("errorMessage",String.valueOf(errorMessage));
        } catch (AxisFault axisFault) {
            axisFault.printStackTrace();
        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (ServiceException e) {
            e.printStackTrace();
        } catch (com.seeyon.www.BPMService.ServiceException e) {
            e.printStackTrace();
        }
        return reMap;
    }
}
