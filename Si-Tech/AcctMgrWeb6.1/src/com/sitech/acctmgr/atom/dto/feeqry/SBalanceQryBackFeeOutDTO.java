package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBalanceQryBackFeeOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "REFUND_MONEY", cons = ConsType.CT001, type = "long", len = "20", desc = "可退预存", memo = "略")
	private long refundMoney = 0;
	@ParamDesc(path = "NO_REFUND_MONEY", cons = ConsType.CT001, type = "long", len = "20", desc = "不可退预存", memo = "略")
	private long noRefundMoney = 0;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("refundMoney"), refundMoney);
		result.setRoot(getPathByProperName("noRefundMoney"), noRefundMoney);
		log.info(result.toString());
		return result;
	}

	public long getRefundMoney() {
		return refundMoney;
	}

	public void setRefundMoney(long refundMoney) {
		this.refundMoney = refundMoney;
	}

	public long getNoRefundMoney() {
		return noRefundMoney;
	}

	public void setNoRefundMoney(long noRefundMoney) {
		this.noRefundMoney = noRefundMoney;
	}

}
