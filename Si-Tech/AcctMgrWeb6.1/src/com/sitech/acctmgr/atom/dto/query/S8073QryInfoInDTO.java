package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8073QryInfoInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7948613529042164089L;
	
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.CT001,type="String",len="18",desc="开始时间",memo="略")
	protected String beginTime;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.CT001,type="String",len="18",desc="开始时间",memo="略")
	protected String endTime;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
	}
	
	

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}



	public String getBeginTime() {
		return beginTime;
	}



	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}



	public String getEndTime() {
		return endTime;
	}



	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
