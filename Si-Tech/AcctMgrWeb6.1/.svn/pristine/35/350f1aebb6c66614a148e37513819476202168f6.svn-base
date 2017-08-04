package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.BalInvauditInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248QryInvoiceFlowOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -589453073170774314L;

	@JSONField(name = "AUDIT_INFO_LIST")
	@ParamDesc(path = "AUDIT_INFO_LIST", cons = ConsType.PLUS, type = "string", len = "1", desc = "审核信息列表", memo = "略")
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
