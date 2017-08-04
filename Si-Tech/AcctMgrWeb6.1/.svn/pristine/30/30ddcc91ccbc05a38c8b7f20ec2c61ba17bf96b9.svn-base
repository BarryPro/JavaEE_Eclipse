package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8157CreditCfmOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, type = "String", len = "20", desc = "操作流水", memo = "略")
	protected String loginAccept;
	@ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "String", len = "18", desc = "操作日期", memo = "略")
	protected String opTime;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		result.setRoot(getPathByProperName("opTime"), opTime);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the loginAccept
	 */
	public String getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
}
