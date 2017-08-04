package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8258QryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.QUES, type = "string", len = "20", desc = "集团编码", memo = "略")
	String UnitId = "";

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		UnitId = arg0.getStr(getPathByProperName("UnitId"));
		

	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return UnitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		UnitId = unitId;
	}
}
