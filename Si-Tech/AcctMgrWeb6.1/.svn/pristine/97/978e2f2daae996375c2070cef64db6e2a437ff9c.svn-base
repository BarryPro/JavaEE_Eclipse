package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class VitualErrEntity {
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", type = "String", desc = "服务号码", memo = "")
	private String phoneNo;
	
	@JSONField(name="ERR_INFO")
	@ParamDesc(path="ERR_INFO",cons=ConsType.CT001,type="String",len="200",desc="错误信息",memo="无")
	protected String errInfo;

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the errInfo
	 */
	public String getErrInfo() {
		return errInfo;
	}

	/**
	 * @param errInfo the errInfo to set
	 */
	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
	}
}
