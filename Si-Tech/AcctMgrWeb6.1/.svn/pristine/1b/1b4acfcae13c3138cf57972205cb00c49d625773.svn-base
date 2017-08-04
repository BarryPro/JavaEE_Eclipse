package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayFlagQryInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.SYS_DATE",cons=ConsType.QUES,type="String",len="14",desc="日期",memo="年月日")
	private String sysDate = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		sysDate = arg0.getStr(getPathByProperName("sysDate"));
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
	 * @return the sysDate
	 */
	public String getSysDate() {
		return sysDate;
	}

	/**
	 * @param sysDate the sysDate to set
	 */
	public void setSysDate(String sysDate) {
		this.sysDate = sysDate;
	}
	
}
