package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SIpShopQueryOutDTO extends CommonOutDTO {

	@ParamDesc(path = "FLAG", desc = "资费名称", cons = ConsType.CT001, type = "String", len = "60", memo = "")
	private String flag;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("flag"), flag);
		
		return result;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}
