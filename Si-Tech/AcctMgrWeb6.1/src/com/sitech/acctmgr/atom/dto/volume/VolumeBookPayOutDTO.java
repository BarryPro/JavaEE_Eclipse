package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
@SuppressWarnings("serial")
public class VolumeBookPayOutDTO extends CommonOutDTO{

	@ParamDesc(path = "CHARGE_VALUE", cons = ConsType.CT001, desc = "充值流量额度", len = "18", memo = "单位:KB")
	private String chargeValue;
	@ParamDesc(path = "TYPE_ALL_VALUE", cons = ConsType.CT001, desc = "账本类型下的总流量", len = "18", memo = "单位:KB")
	private String typeAllValue;
	
	@Override
	public MBean encode() {
		MBean m = super.encode();
		m.setRoot(getPathByProperName("chargeValue"), chargeValue);
		m.setRoot(getPathByProperName("typeAllValue"), typeAllValue);
		return m;
	}
	public String getChargeValue() {
		return chargeValue;
	}
	public void setChargeValue(String chargeValue) {
		this.chargeValue = chargeValue;
	}
	public String getTypeAllValue() {
		return typeAllValue;
	}
	public void setTypeAllValue(String typeAllValue) {
		this.typeAllValue = typeAllValue;
	}
	
}
