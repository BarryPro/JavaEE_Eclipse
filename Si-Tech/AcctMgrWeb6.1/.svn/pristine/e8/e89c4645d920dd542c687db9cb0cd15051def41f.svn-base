package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8430CompQueryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2211553003422473509L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
    private String phoneNo;
    @ParamDesc(path = "BUSI_INFO.START_MONTH", cons = ConsType.CT001, desc = "查询开始年月", len = "6", type = "string", memo = "略")
    private String startMonth;
    @ParamDesc(path = "BUSI_INFO.END_MONTH", cons = ConsType.CT001, desc = "查询结束年月", len = "6", type = "string", memo = "略")
    private String endMonth;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setStartMonth(arg0.getStr(getPathByProperName("startMonth")));
		setEndMonth(arg0.getStr(getPathByProperName("endMonth")));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @return the startMonth
	 */
	public String getStartMonth() {
		return startMonth;
	}

	/**
	 * @return the endMonth
	 */
	public String getEndMonth() {
		return endMonth;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @param startMonth the startMonth to set
	 */
	public void setStartMonth(String startMonth) {
		this.startMonth = startMonth;
	}

	/**
	 * @param endMonth the endMonth to set
	 */
	public void setEndMonth(String endMonth) {
		this.endMonth = endMonth;
	}
	
}
