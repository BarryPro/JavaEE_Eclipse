package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

@SuppressWarnings("serial")
public class BroadBillEntity implements Serializable {
	
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="int",len="6",desc="账期年月",memo="略")
	private int billCycle;
	
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="20",desc="应缴费",memo="略")
	private long shouldPay;
	
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="20",desc="优惠费",memo="略")
	private long favourFee;
	
	@JSONField(name="PAYED_PREPAY")
	@ParamDesc(path="PAYED_PREPAY",cons=ConsType.CT001,type="long",len="20",desc="预存划拨",memo="略")
	private long payedPrepay;
	
	@JSONField(name="PAYED_LATER")
	@ParamDesc(path="PAYED_LATER",cons=ConsType.CT001,type="long",len="20",desc="缴费冲销",memo="略")
	private long payedLater;
	
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费",memo="略")
	private long oweFee;
	
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.CT001,type="String",len="30",desc="状态名称",memo="略")
	private String status;
	
	@JSONField(name = "ITEM_NAME")
	@ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, type = "String", len = "30", desc = "账目项名称", memo = "")
	private String itemName;
	
	@JSONField(name="PAYED_DELAY")
	@ParamDesc(path="PAYED_DELAY",cons=ConsType.CT001,type="long",len="20",desc="已冲销滞纳金",memo="略")
	private long payedDelay;

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	public long getFavourFee() {
		return favourFee;
	}

	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}

	public long getPayedPrepay() {
		return payedPrepay;
	}

	public void setPayedPrepay(long payedPrepay) {
		this.payedPrepay = payedPrepay;
	}

	public long getPayedLater() {
		return payedLater;
	}

	public void setPayedLater(long payedLater) {
		this.payedLater = payedLater;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public long getPayedDelay() {
		return payedDelay;
	}

	public void setPayedDelay(long payedDelay) {
		this.payedDelay = payedDelay;
	}

}
