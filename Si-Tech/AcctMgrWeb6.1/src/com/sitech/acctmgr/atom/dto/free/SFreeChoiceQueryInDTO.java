package com.sitech.acctmgr.atom.dto.free;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SFreeChoiceQueryInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3620295287355743723L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.RATE_CODE", cons = ConsType.CT001, desc = "二批代码", len = "6", type = "string", memo = "格式为YYYYMM；")
	private String rateCode;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		rateCode = arg0.getStr(getPathByProperName("rateCode"));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getRateCode() {
		return rateCode;
	}

	public void setRateCode(String rateCode) {
		this.rateCode = rateCode;
	}

}
