package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8025CfmOutDTO extends CommonOutDTO {
	
	@JSONField(name="PAY_FLAG")
	@ParamDesc(path="PAY_FLAG",cons=ConsType.CT001,type="String",len="8",desc="请求充值卡平台后成功于否",memo="1:表示成功")
	protected String payFlag;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("payFlag"), payFlag);
		return result;
	}

	/**
	 * @return the payFlag
	 */
	public String getPayFlag() {
		return payFlag;
	}

	/**
	 * @param payFlag the payFlag to set
	 */
	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}
	
}
