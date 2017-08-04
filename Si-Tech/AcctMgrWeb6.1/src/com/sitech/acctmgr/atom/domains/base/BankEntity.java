package com.sitech.acctmgr.atom.domains.base;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

public class BankEntity implements Serializable {

	@JSONField(name="BANK_CODE")
	@ParamDesc(path="BANK_CODE",cons=ConsType.CT001,type="String",len="12",desc="银行代码",memo="略")
	private String bankCode;
	
	@JSONField(name="BANK_NAME")
	@ParamDesc(path="BANK_NAME",cons=ConsType.CT001,type="string",len="60",desc="银行名称",memo="略")
	private String bankName;

	/**
	 * @return the bankCode
	 */
	public String getBankCode() {
		return bankCode;
	}

	/**
	 * @param bankCode the bankCode to set
	 */
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	/**
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BankListEntity [bankCode=" + bankCode + ", bankName="
				+ bankName + "]";
	}

	 

  
	
}
