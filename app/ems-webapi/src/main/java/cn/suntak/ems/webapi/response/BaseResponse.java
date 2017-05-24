package cn.suntak.ems.webapi.response;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by linking
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "baseResponse")
public class BaseResponse {
	   
	@XmlElement(name = "state")
	    private int state;
	@XmlElement(name = "stateDescription")
	    private String stateDescription;
	@XmlElement(name = "formId")
		private Long formId;

	public Long getFormId() {
		return formId;
	}

	public void setFormId(Long formId) {
		this.formId = formId;
	}

	public int getState() {
			return state;
		}

		public void setState(int state) {
			this.state = state;
		}

		public String getStateDescription() {
			return stateDescription;
		}

		public void setStateDescription(String stateDescription) {
			this.stateDescription = stateDescription;
		}
}
