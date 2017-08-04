package com.sitech.acctmgr.atom.dto.invoice.eleInvoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SEleInvoiceQueryInDto extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "账户号码", memo = "略")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.REQUEST_SN", cons = ConsType.CT001, type = "string", len = "20", desc = "请求流水", memo = "略")
	private String requestSn;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "string", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.INV_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "发票类型", memo = "略")
	private String invType;

	@ParamDesc(path = "BUSI_INFO.BEGIN_DATE", cons = ConsType.CT001, type = "string", len = "20", desc = "开始时间", memo = "格式YYYYMMDD")
	private int beginDate;

	@ParamDesc(path = "BUSI_INFO.END_DATE", cons = ConsType.CT001, type = "string", len = "20", desc = "结束时间", memo = "格式YYYYMMDD")
	private int endDate;

	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.CT001, type = "string", len = "20", desc = "查询类型", memo = "0：按照服务号码，开始时间，结束时间查询    1：按照账户号码和服务号码，开始时间，结束时间查询    2：按照请求流水，发票代码和发票号码查询")
	private int queryType;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("requestSn")))){
			requestSn = arg0.getStr(getPathByProperName("requestSn"));
		}
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("invNo")))) {
			invNo = arg0.getStr(getPathByProperName("invNo"));
		}
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invCode")))) {
			invCode = arg0.getStr(getPathByProperName("invCode"));
		}
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("invType")))) {
			invType = arg0.getStr(getPathByProperName("invType"));
		}
		beginDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("beginDate")));
		endDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("endDate")));
		queryType = ValueUtils.intValue(arg0.getStr(getPathByProperName("queryType")));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getRequestSn() {
		return requestSn;
	}

	public void setRequestSn(String requestSn) {
		this.requestSn = requestSn;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public int getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	public int getEndDate() {
		return endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

	public int getQueryType() {
		return queryType;
	}

	public void setQueryType(int queryType) {
		this.queryType = queryType;
	}

}
