package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDisFlagQryInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    @ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
    private String phoneNo;
    @ParamDesc(path = "BUSI_INFO.QUERY_MONTH", cons = ConsType.CT001, desc = "查询年月", len = "6", type = "string", memo = "略")
    private String queryMonth;

    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
        phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
        queryMonth = arg0.getStr(getPathByProperName("queryMonth"));
    }

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the queryMonth
	 */
	public String getQueryMonth() {
		return queryMonth;
	}

	/**
	 * @param queryMonth the queryMonth to set
	 */
	public void setQueryMonth(String queryMonth) {
		this.queryMonth = queryMonth;
	}

	
}
