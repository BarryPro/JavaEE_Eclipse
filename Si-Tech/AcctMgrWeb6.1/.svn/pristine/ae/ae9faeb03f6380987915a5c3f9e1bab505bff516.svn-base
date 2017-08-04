package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

public class EchgCardRecdEntity implements Serializable {   
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="CARD_NO")
	@ParamDesc(path="CARD_NO",cons=ConsType.CT001,type="string",len="40",desc="卡序列号/卡号",memo="略")
	protected String cardNo;
	
	@JSONField(name="ACCOUNT_PIN")
	@ParamDesc(path="ACCOUNT_PIN",cons=ConsType.CT001,type="string",len="40",desc="充值呼叫主叫号码",memo="略")
	protected String accountPin;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="40",desc="充值号码",memo="略")
	protected String phoneNo;
	
	@JSONField(name="CHARGE_AMOUNT")
	@ParamDesc(path="CHARGE_AMOUNT",cons=ConsType.CT001,type="long",len="18",desc="卡金额",memo="略")
	protected long chargeAmount;
	
	@JSONField(name="TRADE_TIME")
	@ParamDesc(path="TRADE_TIME",cons=ConsType.CT001,type="string",len="20",desc="交易时间",memo="略")
	protected String tradeTime;
	
	@JSONField(name="TRADE_TYPE")
	@ParamDesc(path="TRADE_TYPE",cons=ConsType.CT001,type="string",len="1",desc="充值方式",memo="略")
	protected String tradeType;
	
	@JSONField(name="TRADE_TYPE_NAME")
	@ParamDesc(path="TRADE_TYPE_NAME",cons=ConsType.CT001,type="string",len="60",desc="充值方式名称",memo="略")
	protected String tradeTypeName;

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getAccountPin() {
		return accountPin;
	}

	public void setAccountPin(String accountPin) {
		this.accountPin = accountPin;
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

	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}

	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}

	public String getTradeTypeName() {
		return tradeTypeName;
	}

	public void setTradeTypeName(String tradeTypeName) {
		this.tradeTypeName = tradeTypeName;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[cardNo:" + cardNo + ",accountPin:" + accountPin + ",phoneNo:"
				+ phoneNo + ",chargeAmount:" + chargeAmount + ",tradeTime:"
				+ tradeTime + ",tradeType:" + tradeType + ",tradeTypeName:"
				+ tradeTypeName + "]";
	}
	
}
