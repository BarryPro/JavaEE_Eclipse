package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S8248QryOnePayInvoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -589453073170774314L;

	@JSONField(name = "TAX_PAYER_ID")
	@ParamDesc(path = "TAX_PAYER_ID", cons = ConsType.CT001, type = "string", len = "1", desc = "纳税人识别号", memo = "略")
	private String taxPayerId;

	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.CT001, type = "string", len = "1", desc = "纳税人名称", memo = "略")
	private String unitName;

	@JSONField(name = "ADDRESS_PHONE")
	@ParamDesc(path = "ADDRESS_PHONE", cons = ConsType.CT001, type = "string", len = "1", desc = "地址，电话", memo = "略")
	private String addressPhone;

	@JSONField(name = "BANK_NAME_ACCOUNT")
	@ParamDesc(path = "BANK_NAME_ACCOUNT", cons = ConsType.CT001, type = "string", len = "1", desc = "开户行及账号", memo = "略")
	private String bankNameAndAccount;

	@JSONField(name = "TAX_INVOICE_INFO")
	@ParamDesc(path = "TAX_INVOICE_INFO", cons = ConsType.CT001, type = "compx", len = "1", desc = "费用信息", memo = "略")
	private List<TaxInvoiceFeeEntity> taxInvoiceList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("taxPayerId"), taxPayerId);
		result.setRoot(getPathByProperName("unitName"), unitName);
		result.setRoot(getPathByProperName("addressPhone"), addressPhone);
		result.setRoot(getPathByProperName("bankNameAndAccount"), bankNameAndAccount);
		result.setRoot(getPathByProperName("taxInvoiceList"), taxInvoiceList);
		return result;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getAddressPhone() {
		return addressPhone;
	}

	public void setAddressPhone(String addressPhone) {
		this.addressPhone = addressPhone;
	}

	public String getBankNameAndAccount() {
		return bankNameAndAccount;
	}

	public void setBankNameAndAccount(String bankNameAndAccount) {
		this.bankNameAndAccount = bankNameAndAccount;
	}

	public List<TaxInvoiceFeeEntity> getTaxInvoiceList() {
		return taxInvoiceList;
	}

	public void setTaxInvoiceList(List<TaxInvoiceFeeEntity> taxInvoiceList) {
		this.taxInvoiceList = taxInvoiceList;
	}

}
