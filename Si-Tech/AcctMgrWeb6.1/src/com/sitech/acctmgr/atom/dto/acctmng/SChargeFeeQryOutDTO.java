package com.sitech.acctmgr.atom.dto.acctmng;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SChargeFeeQryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="OFF_TYPE")
	@ParamDesc(path="OFF_TYPE",cons=ConsType.CT001,type="String",len="1",desc="开关标志",memo="")
	protected String offType;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("offType"), offType);

		return result;
	}

	/**
	 * @return the offType
	 */
	public String getOffType() {
		return offType;
	}

	/**
	 * @param offType the offType to set
	 */
	public void setOffType(String offType) {
		this.offType = offType;
	}
}
