package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayMoreQryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="15",desc="最近缴费金额",memo="单位：分")
	protected long payMoney = 0;
	@ParamDesc(path="CONSUME_FEE",cons=ConsType.CT001,type="long",len="15",desc="上月冲销金费",memo="单位：分")
	protected long consumeFee = 0;
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="6",desc="缴费时间",memo="略")
	protected String opTime = "";
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("consumeFee"), consumeFee);
		result.setRoot(getPathByProperName("opTime"), opTime);

		return result;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the consumeFee
	 */
	public long getConsumeFee() {
		return consumeFee;
	}

	/**
	 * @param consumeFee the consumeFee to set
	 */
	public void setConsumeFee(long consumeFee) {
		this.consumeFee = consumeFee;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
}
