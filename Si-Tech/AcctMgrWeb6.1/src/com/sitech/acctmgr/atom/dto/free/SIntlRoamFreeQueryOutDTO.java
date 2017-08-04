package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/26.
 */
public class SIntlRoamFreeQueryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "INTL_ROAM_USED", desc = "当前国际漫游已使用量", cons = ConsType.CT001, len = "14", type = "string", memo = "单位：MB")
	private String intlRoamUsed;

	@ParamDesc(path = "INTL_ROAM_FEE", desc = "使用国际漫游产生的费用", cons = ConsType.CT001, len = "14", type = "long", memo = "单位分")
	private long intlRoamFee;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("intlRoamUsed"), intlRoamUsed);
		result.setRoot(getPathByProperName("intlRoamFee"), intlRoamFee);
		return result;
	}

	public String getIntlRoamUsed() {
		return intlRoamUsed;
	}

	public void setIntlRoamUsed(String intlRoamUsed) {
		this.intlRoamUsed = intlRoamUsed;
	}

	public long getIntlRoamFee() {
		return intlRoamFee;
	}

	public void setIntlRoamFee(long intlRoamFee) {
		this.intlRoamFee = intlRoamFee;
	}
}
