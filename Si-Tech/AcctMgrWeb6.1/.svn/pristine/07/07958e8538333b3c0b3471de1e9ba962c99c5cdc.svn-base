package com.sitech.acctmgr.atom.domains.bill;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author liuhl_bj
 * @version 1.0
 */
@SuppressWarnings("serial")
public class BadBillEntity implements Serializable {

	@JSONField(name = "ID_NO")
	private long idNo;

	@JSONField(name = "CONTRACT_NO")
	private long contractNo;

	@JSONField(name = "SHOULD_PAY")
	private long shouldPay;

	@JSONField(name = "FAVOUR_FEE")
	private long favourFee;

	@JSONField(name = "PAYED_PREPAY")
	private long payedPrepay;

	@JSONField(name = "PAYED_LATER")
	private long payedLater;

	@JSONField(name = "BILL_CYCLE")
	private int billCycle;

	@JSONField(name = "REAL_FEE")
	private long realFee;

	@JSONField(name = "OWE_FEE")
	private long oweFee;

	@JSONField(name = "STATUS")
	private String status;

	@JSONField(name = "BAD_SEVENBILL_LIST")
	private List<BadSevenBillEntity> badSevenBillList;

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
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

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getRealFee() {
		return realFee;
	}

	public void setRealFee(long realFee) {
		this.realFee = realFee;
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

	public List<BadSevenBillEntity> getBadSevenBillList() {
		return badSevenBillList;
	}

	public void setBadSevenBillList(List<BadSevenBillEntity> badSevenBillList) {
		this.badSevenBillList = badSevenBillList;
	}

	@Override
	public String toString() {
		return "BadBillEntity [idNo=" + idNo + ", contractNo=" + contractNo + ", shouldPay=" + shouldPay + ", favourFee=" + favourFee
				+ ", payedPrepay=" + payedPrepay + ", payedLater=" + payedLater + ", billCycle=" + billCycle + ", realFee=" + realFee + ", oweFee="
				+ oweFee + ", status=" + status + ", badSevenBillList=" + badSevenBillList + "]";
	}

}
