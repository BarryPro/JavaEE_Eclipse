package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
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
public class TaxPreInvoiceEntity implements Serializable {

	@JSONField(name = "MONTH_INVOICE_NUM")
	@ParamDesc(path = "MONTH_INVOICE_NUM", cons = ConsType.QUES, type = "String", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	@JSONField(name = "MONTH")
	@ParamDesc(path = "MONTH", cons = ConsType.QUES, type = "String", len = "20", desc = "月份", memo = "略")
	private String month;

	@JSONField(name = "MONTH_AMOUNT")
	@ParamDesc(path = "MONTH_AMOUNT", cons = ConsType.QUES, type = "String", len = "20", desc = "发票金额", memo = "略")
	private String monthAmount;

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, type = "int", len = "10", desc = "账期月", memo = "略")
	private int billCycle;
	// 发票金额
	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "发票金额", memo = "略")
	private long printFee;

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getMonthAmount() {
		return monthAmount;
	}

	public void setMonthAmount(String monthAmount) {
		this.monthAmount = monthAmount;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

}
