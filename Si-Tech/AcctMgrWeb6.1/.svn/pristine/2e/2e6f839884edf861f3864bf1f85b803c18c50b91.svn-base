package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCRMIntellPrtQueryInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="20",desc="查询流水",memo="")
	protected long loginAccept;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setLoginAccept(Long.parseLong(arg0.getStr(getPathByProperName("loginAccept"))));
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
