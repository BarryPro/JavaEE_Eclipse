package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCheckUserInfoOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="FLAG",cons=ConsType.CT001,type="String",len="1",desc="标识",memo="略")
	private String flag;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		
		result.setRoot(getPathByProperName("flag"), flag);
		
		return result;
	}

	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
}
