package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8510OutDTO extends CommonOutDTO{
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
	@JSONField(name="OPEN_RESULT1")
	@ParamDesc(path="OPEN_RESULT1",cons=ConsType.CT001,type="String",len="20",desc="封顶标志",memo="0：不封顶；1：有封顶")
	protected String openResult1;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		result.setRoot(getPathByProperName("openResult"), openResult);
		result.setRoot(getPathByProperName("openResult1"), openResult1);
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

	/**
	 * @return the openResult1
	 */
	public String getOpenResult1() {
		return openResult1;
	}

	/**
	 * @param openResult1 the openResult1 to set
	 */
	public void setOpenResult1(String openResult1) {
		this.openResult1 = openResult1;
	}
}
