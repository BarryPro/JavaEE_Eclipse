package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.AcrossFieldInvEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAcrossFieldQryInvoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "客户名称", memo = "略")
	private String custName;

	@JSONField(name = "INFO_CONT")
	@ParamDesc(path = "INFO_CONT", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票列表", memo = "略")
	private List<AcrossFieldInvEntity> invEnti = null;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("custName"), this.custName);
		result.setRoot(getPathByProperName("invEnti"), this.invEnti);
		return result;

	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public List<AcrossFieldInvEntity> getInvEnti() {
		return invEnti;
	}

	public void setInvEnti(List<AcrossFieldInvEntity> invEnti) {
		this.invEnti = invEnti;
	}

}
