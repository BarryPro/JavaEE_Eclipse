package com.sitech.acctmgr.atom.dto.invoice.eleInvoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.EleInvoiceInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SEleInvoiceQueryOutDto extends CommonOutDTO {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "ELE_INVOICE_LIST")
	@ParamDesc(path = "ELE_INVOICE_LIST", cons = ConsType.CT001, type = "long", len = "10", desc = "电子发票信息", memo = "略")
	private List<EleInvoiceInfoEntity> eleInvoiceList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("eleInvoiceList"), eleInvoiceList);
		return result;
	}

	public List<EleInvoiceInfoEntity> getEleInvoiceList() {
		return eleInvoiceList;
	}

	public void setEleInvoiceList(List<EleInvoiceInfoEntity> eleInvoiceList) {
		this.eleInvoiceList = eleInvoiceList;
	}

}
