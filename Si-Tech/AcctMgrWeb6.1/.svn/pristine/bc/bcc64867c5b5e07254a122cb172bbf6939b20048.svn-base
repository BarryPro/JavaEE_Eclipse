package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

public class EchgCardRdInfoEntity implements Serializable {
    
	private static final long serialVersionUID = 1L;

	@JSONField(name="CARD_NO")
	@ParamDesc(path="CARD_NO",cons=ConsType.CT001,type="string",len="40",desc="卡序列号/卡号",memo="略")
	protected String cardNo;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="40",desc="充值号码",memo="略")
	protected String phoneNo;
	
	@JSONField(name="CHARGE_AMOUNT")
	@ParamDesc(path="CHARGE_AMOUNT",cons=ConsType.CT001,type="long",len="18",desc="卡金额",memo="略")
	protected long chargeAmount;
	
	@JSONField(name="VALID_TIME")
	@ParamDesc(path="VALID_TIME",cons=ConsType.CT001,type="string",len="20",desc="终止日期",memo="略")
	protected String validTime;
	
	@JSONField(name="TRADE_TIME")
	@ParamDesc(path="TRADE_TIME",cons=ConsType.CT001,type="string",len="20",desc="交易时间",memo="略")
	protected String tradeTime;
	
	@JSONField(name="CARD_STATE")
	@ParamDesc(path="CARD_STATE",cons=ConsType.CT001,type="string",len="40",desc="卡状态名称",memo="略")
	protected String cardState;

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getChargeAmount() {
		return chargeAmount;
	}

	public void setChargeAmount(long chargeAmount) {
		this.chargeAmount = chargeAmount;
	}

	public String getValidTime() {
		return validTime;
	}

	public void setValidTime(String validTime) {
		this.validTime = validTime;
	}

	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}

	public String getCardState() {
		return cardState;
	}

	public void setCardState(String cardState) {
		this.cardState = cardState;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[cardNo:" + cardNo + ",phoneNo:" + phoneNo + ",chargeAmount:"
				+ chargeAmount + ",validTime:" + validTime + ",tradeTime:"
				+ tradeTime + ",cardState:" + cardState + "]";
	}
	
	
}
