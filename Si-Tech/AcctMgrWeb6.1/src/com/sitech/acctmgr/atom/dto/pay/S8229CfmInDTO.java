package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8229CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1329209885449461072L;
	
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.CT001,type="String",len="13",desc="银行代码",memo="略")
	protected String bankCode;
	@ParamDesc(path="BUSI_INFO.LOGIN_PWD",cons=ConsType.CT001,type="String",len="20",desc="操作员密码",memo="略")
	protected String loginPwd;
	@ParamDesc(path="BUSI_INFO.POP_TYPE",cons=ConsType.CT001,type="String",len="5",desc="操作类型",memo="略")
	protected String popType;
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.CT001,type="String",len="40",desc="支票号码",memo="略")
	protected String checkNo;
	@ParamDesc(path="BUSI_INFO.BANK_COUNT",cons=ConsType.CT001,type="String",len="40",desc="银行账号",memo="略")
	protected String bankCount;
	@ParamDesc(path="BUSI_INFO.CHECK_MONEY",cons=ConsType.CT001,type="long",len="40",desc="支票金额",memo="略")
	protected long checkMoney;
	@ParamDesc(path="BUSI_INFO.POWNER_UNIT",cons=ConsType.CT001,type="String",len="65",desc="银行户名",memo="略")
	protected String pownerUnit;
	@ParamDesc(path="BUSI_INFO.POWER_NAME",cons=ConsType.CT001,type="String",len="65",desc="用户名称",memo="略")
	protected String pownerName;
	@ParamDesc(path="BUSI_INFO.POWNER_ID",cons=ConsType.CT001,type="String",len="19",desc="身份证号",memo="略")
	protected String pownerId;
	@ParamDesc(path="BUSI_INFO.CONTACT_NO",cons=ConsType.CT001,type="String",len="19",desc="联系人电话",memo="略")
	protected String contactNo;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="500",desc="备注",memo="略")
	protected String remark;
	
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		setLoginPwd(arg0.getStr(getPathByProperName("loginPwd")));
		setPopType(arg0.getStr(getPathByProperName("popType")));
		setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		setBankCount(arg0.getStr(getPathByProperName("bankCount")));
		setPownerUnit(arg0.getStr(getPathByProperName("pownerUnit")));
		setPownerName(arg0.getStr(getPathByProperName("pownerName")));
		setPownerId(arg0.getStr(getPathByProperName("pownerId")));
		setContactNo(arg0.getStr(getPathByProperName("contactNo")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		setCheckMoney(Long.parseLong(arg0.getObject(getPathByProperName("checkMoney")).toString()));
		
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


	public String getBankCount() {
		return bankCount;
	}


	public void setBankCount(String bankCount) {
		this.bankCount = bankCount;
	}


	public long getCheckMoney() {
		return checkMoney;
	}


	public void setCheckMoney(long checkMoney) {
		this.checkMoney = checkMoney;
	}


	public String getPownerUnit() {
		return pownerUnit;
	}


	public void setPownerUnit(String pownerUnit) {
		this.pownerUnit = pownerUnit;
	}


	public String getPownerName() {
		return pownerName;
	}


	public void setPownerName(String pownerName) {
		this.pownerName = pownerName;
	}


	public String getPownerId() {
		return pownerId;
	}


	public void setPownerId(String pownerId) {
		this.pownerId = pownerId;
	}


	public String getContactNo() {
		return contactNo;
	}


	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}
	

}
