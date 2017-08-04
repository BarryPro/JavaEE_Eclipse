package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookPreholdingDeductOutDTO extends CommonOutDTO {
	@ParamDesc(path = "CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "预占扣减流量额度", memo = "单位：KB")
	private String chargeValue;

	@Override
	public MBean encode() {
		MBean m = super.encode();
		m.setRoot(getPathByProperName("chargeValue"), chargeValue);
		return m;
	}

	public String getChargeValue() {
		return chargeValue;
	}

	public void setChargeValue(String chargeValue) {
		this.chargeValue = chargeValue;
	}

}
