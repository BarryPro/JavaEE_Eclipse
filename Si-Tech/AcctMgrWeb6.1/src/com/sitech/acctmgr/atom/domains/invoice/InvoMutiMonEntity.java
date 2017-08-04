package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
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
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class InvoMutiMonEntity implements Serializable {

	/**
	 * 
	 */
	public InvoMutiMonEntity() {
		// TODO Auto-generated constructor stub
	}

	// 账期
	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "10", desc = "账期月", memo = "略")
	private int billCycle;

	@JSONField(name = "BILL_BEGIN")
	@ParamDesc(path = "BILL_BEGIN", cons = ConsType.QUES, type = "String", len = "10", desc = "账单开始日期", memo = "略")
	private String billBegin;

	@JSONField(name = "BILL_END")
	@ParamDesc(path = "BILL_END", cons = ConsType.QUES, type = "String", len = "10", desc = "账单结束日期", memo = "略")
	private String billEnd;

	// 滞纳金
	@JSONField(name = "DELAY_FEE")
	@ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "滞纳金", memo = "略")
	private long delayFee;

	// 发票金额
	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "发票金额", memo = "略")
	private long printFee;

	// 消费金额
	@JSONField(name = "TOTAL_FEE")
	@ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "消费金额", memo = "略")
	private long totalFee;

	// 已打预存发票金额
	@JSONField(name = "FEE_ALREAD")
	@ParamDesc(path = "FEE_ALREAD", cons = ConsType.CT001, type = "long", len = "10", desc = "已打预存发票金额", memo = "略")
	private long alreadFee;

	// 已打月结发票金额
	@JSONField(name = "FEE_ALMON")
	@ParamDesc(path = "FEE_ALMON", cons = ConsType.CT001, type = "long", len = "10", desc = "已打月结发票金额", memo = "略")
	private long almonFee;

	// 赠送预存金额
	@JSONField(name = "FEE_GIFT")
	@ParamDesc(path = "FEE_GIFT", cons = ConsType.CT001, type = "long", len = "10", desc = "存费送费金额", memo = "略")
	private long giftFee;

	// 账户
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号", memo = "略")
	private long contractNo;

	// 发票代码
	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	// 发票号码
	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	// 发票号码
	@JSONField(name = "PRINT_FLAG")
	@ParamDesc(path = "PRINT_FLAG", cons = ConsType.QUES, type = "String", len = "1", desc = "发票打印标识", memo = "0:未打印,1:打印了月结发票,2:打印了预存发票,3:打印了增值税发票")
	private String printFlag;
	// 发票号码
	@JSONField(name = "PAY_FEE")
	@ParamDesc(path = "PAY_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "缴费金额", memo = "略")
	private long payFee;
	// 发票号码
	@JSONField(name = "LAST_FEE")
	@ParamDesc(path = "LAST_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "上次结余", memo = "略")
	private long lastFee;
	// 发票号码
	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "余额", memo = "略")
	private long remainFee;
	@JSONField(name = "CUST_ID")
	@ParamDesc(path = "CUST_ID", cons = ConsType.QUES, type = "long", len = "20", desc = "账户CUST_ID", memo = "略")
	private long custId;

	/**
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}

	/**
	 * @param custId
	 *            the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}

	/**
	 * @return the billBegin
	 */
	public String getBillBegin() {
		return billBegin;
	}

	/**
	 * @param billBegin
	 *            the billBegin to set
	 */
	public void setBillBegin(String billBegin) {
		this.billBegin = billBegin;
	}

	/**
	 * @return the billEnd
	 */
	public String getBillEnd() {
		return billEnd;
	}

	/**
	 * @param billEnd
	 *            the billEnd to set
	 */
	public void setBillEnd(String billEnd) {
		this.billEnd = billEnd;
	}

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee
	 *            the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}

	/**
	 * @return the lastFee
	 */
	public long getLastFee() {
		return lastFee;
	}

	/**
	 * @param lastFee
	 *            the lastFee to set
	 */
	public void setLastFee(long lastFee) {
		this.lastFee = lastFee;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee
	 *            the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the invCode
	 */
	public String getInvCode() {
		return invCode;
	}

	/**
	 * @param invCode
	 *            the invCode to set
	 */
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	/**
	 * @return the invNo
	 */
	public String getInvNo() {
		return invNo;
	}

	/**
	 * @param invNo
	 *            the invNo to set
	 */
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	/**
	 * @return the printFlag
	 */
	public String getPrintFlag() {
		return printFlag;
	}

	/**
	 * @param printFlag
	 *            the printFlag to set
	 */
	public void setPrintFlag(String printFlag) {
		this.printFlag = printFlag;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo
	 *            the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public long getAlreadFee() {
		return alreadFee;
	}

	public void setAlreadFee(long alreadFee) {
		this.alreadFee = alreadFee;
	}

	public long getAlmonFee() {
		return almonFee;
	}

	public void setAlmonFee(long almonFee) {
		this.almonFee = almonFee;
	}

	public long getGiftFee() {
		return giftFee;
	}

	public void setGiftFee(long giftFee) {
		this.giftFee = giftFee;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */

	public void addInvo(InvoMutiMonEntity invTmp) {

		if (ValueUtils.intValue(invTmp.getBillBegin()) != 0) {
			if (ValueUtils.intValue(this.billBegin) > ValueUtils.intValue(invTmp.getBillBegin())) {
				this.billBegin = invTmp.getBillBegin();
			}
		}

		if (ValueUtils.intValue(this.billEnd) < ValueUtils.intValue(invTmp.getBillEnd())) {
			this.billEnd = invTmp.getBillEnd();
		}

		this.delayFee += invTmp.getDelayFee();
		this.printFee += invTmp.getPrintFee();
		this.totalFee += invTmp.getTotalFee();
		this.alreadFee += invTmp.getAlreadFee();
		this.almonFee += invTmp.getAlmonFee();
		this.giftFee += invTmp.getGiftFee();

	}

	@Override
	public String toString() {
		return "InvoMutiMonEntity [billCycle=" + billCycle + ", billBegin=" + billBegin + ", billEnd=" + billEnd + ", delayFee=" + delayFee
				+ ", printFee=" + printFee + ", totalFee=" + totalFee + ", alreadFee=" + alreadFee + ", almonFee=" + almonFee + ", giftFee="
				+ giftFee + ", contractNo=" + contractNo + ", invCode=" + invCode + ", invNo=" + invNo + ", printFlag=" + printFlag + ", payFee="
				+ payFee + ", lastFee=" + lastFee + ", remainFee=" + remainFee + ", custId=" + custId + "]";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + billCycle;
		return result;
	}

	public boolean compareByMon(InvoMutiMonEntity inv1) {

		if (this.billCycle > inv1.getBillCycle()) {
			return true;
		} else {

			return false;
		}
	}

}
