package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.BalTaxinvoicePre;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.out.OutDTO;

public class S2318QueryOutDTO extends OutDTO {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "INVOICE_PRE_LIST")
	@ParamDesc(path = "INVOICE_PRE_LIST", cons = ConsType.CT001, type = "long", len = "10", desc = "流水", memo = "略")
	private List<BalTaxinvoicePre> taxInvoicePreList;
	

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("taxInvoicePreList"), taxInvoicePreList);
		return result;
	}	

	
	public List<BalTaxinvoicePre> getTaxInvoicePreList() {
		return taxInvoicePreList;
	}

	public void setTaxInvoicePreList(List<BalTaxinvoicePre> taxInvoicePreList) {
		this.taxInvoicePreList = taxInvoicePreList;
	}

}
