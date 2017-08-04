package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8247DisableInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "申请流水", memo = "略")
	private long auditSn;

	@ParamDesc(path = "BUSI_INFO.INSERT_TIME", cons = ConsType.CT001, type = "string", len = "20", desc = "申请时间", memo = "略")
	private String insertTime;

	@ParamDesc(path = "BUSI_INFO.INV_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "发票类型", memo = "0：增值税发票  1：红字发票")
	private String invType;
	
	@ParamDesc(path = "BUSI_INFO.PRINT_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "打印流水", memo = "略")
	private long printSn;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		auditSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("auditSn")));
		invType = arg0.getStr(getPathByProperName("invType"));
		insertTime = arg0.getStr(getPathByProperName("insertTime"));
		printSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("printSn")));
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public String getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(String insertTime) {
		this.insertTime = insertTime;
	}

	public long getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(long auditSn) {
		this.auditSn = auditSn;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

}
