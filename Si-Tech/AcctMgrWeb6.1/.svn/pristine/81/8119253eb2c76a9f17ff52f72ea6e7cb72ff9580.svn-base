package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class LoginNoInfo implements Serializable {

	/**
	 * 
	 */
	public LoginNoInfo() {
		// TODO Auto-generated constructor stub
	}

	// 审批工号
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, type = "String", len = "15", desc = "工号", memo = "略")
	private String loginNo;

	@JSONField(name = "LOGIN_NAME")
	@ParamDesc(path = "LOGIN_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "工号名称", memo = "略")
	private String loginName;

	/**
	 * @return the loginName
	 */
	public String getLoginName() {
		return loginName;
	}

	/**
	 * @param loginName
	 *            the loginName to set
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	@Override
	public String toString() {
		return "LoginNoInfo [loginNo=" + loginNo + ", loginName=" + loginName + "]";
	}

}
