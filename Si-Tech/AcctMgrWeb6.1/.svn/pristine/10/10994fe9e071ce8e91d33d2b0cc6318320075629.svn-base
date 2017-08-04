package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8080QueryPayInfoInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3031255433482943321L;
	
	@ParamDesc(path="BUSI_INFO.PAY_LOGIN",cons=ConsType.CT001,type="String",len="40",desc="缴费工号",memo="略")
	protected String payLogin;
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="40",desc="缴费流水",memo="略")
	protected String loginAccept;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="40",desc="用户idNo",memo="略")
	protected long idNo;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))){
			setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		}
		setPayLogin(arg0.getStr(getPathByProperName("payLogin")));
		setLoginAccept(arg0.getStr(getPathByProperName("loginAccept")));
	}


	public String getPayLogin() {
		return payLogin;
	}


	public void setPayLogin(String payLogin) {
		this.payLogin = payLogin;
	}


	public String getLoginAccept() {
		return loginAccept;
	}


	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public long getIdNo() {
		return idNo;
	}


	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}
	
	
	

}
