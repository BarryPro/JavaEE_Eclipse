package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
@SuppressWarnings("serial")
public class VolumeBookTransferOutDTO extends CommonOutDTO {
	@ParamDesc(path = "CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "转移流量总额度", memo = "与入参中转移总额度一致；转移某一笔失败，则全部失败，为一笔事务；")
	private String chargeValue;
	@ParamDesc(path = "TYPE_ALL_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "转出用户账本类型下的总流量", memo = "单位:KB")
	private String typeAllValue;
	
	@Override
	public MBean encode() {
		MBean mBean = super.encode();
		mBean.setRoot(getPathByProperName("chargeValue"), chargeValue);
		mBean.setRoot(getPathByProperName("typeAllValue"), typeAllValue);
		return mBean;
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
