package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/26.
 */
public class SSchoolFreeQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;


	@ParamDesc(path = "NET_TIME_TOTAL", cons = ConsType.CT001, len = "14", type = "String", desc = "宽带上网优惠总时长", memo = "单位：分钟")
	private String netTimeTotal;

	@ParamDesc(path = "NET_TIME_USED", cons = ConsType.CT001, len = "14", type = "String", desc = "宽带上网优惠已用时长", memo = "单位：分钟")
	private String netTimeUsed;
	
	@ParamDesc(path = "NET_TIME_REMAIN", cons = ConsType.CT001, len = "14", type = "String", desc = "宽带上网优惠剩余时长", memo = "单位：分钟")
	private String netTimeRemain;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("netTimeTotal"), netTimeTotal);
		result.setRoot(getPathByProperName("netTimeUsed"), netTimeUsed);
		result.setRoot(getPathByProperName("netTimeRemain"), netTimeRemain);
		return result;
	}

	public String getNetTimeTotal() {
		return netTimeTotal;
	}

	public void setNetTimeTotal(String netTimeTotal) {
		this.netTimeTotal = netTimeTotal;
	}

	public String getNetTimeUsed() {
		return netTimeUsed;
	}

	public void setNetTimeUsed(String netTimeUsed) {
		this.netTimeUsed = netTimeUsed;
	}

	public String getNetTimeRemain() {
		return netTimeRemain;
	}

	public void setNetTimeRemain(String netTimeRemain) {
		this.netTimeRemain = netTimeRemain;
	}

}
