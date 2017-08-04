package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.BalInvauditInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S8247InvoiceFlowOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -1475850530776591181L;

	@JSONField(name = "AUDIT_INFO_LIST")
	@ParamDesc(path = "AUDIT_INFO_LIST", cons = ConsType.CT001, type = "compx", len = "1", desc = "审批列表", memo = "略")
	private List<BalInvauditInfo> auditInfoList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("auditInfoList"), auditInfoList);
		return result;
	}

	public List<BalInvauditInfo> getAuditInfoList() {
		return auditInfoList;
	}

	public void setAuditInfoList(List<BalInvauditInfo> auditInfoList) {
		this.auditInfoList = auditInfoList;
	}

}
