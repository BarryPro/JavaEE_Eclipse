package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
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
public class TaxInvoDetailEntity implements Serializable {

	@JSONField(name = "SHOW_NAME")
	@ParamDesc(path = "SHOWNAME", cons = ConsType.CT001, type = "string", len = "10", desc = "获取或应税劳务名称", memo = "略")
	private String showName;
	@JSONField(name = "SHOW_ORDER")
	@ParamDesc(path = "SHOWORDER", cons = ConsType.CT001, type = "long", len = "10", desc = "账目顺序", memo = "略")
	private long showOrder;
	@JSONField(name = "UNITE_PRICE")
	@ParamDesc(path = "UNITE_PRICE", cons = ConsType.CT001, type = "long", len = "10", desc = "单价费用", memo = "略")
	private long price;
	@JSONField(name = "AMOUNT")
	@ParamDesc(path = "AMOUNT", cons = ConsType.CT001, type = "long", len = "10", desc = "数量", memo = "略")
	private long amount;
	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.CT001, type = "double", len = "10", desc = "税率", memo = "略")
	private double taxRate;
	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "税费金额", memo = "略")
	private long taxFee;
	@JSONField(name = "TOTAL_FEE")
	@ParamDesc(path = "TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "账目项总额", memo = "略")
	private long totaleFee;

	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}

	public long getShowOrder() {
		return showOrder;
	}

	public void setShowOrder(long showOrder) {
		this.showOrder = showOrder;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public long getAmount() {
		return amount;
	}

	public void setAmount(long amount) {
		this.amount = amount;
	}

	public double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(double taxRate) {
		this.taxRate = taxRate;
	}

	public long getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(long taxFee) {
		this.taxFee = taxFee;
	}

	public long getTotaleFee() {
		return totaleFee;
	}

	public void setTotaleFee(long totaleFee) {
		this.totaleFee = totaleFee;
	}

	@Override
	public String toString() {
		return "TaxInvoDetailEntity [showName=" + showName + ", showOrder=" + showOrder + ", price=" + price + ", amount=" + amount + ", taxRate="
				+ taxRate + ", taxFee=" + taxFee + ", totaleFee=" + totaleFee + "]";
	}

	public boolean compareTo(TaxInvoDetailEntity other) {

		return true;
	}

}
