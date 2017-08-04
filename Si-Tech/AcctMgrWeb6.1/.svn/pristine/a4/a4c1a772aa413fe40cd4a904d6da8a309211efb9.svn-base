package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8288GrpInitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 332920470967166419L;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="40",desc="集团编码",memo="略")
	private String unitId;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());
	
	}

	/**
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}
}
