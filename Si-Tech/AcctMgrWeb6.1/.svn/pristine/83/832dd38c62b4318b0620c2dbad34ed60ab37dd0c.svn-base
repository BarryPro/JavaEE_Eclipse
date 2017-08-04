package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 发票上需要展示的内容(包括发票头，预存发票上展示的内容，月结发票上展示的内容)
 * 
 * @author liuhl_bj
 *
 */
@SuppressWarnings("serial")
public class InvoiceDispEntity implements Serializable {

	@JSONField(name = "BASE_INVOICE")
	@ParamDesc(path = "BASE_INVOICE", cons = ConsType.CT001, type = "compx", len = "10", desc = "发票展示的基本信息", memo = "略")
	private BaseInvoiceDispEntity baseInvoice;

	@JSONField(name = "PRE_INVOICE")
	@ParamDesc(path = "PRE_INVOICE", cons = ConsType.CT001, type = "compx", len = "10", desc = "预存发票上展示的信息", memo = "略")
	private PreInvoiceDispEntity preInvoice;

	@JSONField(name = "MONTH_INVOICE")
	@ParamDesc(path = "MONTH_INVOICE", cons = ConsType.CT001, type = "compx", len = "10", desc = "月结发票上展示的信息", memo = "略")
	private MonthInvoiceDispEntity monthInvoice;

	public BaseInvoiceDispEntity getBaseInvoice() {
		return baseInvoice;
	}

	public void setBaseInvoice(BaseInvoiceDispEntity baseInvoice) {
		this.baseInvoice = baseInvoice;
	}

	public PreInvoiceDispEntity getPreInvoice() {
		return preInvoice;
	}

	public void setPreInvoice(PreInvoiceDispEntity preInvoice) {
		this.preInvoice = preInvoice;
	}

	public MonthInvoiceDispEntity getMonthInvoice() {
		return monthInvoice;
	}

	public void setMonthInvoice(MonthInvoiceDispEntity monthInvoice) {
		this.monthInvoice = monthInvoice;
	}

	@Override
	public String toString() {
		return "TotalInvoiceEntity [baseInvoice=" + baseInvoice + ", preInvoice=" + preInvoice + ", monthInvoice=" + monthInvoice + "]";
	}

}
