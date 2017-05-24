
/**
 * ServiceException.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.4.1  Built on : Aug 13, 2008 (05:03:35 LKT)
 */

package com.seeyon.www.authorityService;

public class ServiceException extends java.lang.Exception{
    
    private com.seeyon.www.authorityService.AuthorityServiceStub.ServiceExceptionE faultMessage;
    
    public ServiceException() {
        super("ServiceException");
    }
           
    public ServiceException(java.lang.String s) {
       super(s);
    }
    
    public ServiceException(java.lang.String s, java.lang.Throwable ex) {
      super(s, ex);
    }
    
    public void setFaultMessage(com.seeyon.www.authorityService.AuthorityServiceStub.ServiceExceptionE msg){
       faultMessage = msg;
    }
    
    public com.seeyon.www.authorityService.AuthorityServiceStub.ServiceExceptionE getFaultMessage(){
       return faultMessage;
    }
}
    