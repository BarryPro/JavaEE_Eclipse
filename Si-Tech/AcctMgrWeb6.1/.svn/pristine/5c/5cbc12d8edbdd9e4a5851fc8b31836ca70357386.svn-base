package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.LoginNoInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

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
public class S8248QryLoginNoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5157144857260352891L;

	@JSONField(name = "LOGIN_LIST")
	@ParamDesc(path = "LOGIN_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "审批工号列表", memo = "略")
	private List<LoginNoInfo> loginInfo = new ArrayList<LoginNoInfo>();

	public List<LoginNoInfo> getLoginInfo() {
		return loginInfo;
	}

	public void setLoginInfo(List<LoginNoInfo> loginInfo) {
		this.loginInfo = loginInfo;
	}

	public S8248QryLoginNoOutDTO() {

	}

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("loginInfo"), loginInfo);
		return result;
	}

}
