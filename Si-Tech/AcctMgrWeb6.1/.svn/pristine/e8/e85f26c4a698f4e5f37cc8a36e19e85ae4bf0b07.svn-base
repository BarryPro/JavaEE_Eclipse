package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248QryInvoiceFeeOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -589453073170774314L;

	@JSONField(name = "TAX_INVFEE_LIST")
	@ParamDesc(path = "TAX_INVFEE_LIST", cons = ConsType.PLUS, type = "string", len = "1", desc = "发票费用列表", memo = "略")
	private List<TaxInvoiceFeeEntity> taxInvFeeList;
	
	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.PLUS, type = "string", len = "1", desc = "购货单位", memo = "略")
	private String unitName;

	@JSONField(name = "TAX_PAYER_ID")
	@ParamDesc(path = "TAX_PAYER_ID", cons = ConsType.PLUS, type = "string", len = "1", desc = "纳税人识别号", memo = "略")
	private String taxPayerId;

	@JSONField(name = "ADDRESS")
	@ParamDesc(path = "ADDRESS", cons = ConsType.PLUS, type = "string", len = "1", desc = "地址-电话", memo = "略")
	private String address;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.PLUS, type = "string", len = "1", desc = "地址-电话", memo = "略")
	private String phoneNo;

	@JSONField(name = "BANK_ACCOUNT")
	@ParamDesc(path = "BANK_ACCOUNT", cons = ConsType.PLUS, type = "string", len = "1", desc = "地址-电话", memo = "略")
	private String bankAccount;

	@JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.PLUS, type = "string", len = "1", desc = "地址-电话", memo = "略")
	private String bankName;

	
	@JSONField(name = "INVOICE_FEE_TOTAL")
	@ParamDesc(path = "INVOICE_FEE_TOTAL", cons = ConsType.PLUS, type = "string", len = "1", desc = "合计不含税金额", memo = "略")
	private String invoiceFeeTotal;

	@JSONField(name = "TAX_FEE_TOTAL")
	@ParamDesc(path = "TAX_FEE_TOTAL", cons = ConsType.PLUS, type = "string", len = "1", desc = "合计税额", memo = "略")
	private String taxFeeTotal;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.PLUS, type = "string", len = "1", desc = "价税合计", memo = "略")
	private String printFee;

	@JSONField(name = "BIG_FEE")
	@ParamDesc(path = "BIG_FEE", cons = ConsType.PLUS, type = "string", len = "1", desc = "大写金额", memo = "略")
	private String bigFee;
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("taxInvFeeList"), taxInvFeeList);
		result.setRoot(getPathByProperName("unitName"), unitName);
		result.setRoot(getPathByProperName("taxPayerId"), taxPayerId);
		result.setRoot(getPathByProperName("address"), address);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("bankAccount"), bankAccount);
		result.setRoot(getPathByProperName("bankName"), bankName);
		result.setRoot(getPathByProperName("invoiceFeeTotal"), invoiceFeeTotal);
		result.setRoot(getPathByProperName("taxFeeTotal"), taxFeeTotal);
		result.setRoot(getPathByProperName("printFee"), printFee);
		result.setRoot(getPathByProperName("bigFee"), bigFee);
		return result;
	}


	public List<TaxInvoiceFeeEntity> getTaxInvFeeList() {
		return taxInvFeeList;
	}

	public void setTaxInvFeeList(List<TaxInvoiceFeeEntity> taxInvFeeList) {
		this.taxInvFeeList = taxInvFeeList;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}


	public String getInvoiceFeeTotal() {
		return invoiceFeeTotal;
	}

	public void setInvoiceFeeTotal(String invoiceFeeTotal) {
		this.invoiceFeeTotal = invoiceFeeTotal;
	}

	public String getTaxFeeTotal() {
		return taxFeeTotal;
	}

	public void setTaxFeeTotal(String taxFeeTotal) {
		this.taxFeeTotal = taxFeeTotal;
	}

	public String getPrintFee() {
		return printFee;
	}

	public void setPrintFee(String printFee) {
		this.printFee = printFee;
	}

	public String getBigFee() {
		return bigFee;
	}

	public void setBigFee(String bigFee) {
		this.bigFee = bigFee;
	}

}
