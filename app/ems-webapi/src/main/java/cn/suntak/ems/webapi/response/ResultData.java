package cn.suntak.ems.webapi.response;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlElement;

public class ResultData<T> implements Serializable {
	  private static final long serialVersionUID = -8822360646591880193L;
	  @XmlElement(name = "state")
	  private T data;
	  @XmlElement(name = "result")
	  private boolean result;
	  @XmlElement(name = "message")
	  private String message;
	  @XmlElement(name = "count")
	  private long count = 0L;
	  @XmlElement(name = "status")
	  private Integer status; 
	  
	  public static enum Status{
		    SUCCESS(1000,"操作成功"),
		  	PARAMEX(1001,"参数异常"),
			NOFINDEX(1002,"未找到对象"),
			NOOPER(1003,"权限错误"),
			REOPER(1004,"重复操作"),
			SYSERROR(1005,"系统异常");
			private Status(int status,String value){
				this.status = status;
				this.value = value;
			}
			private int status;
			private String value;
			
			public int getStatus(){
				return this.status;
			}
			public String getValue(){
				return this.value;
			}
	  }
	  
		public T getData() {
			return data;
		}
		public void setData(T data) {
			this.data = data;
		}
		public boolean isResult() {
			return result;
		}
		public void setResult(boolean result) {
			this.result = result;
		}
		public String getMessage() {
			return message;
		}
		public void setMessage(String message) {
			this.message = message;
		}
		public long getCount() {
			return count;
		}
		public void setCount(long count) {
			this.count = count;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}
		
	  
}
