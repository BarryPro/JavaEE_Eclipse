package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayPrtQryInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.FOREIGN_SN", cons = ConsType.CT001, desc = "外部流水", len = "15", type = "string", memo = "略")
	private String foreignSn;

	@ParamDesc(path = "BUSI_INFO.TOTAL_DATE", cons = ConsType.CT001, desc = "充值到账日期", len = "15", type = "string", memo = "YYYYMM")
	private int totalDate;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "YYYYMM")
	private String phoneNo;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		totalDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("totalDate")));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getForeignSn() {
		return foreignSn;
	}

	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

}
