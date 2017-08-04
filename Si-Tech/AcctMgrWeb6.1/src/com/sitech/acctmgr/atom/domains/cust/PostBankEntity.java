package com.sitech.acctmgr.atom.domains.cust;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class PostBankEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8214843311746559654L;

	@JSONField(name="BANK_NAME")
	@ParamDesc(path="BANK_NAME",cons=ConsType.CT001,type="String",len="100",desc="银行名称",memo="略")
	String bankName;
	
	@JSONField(name="POST_ACCOUNT")
	@ParamDesc(path="POST_ACCOUNT",cons=ConsType.CT001,type="String",len="30",desc="银行账号",memo="略")
	String postAccount;
	
	@JSONField(name="POST_NAME")
	@ParamDesc(path="POST_NAME",cons=ConsType.CT001,type="String",len="60",desc="局方名称",memo="略")
	String postName;
	
	@JSONField(name="POST_BANK_CODE")
	@ParamDesc(path="POST_BANK_CODE",cons=ConsType.CT001,type="String",len="8",desc="银行代码",memo="略")
	String postCode;
	
	
	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getPostAccount() {
		return postAccount;
	}

	public void setPostAccount(String postAccount) {
		this.postAccount = postAccount;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	@Override
	public String toString() {
		return "PostBankEntity [bankName=" + bankName + ", postAccount="
				+ postAccount + ", postName=" + postName + ", postCode="
				+ postCode + "]";
	}

	
}
