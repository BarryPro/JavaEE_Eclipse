package com.sitech.acctmgr.atom.domains.pub;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class pubUpdateEntity implements Serializable{

	@JSONField(name = "UPDATE_ACCEPT")
    private long updateAccept;
	
	@JSONField(name = "UPDATE_TYPE")
    private String updateType;
	
	@JSONField(name = "UPDATE_DATE")
    private String updateDate;
	
	@JSONField(name = "UPDATE_LOGIN")
    private String updateLogin;
	
	@JSONField(name = "UPDATE_CODE")
    private String updateCode;
	
	

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "pubUpdateEntity [updateAccept=" + updateAccept + ", updateType=" + updateType + ", updateDate=" + updateDate
				+ ", updateLogin=" + updateLogin + ", updateCode=" + updateCode + "]";
	}
	
	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}


	public long getUpdateAccept() {
		return updateAccept;
	}

	public void setUpdateAccept(long updateAccept) {
		this.updateAccept = updateAccept;
	}

	public String getUpdateType() {
		return updateType;
	}

	public void setUpdateType(String updateType) {
		this.updateType = updateType;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateLogin() {
		return updateLogin;
	}

	public void setUpdateLogin(String updateLogin) {
		this.updateLogin = updateLogin;
	}

	public void setUpdateCode(String updateCode) {
		this.updateCode = updateCode;
	}

	public String getUpdateCode() {
		return updateCode;
	}

}
