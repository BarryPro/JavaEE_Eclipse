package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8418InitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PAY_NAME", cons = ConsType.CT001, desc = "账户科目", len = "100", type = "string", memo = "略")
	private String payName;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		payName = arg0.getStr(getPathByProperName("payName"));
		
	}

	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}

	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}
}
