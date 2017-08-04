package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SGetGroupListInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.DISTRICT_GROUP", cons = ConsType.CT001, type = "String", len = "40", desc = "地市group", memo = "略")
	protected String disGroup;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		disGroup = arg0.getStr(getPathByProperName("disGroup"));
	}

	public String getDisGroup() {
		return disGroup;
	}

	public void setDisGroup(String disGroup) {
		this.disGroup = disGroup;
	}

}
