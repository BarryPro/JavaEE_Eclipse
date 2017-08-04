package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class QrySixBillInDTO extends CommonInDTO {
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "40", type = "string", memo = "略")
	private String phoneNo;
	@ParamDesc(path = "BUSI_INFO.YEAR_MONTH", cons = ConsType.CT001, desc = "账务年月", len = "6", type = "string", memo = "YYYYMM")
	private int yearMonth;
	@ParamDesc(path = "BUSI_INFO.QUERY_TYPE", cons = ConsType.QUES, desc = "号码类型", len = "1", type = "string", memo = "在8170模块中使用;传空即可")
	private String queryType;
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		yearMonth = Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth")));
		this.setQueryType(arg0.getStr(getPathByProperName("queryType")));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	
}
