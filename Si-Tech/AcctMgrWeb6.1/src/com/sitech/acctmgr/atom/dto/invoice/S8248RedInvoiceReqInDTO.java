package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248RedInvoiceReqInDTO extends CommonInDTO {

	private static final long serialVersionUID = 4410354682184604427L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "审批流水", memo = "略")
	private long auditSn;

	@ParamDesc(path = "BUSI_INFO.REPORT_TO", cons = ConsType.CT001, type = "string", len = "20", desc = "审核人工号", memo = "略")
	private String reportTo;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, type = "string", len = "20", desc = "申请类型", memo = "1：红字发票申请   2：作废申请")
	private int flag;

	@ParamDesc(path = "BUSI_INFO.AUDIT_PHONE_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "审核人手机号码", memo = "略")
	private String auditPhoneNo;

	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.CT001, type = "string", len = "20", desc = "备注栏信息", memo = "略")
	private String remark;

	@ParamDesc(path = "BUSI_INFO.RED_INV_CAUSE", cons = ConsType.CT001, type = "string", len = "20", desc = "红字发票原因", memo = "略")
	private String redinvCause;

	@ParamDesc(path = "BUSI_INFO.RED_INV_REMARK", cons = ConsType.CT001, type = "string", len = "20", desc = "开具红字发票原因", memo = "略")
	private String redinvRemark;

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "string", len = "20", desc = "开始时间", memo = "略")
	private String beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "string", len = "20", desc = "结束时间", memo = "略")
	private String endYm;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		auditSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("auditSn")));

		reportTo = arg0.getStr(getPathByProperName("reportTo"));

		auditPhoneNo = arg0.getStr(getPathByProperName("auditPhoneNo"));

		beginYm = arg0.getStr(getPathByProperName("beginYm"));
		endYm = arg0.getStr(getPathByProperName("endYm"));
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("remark")))) {
			remark = arg0.getStr(getPathByProperName("remark"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvCause")))) {
			redinvCause = arg0.getStr(getPathByProperName("redinvCause"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("redinvRemark")))) {
			redinvRemark = arg0.getStr(getPathByProperName("redinvRemark"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("flag")))) {
				flag = ValueUtils.intValue(arg0.getStr(getPathByProperName("flag")));
		}
	}

	public String getBeginYm() {
		return beginYm;
	}

	public void setBeginYm(String beginYm) {
		this.beginYm = beginYm;
	}

	public String getEndYm() {
		return endYm;
	}

	public void setEndYm(String endYm) {
		this.endYm = endYm;
	}

	public long getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(long auditSn) {
		this.auditSn = auditSn;
	}

	public String getReportTo() {
		return reportTo;
	}

	public void setReportTo(String reportTo) {
		this.reportTo = reportTo;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getAuditPhoneNo() {
		return auditPhoneNo;
	}

	public void setAuditPhoneNo(String auditPhoneNo) {
		this.auditPhoneNo = auditPhoneNo;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRedinvCause() {
		return redinvCause;
	}

	public void setRedinvCause(String redinvCause) {
		this.redinvCause = redinvCause;
	}

	public String getRedinvRemark() {
		return redinvRemark;
	}

	public void setRedinvRemark(String redinvRemark) {
		this.redinvRemark = redinvRemark;
	}

}
