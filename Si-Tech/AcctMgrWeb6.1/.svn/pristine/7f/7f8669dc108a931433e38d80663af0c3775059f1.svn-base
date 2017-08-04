package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSPBillAcctRuleInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.BIZ_TYPE", cons = ConsType.CT001, type = "String", len = "2", desc = "业务类型代码", memo = "略")
	private String bizType;
	
	@ParamDesc(path = "BUSI_INFO.SP_CODE", cons = ConsType.CT001, type = "String", len = "1000", desc = "企业代码列表", memo = "略")
	private String spCode;
	
	@ParamDesc(path = "BUSI_INFO.OPER_CODE", cons = ConsType.CT001, type = "String", len = "1000", desc = "业务代码列表", memo = "略")
	private String operCode;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		bizType = arg0.getStr(getPathByProperName("bizType"));
		spCode = arg0.getStr(getPathByProperName("spCode"));
		operCode = arg0.getStr(getPathByProperName("operCode"));
	}

	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	public String getSpCode() {
		return spCode;
	}

	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

	public String getOperCode() {
		return operCode;
	}

	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}
	
}
