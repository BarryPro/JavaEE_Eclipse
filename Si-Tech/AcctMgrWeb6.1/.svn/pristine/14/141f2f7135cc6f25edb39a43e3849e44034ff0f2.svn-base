package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDataFavOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.OPEN_RESULT",cons=ConsType.QUES,type="String",len="2",desc="操作结果",memo="略")
	private String openResult;
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.QUES,type="long",len="20",desc="操作流水",memo="略")
	private long loginAccept;
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("openResult"), openResult);
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);

		return result;
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
	 * @return the loginAccept
	 */
	public long getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}
	
}
