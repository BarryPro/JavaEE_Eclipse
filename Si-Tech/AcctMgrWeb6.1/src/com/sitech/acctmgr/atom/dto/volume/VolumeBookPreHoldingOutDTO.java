package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
@SuppressWarnings("serial")
public class VolumeBookPreHoldingOutDTO extends CommonOutDTO{
	@ParamDesc(path = "CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "应预占流量额度", memo = "单位:KB")
	private String chargeValue;
	@ParamDesc(path = "REAL_CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "实际预占流量额度", memo = "单位:KB")
	private String realChargeValue;
	
	@Override
	public MBean encode() {
		MBean mbean = super.encode();
		mbean.setRoot(getPathByProperName("chargeValue"), chargeValue);
		mbean.setRoot(getPathByProperName("realChargeValue"), realChargeValue);
		return mbean;
	}
	public String getChargeValue() {
		return chargeValue;
	}
	public void setChargeValue(String chargeValue) {
		this.chargeValue = chargeValue;
	}
	public String getRealChargeValue() {
		return realChargeValue;
	}
	public void setRealChargeValue(String realChargeValue) {
		this.realChargeValue = realChargeValue;
	}
	
}
