package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248FlowOverCfmInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "申请流水", memo = "略")
	private long auditSn;

	@ParamDesc(path = "BUSI_INFO.OP_TIME", cons = ConsType.CT001, type = "int", len = "10", desc = "入表时间", memo = "略")
	private int opTime;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		auditSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("auditSn")));
		opTime = ValueUtils.intValue(arg0.getStr(getPathByProperName("opTime")));

	}

	public long getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(long auditSn) {
		this.auditSn = auditSn;
	}

	public int getOpTime() {
		return opTime;
	}

	public void setOpTime(int opTime) {
		this.opTime = opTime;
	}
}
