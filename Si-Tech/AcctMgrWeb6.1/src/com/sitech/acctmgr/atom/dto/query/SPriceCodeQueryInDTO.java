package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPriceCodeQueryInDTO extends CommonInDTO {


	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PRICE_CODE", cons = ConsType.CT001, type = "String", len = "6", desc = "", memo = "略")
	private String priceCode;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		priceCode = arg0.getStr(getPathByProperName("priceCode"));
	}

	public String getPriceCode() {
		return priceCode;
	}

	public void setPriceCode(String priceCode) {
		this.priceCode = priceCode;
	}

	
}
