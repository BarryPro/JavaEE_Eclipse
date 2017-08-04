package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**   
 * @Description: 按状态查询帐单实体
 * @author:  wangyla
 * @version:
 * @createTime:  2015-5-13 下午5:13:38
 */

public class StatusBillInfoEntity {
	@JSONField(name="ITEM_ID")
	@ParamDesc(path="ITEM_ID",cons=ConsType.CT001,type="String",len="64",desc="账目项",memo="略")
	private String itemId;
	@JSONField(name="ITEM_NAME")
	@ParamDesc(path="ITEM_NAME",cons=ConsType.CT001,type="String",len="64",desc="账目名称",memo="略")
	private String itemName;
	@JSONField(name="REAL_FEE")
	@ParamDesc(path="REAL_FEE",cons=ConsType.CT001,type="long",len="14",desc="实应收",memo="略")
	private long realFee;
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="14",desc="应收金额",memo="略")
	private long shouldPay;
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="14",desc="优惠金额",memo="略")
	private long favourFee;
	@JSONField(name="PAYED_PREPAY")
	@ParamDesc(path="PAYED_PREPAY",cons=ConsType.CT001,type="long",len="14",desc="划拨金额",memo="略")
	private long payedPrepay;
	@JSONField(name="PAYED_LATER")
	@ParamDesc(path="PAYED_LATER",cons=ConsType.CT001,type="long",len="14",desc="新交款金额",memo="略")
	private long payedLater;
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="14",desc="欠费",memo="略")
	private long oweFee;
	
	@JSONField(name="STATUS_NAME")
	@ParamDesc(path="STATUS_NAME",cons=ConsType.CT001,type="String",len="20",desc="帐单状态",memo="略")
	private String statusName;
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="String",len="6",desc="帐单账期",memo="略")
	private String billCycle;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	

	public long getRealFee() {
		return realFee;
	}

	public void setRealFee(long realFee) {
		this.realFee = realFee;
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

