package com.sitech.acctmgr.atom.domains.pay;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title: 网状网平台二级返回码  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class RspEntity {
	
	String rspCode;
	
	String repInfo;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "rspEntity [rspCode=" + rspCode + ", repInfo=" + repInfo + "]";
	}
	
	/**
	* 名称：初始化，返回码为0 成功
	*/
	public void init(){
		this.rspCode = "0000";
		this.repInfo = "成功";
	}

	public String getRspCode() {
		return rspCode;
	}

	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}

	public String getRepInfo() {
		return repInfo;
	}

	public void setRepInfo(String repInfo) {
		this.repInfo = repInfo;
	}
}
