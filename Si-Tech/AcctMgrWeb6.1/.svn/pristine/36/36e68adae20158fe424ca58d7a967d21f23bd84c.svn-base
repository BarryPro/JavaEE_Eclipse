package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
@SuppressWarnings("serial")
public class VolumeBookDelayOutDTO extends CommonOutDTO {
	@ParamDesc(path = "IN_RESOURCE_BALANCE_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "要延期的流量账本", memo = "")
	private String inBalanceId;
	@ParamDesc(path = "BALANCE_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "延期后的流量帐本", memo = "")
	private String balanceId;

	@Override
	public MBean encode() {
		MBean mBean = super.encode();
		mBean.setRoot(getPathByProperName("inBalanceId"), inBalanceId);
		mBean.setRoot(getPathByProperName("balanceId"), balanceId);
		return mBean;
	}

	public String getInBalanceId() {
		return inBalanceId;
	}

	public void setInBalanceId(String inBalanceId) {
		this.inBalanceId = inBalanceId;
	}

	public String getBalanceId() {
		return balanceId;
	}

	public void setBalanceId(String balanceId) {
		this.balanceId = balanceId;
	}
}
