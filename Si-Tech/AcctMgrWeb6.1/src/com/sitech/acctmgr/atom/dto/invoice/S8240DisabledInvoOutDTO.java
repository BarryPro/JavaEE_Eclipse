package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
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
public class S8240DisabledInvoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7135020825005732198L;

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, type = "long", len = "1", desc = "操作流水", memo = "略")
	private long loginAccept;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("loginAccept"), this.loginAccept);
		return result;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

}
