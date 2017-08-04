package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8248QryInvoiceFlowInDTO extends CommonInDTO {

	private static final long serialVersionUID = 4654724435095489897L;

	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.CT001, type = "String", len = "20", desc = "查询类型", memo = "1：待处理  2：已处理")
	private int qryType;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.TAX_PAYER_ID", cons = ConsType.CT001, type = "String", len = "20", desc = "纳税人识别号", memo = "略")
	private String taxPayerId;

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "String", len = "20", desc = "查询开始时间", memo = "略")
	private int beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "String", len = "20", desc = "结束时间", memo = "略")
	private int endYm;
	
	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "String", len = "20", desc = "发票代码", memo = "略")
	private int invCode;
	
	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "发票号码", memo = "略")
	private int invNo;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		log.debug("arg0=" + arg0.toString());

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("taxPayerId")))) {
			taxPayerId = arg0.getStr(getPathByProperName("taxPayerId"));
		}

		qryType = Integer.parseInt(arg0.getStr(getPathByProperName("qryType")));
		beginYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginYm")));
		endYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("endYm")));
	}

	public int getInvCode() {
		return invCode;
	}

	public void setInvCode(int invCode) {
		this.invCode = invCode;
	}

	public int getInvNo() {
		return invNo;
	}

	public void setInvNo(int invNo) {
		this.invNo = invNo;
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

	public int getQryType() {
		return qryType;
	}

	public void setQryType(int qryType) {
		this.qryType = qryType;
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
