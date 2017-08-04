package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class S8248DataResetInDTO extends CommonInDTO {


	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "申请流水", memo = "略")
	private long auditSn;

	@ParamDesc(path = "BUSI_INFO.INV_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "发票类型", memo = "0：增值税发票   1：冲红  2：作废")
	private int invType;

	@ParamDesc(path = "BUSI_INFO.BEGIN_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "开始年月", memo = "略")
	private int beginMon;

	@ParamDesc(path = "BUSI_INFO.END_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "结束年月", memo = "略")
	private int endMon;


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		auditSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("auditSn")));
		invType = ValueUtils.intValue(arg0.getStr(getPathByProperName("invType")));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginMon")))) {
			beginMon = Integer.parseInt(arg0.getStr(getPathByProperName("beginMon")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endMon")))) {
			endMon = Integer.parseInt(arg0.getStr(getPathByProperName("endMon")));
		}

	}


	public int getInvType() {
		return invType;
	}

	public void setInvType(int invType) {
		this.invType = invType;
	}


	public int getBeginMon() {
		return beginMon;
	}

	public void setBeginMon(int beginMon) {
		this.beginMon = beginMon;
	}


	public long getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(long auditSn) {
		this.auditSn = auditSn;
	}

	public int getEndMon() {
		return endMon;
	}

	public void setEndMon(int endMon) {
		this.endMon = endMon;
	}

}
