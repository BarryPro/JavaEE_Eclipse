package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class ShareAccountQryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, desc = "标志", len = "1", type = "string", memo = "0:主卡查询   1:副卡查询")
	private String flag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		flag = arg0.getStr(getPathByProperName("flag"));
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
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
}
