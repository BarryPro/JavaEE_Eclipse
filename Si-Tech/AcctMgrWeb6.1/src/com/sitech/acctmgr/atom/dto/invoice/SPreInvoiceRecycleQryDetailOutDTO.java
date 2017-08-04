package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.PreInvoiceRecycleEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPreInvoiceRecycleQryDetailOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4671065283533784774L;

	@JSONField(name = "PRE_INVREC_LIST")
	@ParamDesc(path = "PRE_INVREC_LIST", cons = ConsType.QUES, type = "String", len = "20", desc = "预开发票列表", memo = "略")
	private List<PreInvoiceRecycleEntity> preInvRecList;

	@Override
	public MBean encode() {

		MBean result = new MBean();
		result.setRoot(getPathByProperName("preInvRecList"), preInvRecList);
		return result;

	}

	public List<PreInvoiceRecycleEntity> getPreInvRecList() {
		return preInvRecList;
	}

	public void setPreInvRecList(List<PreInvoiceRecycleEntity> preInvRecList) {
		this.preInvRecList = preInvRecList;
	}

}
