package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8229CheckBackCfmInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5574957028471815587L;
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.CT001,type="String",len="13",desc="银行代码",memo="略")
	protected String bankCode;
	@ParamDesc(path="BUSI_INFO.LOGIN_PWD",cons=ConsType.CT001,type="String",len="20",desc="操作员密码",memo="略")
	protected String loginPwd;
	@ParamDesc(path="BUSI_INFO.POP_TYPE",cons=ConsType.CT001,type="String",len="5",desc="操作类型",memo="略")
	protected String popType;
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.CT001,type="String",len="40",desc="支票号码",memo="略")
	protected String checkNo;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="500",desc="备注",memo="略")
	protected String remark;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		setLoginPwd(arg0.getStr(getPathByProperName("loginPwd")));
		setPopType(arg0.getStr(getPathByProperName("popType")));
		setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8229";
		}
	}


	public String getBankCode() {
		return bankCode;
	}


	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}


	public String getLoginPwd() {
		return loginPwd;
	}


	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}


	public String getPopType() {
		return popType;
	}


	public void setPopType(String popType) {
		this.popType = popType;
	}


	public String getCheckNo() {
		return checkNo;
	}


	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}
	

}
