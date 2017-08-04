package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8511OutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="20",desc="流水",memo="略")
	protected String loginAccept;
	@JSONField(name="OPEN_RESULT")
	@ParamDesc(path="OPEN_RESULT",cons=ConsType.CT001,type="String",len="20",desc="封顶标志",memo="")
	protected String openResult;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		result.setRoot(getPathByProperName("openResult"), openResult);

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
	 * @return the openResult
	 */
	public String getOpenResult() {
		return openResult;
	}

	/**
	 * @param openResult the openResult to set
	 */
	public void setOpenResult(String openResult) {
		this.openResult = openResult;
	}
}

