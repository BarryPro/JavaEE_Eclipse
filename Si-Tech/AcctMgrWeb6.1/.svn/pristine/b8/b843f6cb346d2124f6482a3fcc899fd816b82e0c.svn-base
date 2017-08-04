package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class StatusDispBill {
	@JSONField(name = "PARENT_ITEM_ID")
	@ParamDesc(path = "PARENT_ITEM_ID", cons = ConsType.CT001, len = "10", type = "string", desc = "7大类ID", memo = "")
	private String parentItemId;

	@JSONField(name = "ITEM_NAME")
	@ParamDesc(path = "ITEM_NAME", cons = ConsType.CT001, len = "64", type = "string", desc = "账单项名称", memo = "")
	private String itemName;

	@JSONField(name = "FEE")
	@ParamDesc(path = "FEE", cons = ConsType.CT001, len = "", type = "long", desc = "账单费用", memo = "")
	private long fee;

	@JSONField(name = "ITEM_ID")
	@ParamDesc(path = "ITEM_ID", cons = ConsType.CT001, len = "10", type = "string", desc = "账单项", memo = "")
	private String itemId; 
	
	@JSONField(name = "SHOULD_PAY")
	@ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "", type = "long", desc = "应收", memo = "")
	private long shouldPay;
	@JSONField(name = "FAVOUR_FEE")
	@ParamDesc(path = "FAVOUR_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "优惠", memo = "")
	private long favourFee;
	@JSONField(name = "PAYED_PREPAY")
	@ParamDesc(path = "PAYED_PREPAY", cons = ConsType.CT001, len = "", type = "long", desc = "划拨", memo = "")
	private long payedPrepay;
	@JSONField(name = "PAYED_LATER")
	@ParamDesc(path = "PAYED_LATER", cons = ConsType.CT001, len = "", type = "long", desc = "新交款 ", memo = "")
	private long payedLater;
	@JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, len = "", type = "long", desc = "欠费", memo = "")
	private long oweFee;
	
	@JSONField(name="STATUS_NAME")
	@ParamDesc(path="STATUS_NAME",cons=ConsType.CT001,type="String",len="20",desc="帐单状态",memo="略")
	private String statusName;
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="String",len="6",desc="帐单账期",memo="略")
	private String billCycle;
	
	public String getParentItemId() {
		return parentItemId;
	}
	public void setParentItemId(String parentItemId) {
		this.parentItemId = parentItemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public long getFee() {
		return fee;
	}
	public void setFee(long fee) {
		this.fee = fee;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
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
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	/**
	 * @return the billCycle
	 */
	public String getBillCycle() {
		return billCycle;
	}
	/**
	 * @param billCycle the billCycle to set
	 */
	public void setBillCycle(String billCycle) {
		this.billCycle = billCycle;
	}
	
	
}
