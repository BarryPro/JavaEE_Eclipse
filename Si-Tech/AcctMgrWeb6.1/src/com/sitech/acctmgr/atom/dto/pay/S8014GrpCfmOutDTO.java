package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8014GrpCfmOutDTO extends CommonOutDTO{
	
	@JSONField(name="LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="18",desc="转账流水",memo="略")
	private long loginAccept;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("loginAccept"), loginAccept);
		log.info(result.toString());
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
