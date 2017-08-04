package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

public class CreditListEntity implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JSONField(name="CREDIT_CODE")
	@ParamDesc(path="CREDIT_CODE",cons=ConsType.CT001,len="1",desc="信用度等级代码",type="String",memo="略")
	protected String creditCode;
	@JSONField(name="CREDIT_NAME")
	@ParamDesc(path="CREDIT_NAME",cons=ConsType.CT001,len="10",desc="信用度等级名称",type="String",memo="略")
	protected String creditName;
	public String getCreditCode() {
		return creditCode;
	}
	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}
	public String getCreditName() {
		return creditName;
	}
	public void setCreditName(String creditName) {
		this.creditName = creditName;
	}
	
	
	
	
}
