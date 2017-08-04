package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8247InvoiceFlowInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "申请流水", memo = "略")
	private long auditSn;

	@ParamDesc(path = "BUSI_INFO.TAX_PAYER_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "纳税人识别号", memo = "略")
	private String taxPayerId;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "string", len = "10", desc = "开始时间", memo = "略")
	private int beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "string", len = "10", desc = "结束时间", memo = "略")
	private int endYm;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, type = "int", len = "10", desc = "标志", memo = "1：开具和作废    2：传递")
	private int flag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("auditSn")))) {
			auditSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("auditSn")));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("taxPayerId")))) {
			taxPayerId = arg0.getStr(getPathByProperName("taxPayerId"));
		}
		beginYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginYm")));
		endYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("endYm")));
		flag = ValueUtils.intValue(arg0.getStr(getPathByProperName("flag")));
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public long getAuditSn() {
		return auditSn;
	}

	public void setAuditSn(long auditSn) {
		this.auditSn = auditSn;
	}

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getBeginYm() {
		return beginYm;
	}

	public void setBeginYm(int beginYm) {
		this.beginYm = beginYm;
	}

	public int getEndYm() {
		return endYm;
	}

	public void setEndYm(int endYm) {
		this.endYm = endYm;
	}

}
