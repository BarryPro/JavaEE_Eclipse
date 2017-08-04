package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 银行卡签约客户主动交费入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8069CfmInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONENO_SIGN",cons=ConsType.CT001,type="String",len="40",desc="签约手机号码",memo="略")
	protected String phoneNoSign;
	
	@ParamDesc(path="BUSI_INFO.PHONENO_SIGN_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="签约手机用户密码",memo="略")
	protected String phoneNoSignPassword;

	@ParamDesc(path="BUSI_INFO.PHONENO_PAY",cons=ConsType.CT001,type="String",len="40",desc="缴费手机号码",memo="略")
	protected String phoneNoPay;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="交费金额",memo="单位：分")
	private String payMoney;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNoSign(arg0.getStr(getPathByProperName("phoneNoSign")));
		setPhoneNoSignPassword(arg0.getStr(getPathByProperName("phoneNoSignPassword")));
		setPhoneNoPay(arg0.getStr(getPathByProperName("phoneNoPay")));
		setPayMoney(arg0.getStr(getPathByProperName("payMoney")));
		
	}


	public String getPhoneNoSign() {
		return phoneNoSign;
	}


	public void setPhoneNoSign(String phoneNoSign) {
		this.phoneNoSign = phoneNoSign;
	}


	public String getPhoneNoSignPassword() {
		return phoneNoSignPassword;
	}

	public void setPhoneNoSignPassword(String phoneNoSignPassword) {
		this.phoneNoSignPassword = phoneNoSignPassword;
	}

	public String getPhoneNoPay() {
		return phoneNoPay;
	}

	public void setPhoneNoPay(String phoneNoPay) {
		this.phoneNoPay = phoneNoPay;
	}

	public String getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	

}
