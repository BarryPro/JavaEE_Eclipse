package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8511InDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	/*
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="100",desc="操作类型",memo="1：办理；0：查询")
	private String opType;
	*/
	@ParamDesc(path="BUSI_INFO.SHOULD_PAY",cons=ConsType.QUES,type="String",len="20",desc="扣费金额",memo="单位：分")
	private String shouldPay;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setShouldPay(arg0.getStr(getPathByProperName("shouldPay")));
		
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
	 * @return the shouldPay
	 */
	public String getShouldPay() {
		return shouldPay;
	}

	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(String shouldPay) {
		this.shouldPay = shouldPay;
	}

}

