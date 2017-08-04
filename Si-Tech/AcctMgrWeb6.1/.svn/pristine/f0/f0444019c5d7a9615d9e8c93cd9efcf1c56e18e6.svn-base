package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8229CfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2314649660716807429L;
	
	
	@JSONField(name="RETURN_CODE")
	@ParamDesc(path="RETURN_CODE",cons=ConsType.CT001,type="String",len="40",desc="返回代码",memo="略")
	private String returnCode;
	
	@Override
    public MBean encode() {
        MBean result = new MBean();
        result.setBody(getPathByProperName("returnCode"), returnCode);
        return result;
    }

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

}
