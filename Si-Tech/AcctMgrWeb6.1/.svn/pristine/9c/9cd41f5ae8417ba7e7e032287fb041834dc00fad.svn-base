package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCRMIntellPrtCollectOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="Long",len="20",desc="流水",memo="略")
	private long loginAccept;
	
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		return result;
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
