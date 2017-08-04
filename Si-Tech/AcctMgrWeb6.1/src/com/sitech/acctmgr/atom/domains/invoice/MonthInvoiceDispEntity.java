package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 月结上需要展示的内容
 * 
 * @author liuhl_bj
 *
 */
@SuppressWarnings("serial")
public class MonthInvoiceDispEntity implements Serializable {

	@JSONField(name = "COMMUNITE_FEE")
	@ParamDesc(path = "COMMUNITE_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "通信服务费", memo = "略")
	private long communiteFee;

	@JSONField(name = "MEAL_FEE")
	@ParamDesc(path = "MEAL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "合约套餐费", memo = "略")
	private long mealFee;

	@JSONField(name = "DISCOUNT_FEE")
	@ParamDesc(path = "DISCOUNT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "折扣折让", memo = "略")
	private long discountFee;

	@JSONField(name = "TOTAL_FEE")
	@ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "合计", memo = "略")
	private long totalFee;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "本次发票金额", memo = "略")
	private long printFee;

	@JSONField(name = "PRINTED_FEE")
	@ParamDesc(path = "PRINTED_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "已打印发票金额", memo = "略")
	private long printedFee;

	@JSONField(name = "PRE_PRINTED_FEE")
	@ParamDesc(path = "PRE_PRINTED_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "预存款已出具发票金额", memo = "略")
	private long prePrintedFee;

	@JSONField(name = "CARD_PRINTED_FEE")
	@ParamDesc(path = "CARD_PRINTED_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "充值卡已出具发票金额", memo = "略")
	private long cardPrintedFee;

	@JSONField(name = "SYSPAY_PRINTED_FEE")
	@ParamDesc(path = "SYSPAY_PRINTED_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "系统充值已出具发票金额", memo = "略")
	private long sysPayPrintedFee;

	@JSONField(name = "OTHER_PRINTED_FEE")
	@ParamDesc(path = "OTHER_PRINTED_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "其他已出具发票金额", memo = "略")
	private long otherPrintFee;

	@JSONField(name = "BIG_MONEY")
	@ParamDesc(path = "BIG_MONEY", cons = ConsType.CT001, type = "int", len = "10", desc = "大写金额", memo = "略")
	private String bigMoney;

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "10", desc = "账期", memo = "略")
	private int billCycle;

	public String getBigMoney() {
		return bigMoney;
	}

	public void setBigMoney(String bigMoney) {
		this.bigMoney = bigMoney;
	}

	public long getCommuniteFee() {
		return communiteFee;
	}

	public void setCommuniteFee(long communiteFee) {
		this.communiteFee = communiteFee;
	}

	public long getMealFee() {
		return mealFee;
	}

	public void setMealFee(long mealFee) {
		this.mealFee = mealFee;
	}

	public long getDiscountFee() {
		return discountFee;
	}

	public void setDiscountFee(long discountFee) {
		this.discountFee = discountFee;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public long getPrintedFee() {
		return printedFee;
	}

	public void setPrintedFee(long printedFee) {
		this.printedFee = printedFee;
	}

	public long getPrePrintedFee() {
		return prePrintedFee;
	}

	public void setPrePrintedFee(long prePrintedFee) {
		this.prePrintedFee = prePrintedFee;
	}

	public long getCardPrintedFee() {
		return cardPrintedFee;
	}

	public void setCardPrintedFee(long cardPrintedFee) {
		this.cardPrintedFee = cardPrintedFee;
	}

	public long getSysPayPrintedFee() {
		return sysPayPrintedFee;
	}

	public void setSysPayPrintedFee(long sysPayPrintedFee) {
		this.sysPayPrintedFee = sysPayPrintedFee;
	}

	public long getOtherPrintFee() {
		return otherPrintFee;
	}

	public void setOtherPrintFee(long otherPrintFee) {
		this.otherPrintFee = otherPrintFee;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	@Override
	public String toString() {
		return "MonthInvoiceDispEntity [communiteFee=" + communiteFee + ", mealFee=" + mealFee + ", discountFee=" + discountFee + ", totalFee="
				+ totalFee + ", printFee=" + printFee + ", printedFee=" + printedFee + ", prePrintedFee=" + prePrintedFee + ", cardPrintedFee="
				+ cardPrintedFee + ", sysPayPrintedFee=" + sysPayPrintedFee + ", otherPrintFee=" + otherPrintFee + ", bigMoney=" + bigMoney
				+ ", billCycle=" + billCycle + "]";
	}

}
