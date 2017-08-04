package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STellCodeInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="用户号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.QUES,type="String",len="20",desc="操作流水",memo="")
	private String loginAccept;

	
	public void decode(MBean arg0){
		super.decode(arg0);
				
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));	
		setLoginAccept(arg0.getStr(getPathByProperName("loginAccept")));		
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
	 * @return the loginAccept
	 */
	public String getLoginAccept() {
		return loginAccept;
	}


	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}
}
