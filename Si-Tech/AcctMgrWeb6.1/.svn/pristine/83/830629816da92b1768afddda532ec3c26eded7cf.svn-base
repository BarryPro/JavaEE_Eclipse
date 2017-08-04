package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SEasyOwnCancelCfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4245220834885283058L;
	

	@ParamDesc(path="BUSI_INFO.LOGIN_PWD",cons=ConsType.CT001,type="String",len="20",desc="工号密码",memo="略")
	private String loginPwd;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.USER_PWD",cons=ConsType.CT001,type="String",len="40",desc="号码密码",memo="略")
	private String userPwd;
	@ParamDesc(path="BUSI_INFO.LOGIN_ACCEPT",cons=ConsType.CT001,type="String",len="40",desc="流水",memo="略")
	private String loginAccept;
	@ParamDesc(path="BUSI_INFO.CHN_SOURCE",cons=ConsType.CT001,type="String",len="40",desc="渠道标识",memo="略")
	private String chnSource;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="40",desc="备注",memo="略")
	private String remark;


	@Override
	public void decode(MBean arg0){
		super.decode(arg0);
		setLoginPwd(arg0.getStr(getPathByProperName("loginPwd")));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setUserPwd(arg0.getStr(getPathByProperName("userPwd")));
		setLoginAccept(arg0.getStr(getPathByProperName("loginAccept")));
		setChnSource(arg0.getStr(getPathByProperName("chnSource")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
	
		/*设置默认opcode*/
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8243";
		}
	}
	

	public String getLoginPwd() {
		return loginPwd;
	}


	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getUserPwd() {
		return userPwd;
	}


	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}


	public String getLoginAccept() {
		return loginAccept;
	}


	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}


	public String getChnSource() {
		return chnSource;
	}


	public void setChnSource(String chnSource) {
		this.chnSource = chnSource;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	
}
