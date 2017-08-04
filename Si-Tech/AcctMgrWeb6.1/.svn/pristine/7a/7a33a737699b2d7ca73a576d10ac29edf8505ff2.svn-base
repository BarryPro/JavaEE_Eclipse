package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl
 *
 */
public class SDnyCreditCfmOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, len = "", type = "string", desc = "操作流水", memo = "略")
	private String loginAccept;

	@Override
	public MBean encode() {
		MBean result = super.encode();

		result.setRoot(getPathByProperName("loginAccept"), loginAccept);

		return result;
	}

}
