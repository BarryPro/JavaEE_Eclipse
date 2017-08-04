package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 预存发票上需要展示的内容
 * 
 * @author liuhl_bj
 *
 */
@SuppressWarnings("serial")
public class PreInvoiceDispEntity implements Serializable {

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "10", desc = "账期", memo = "略")
	private int billCycle;

	@JSONField(name = "BIG_MONEY")
	@ParamDesc(path = "BIG_MONEY", cons = ConsType.CT001, type = "int", len = "10", desc = "大写金额", memo = "略")
	private String bigMoney;

	@JSONField(name = "BILL_FEE")
	@ParamDesc(path = "BILL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "本金", memo = "略")
	private long billFee;

	@JSONField(name = "CASH_MONEY")
	@ParamDesc(path = "CASH_MONEY", cons = ConsType.CT001, type = "long", len = "10", desc = "现金", memo = "略")
	private long cashMoney;

	@JSONField(name = "CHECK_MONEY")
	@ParamDesc(path = "CHECK_MONEY", cons = ConsType.CT001, type = "long", len = "10", desc = "支票", memo = "略")
	private long checkMoney;

	@JSONField(name = "POS_MONEY")
	@ParamDesc(path = "POS_MONEY", cons = ConsType.CT001, type = "long", len = "10", desc = "刷卡", memo = "略")
	private long posMoney;

	@JSONField(name = "BALANCE_FEE")
	@ParamDesc(path = "BALANCE_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "话费余额", memo = "略")
	private long balanceFee;

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "当前可用余额", memo = "略")
	private long remainFee;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "发票金额", memo = "略")
	private long printFee;

	@JSONField(name = "DELAY_FEE")
	@ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "冲销的滞纳金", memo = "略")
	private long delayFee;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "未出帐话费", memo = "略")
	private long unbillFee;

	@JSONField(name = "COMPACT_NO")
	@ParamDesc(path = "COMPACT_NO", cons = ConsType.CT001, type = "int", len = "10", desc = "合同号", memo = "略")
	private String compactNo;

	@JSONField(name = "CHECK_NO")
	@ParamDesc(path = "CHECK_NO", cons = ConsType.CT001, type = "int", len = "10", desc = "支票号", memo = "略")
	private String checkNo;

	@JSONField(name = "PAY_DATE")
	@ParamDesc(path = "PAY_DATE", cons = ConsType.CT001, type = "int", len = "10", desc = "缴费日期", memo = "略")
	private int payDate;

	@JSONField(name = "OP_NAME")
	@ParamDesc(path = "OP_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "业务名称", memo = "略")
	private String opName;

	@JSONField(name = "OP_CODE")
	@ParamDesc(path = "OP_CODE", cons = ConsType.CT001, type = "string", len = "10", desc = "op_code", memo = "略")
	private String opCode;

	@JSONField(name = "REMARK")
	@ParamDesc(path = "REMARK", cons = ConsType.CT001, type = "string", len = "10", desc = "备注", memo = "略")
	private String remark;

	@JSONField(name = "PAY_METHOD")
	@ParamDesc(path = "PAY_METHOD", cons = ConsType.CT001, type = "string", len = "10", desc = "备注", memo = "略")
	private String payMethod;

	// @JSONField(name = "LAST_FEE")
	// @ParamDesc(path = "LAST_FEE", cons = ConsType.CT001, type = "string", len = "10", desc = "备注", memo = "略")
	// private long lastFee;


	public String getRemark() {
		return remark;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getBigMoney() {
		return bigMoney;
	}

	public void setBigMoney(String bigMoney) {
		this.bigMoney = bigMoney;
	}

	public long getBillFee() {
		return billFee;
	}

	public void setBillFee(long billFee) {
		this.billFee = billFee;
	}

	public long getCashMoney() {
		return cashMoney;
	}

	public void setCashMoney(long cashMoney) {
		this.cashMoney = cashMoney;
	}

	public long getCheckMoney() {
		return checkMoney;
	}

	public void setCheckMoney(long checkMoney) {
		this.checkMoney = checkMoney;
	}

	public long getPosMoney() {
		return posMoney;
	}

	public void setPosMoney(long posMoney) {
		this.posMoney = posMoney;
	}

	public long getBalanceFee() {
		return balanceFee;
	}

	public void setBalanceFee(long balanceFee) {
		this.balanceFee = balanceFee;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	public long getUnbillFee() {
		return unbillFee;
	}

	public void setUnbillFee(long unbillFee) {
		this.unbillFee = unbillFee;
	}

	public String getCompactNo() {
		return compactNo;
	}

	public void setCompactNo(String compactNo) {
		this.compactNo = compactNo;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public int getPayDate() {
		return payDate;
	}

	public void setPayDate(int payDate) {
		this.payDate = payDate;
	}

	@Override
	public String toString() {
		return "PreInvoiceDispEntity [billCycle=" + billCycle + ", bigMoney=" + bigMoney + ", billFee=" + billFee + ", cashMoney=" + cashMoney
				+ ", checkMoney=" + checkMoney + ", posMoney=" + posMoney + ", balanceFee=" + balanceFee + ", remainFee=" + remainFee + ", printFee="
				+ printFee + ", delayFee=" + delayFee + ", unbillFee=" + unbillFee + ", compactNo=" + compactNo + ", checkNo=" + checkNo
				+ ", payDate=" + payDate + "]";
	}

}
