package com.sitech.acctmgr.atom.dto.bill;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class QryBillSchemeOutDTO extends CommonOutDTO {

	@ParamDesc(path = "MSG", cons = ConsType.CT001, len = "128", type = "string", desc = "推荐套餐资费描述", memo = "")
	
	private String prodPrcDesc;

	public QryBillSchemeOutDTO() {
	}

	@Override
	public MBean encode() {
		
		MBean mbean = super.encode();
		mbean.setRoot( getPathByProperName("prodPrcDesc"), prodPrcDesc );
		return mbean;
	}

	public String getProdPrcDesc() {
		return prodPrcDesc;
	}

	public void setProdPrcDesc(String prodPrcDesc) {
		this.prodPrcDesc = prodPrcDesc;
	}

}
