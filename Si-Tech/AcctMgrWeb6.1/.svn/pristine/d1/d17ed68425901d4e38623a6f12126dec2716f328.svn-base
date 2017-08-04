package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookDeductOutDTO extends CommonOutDTO {

	@ParamDesc(path = "CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "应扣减流量额度", memo = "单位：KB")
	private String chargeValue;
	@ParamDesc(path = "REAL_CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "实际扣减流量额度", memo = "单位：KB")
	private String realChargeValue;
	@ParamDesc(path = "TYPE_ALL_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "账本类型下的总流量", memo = "单位：KB")
	private String typeAllValue;

	@Override
	public MBean encode() {
		MBean mbean = super.encode();
		mbean.setRoot(getPathByProperName("chargeValue"), chargeValue);
		mbean.setRoot(getPathByProperName("realChargeValue"), realChargeValue);
		mbean.setRoot(getPathByProperName("typeAllValue"), typeAllValue);
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

	public String getTypeAllValue() {
		return typeAllValue;
	}

	public void setTypeAllValue(String typeAllValue) {
		this.typeAllValue = typeAllValue;
	}

}
