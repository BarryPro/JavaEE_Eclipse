package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8203CfmOutDTO extends CommonOutDTO {
	
	@JSONField(name="RETURN_NOTHING")
	@ParamDesc(path="RETURN_NOTHING",cons=ConsType.CT001,type="long",len="18",desc="返回无用值",memo="略")
	private String returnNothing;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("returnNothing"), returnNothing);
		
		return result;
	}
	
	/**
	 * @return the returnNothing
	 */
	public String getReturnNothing() {
		return returnNothing;
	}
	
	/**
	 * @param returnNothing the returnNothing to set
	 */
	public void setReturnNothing(String returnNothing) {
		this.returnNothing = returnNothing;
	}
	
	
	
}
