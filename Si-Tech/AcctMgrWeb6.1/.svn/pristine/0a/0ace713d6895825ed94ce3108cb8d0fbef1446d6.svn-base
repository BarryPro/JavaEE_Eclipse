package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SRemainFeeInitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6432547394733622523L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
	
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
}
