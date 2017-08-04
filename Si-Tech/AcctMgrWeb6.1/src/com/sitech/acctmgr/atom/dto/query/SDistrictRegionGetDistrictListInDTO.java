package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDistrictRegionGetDistrictListInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.REGION_GROUP", cons = ConsType.CT001, type = "String", len = "40", desc = "地市group", memo = "略")
	protected String  regionGroup;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setRegionGroup(arg0.getStr(getPathByProperName("regionGroup")));
	}

	public String getRegionGroup() {
		return regionGroup;
	}

	public void setRegionGroup(String regionGroup) {
		this.regionGroup = regionGroup;
	}
	
	

}
