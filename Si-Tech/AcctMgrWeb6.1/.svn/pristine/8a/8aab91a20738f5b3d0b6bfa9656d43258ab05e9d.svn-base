package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAgentOprInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2851545009663589167L;
	@ParamDesc(path="RETURN_INFO",cons=ConsType.CT001,type="String",len="1000",desc="返回信息",memo="略")
	private String returnInfo;
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="18",desc="操作流水",memo="略")
	private String loginAccept;
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("returnInfo"), returnInfo);
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);

		return result;
	}

	/**
	 * @return the returnInfo
	 */
	public String getReturnInfo() {
		return returnInfo;
	}

	/**
	 * @param returnInfo the returnInfo to set
	 */
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
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

}
