package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBalanceQryBackFeeInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo = "";

	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号码", memo = "略")
	private long contractNo = 0;

	@ParamDesc(path = "BUSI_INFO.QUERY_TIME", cons = ConsType.QUES, type = "int", len = "20", desc = "查询日期", memo = "略")
	private int queryTime;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))
				&& StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00200"), "账户号码和服务号码不能同时为空！");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("queryTime")))) {
			queryTime = Integer.parseInt(arg0.getStr(getPathByProperName("queryTime")));
		} else {
			queryTime = DateUtils.getCurDay();
		}
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

	public int getQueryTime() {
		return queryTime;
	}

	public void setQueryTime(int queryTime) {
		this.queryTime = queryTime;
	}

}
