package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S50MRoofedOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4098913673083449268L;
	
    @ParamDesc(path = "OPEN_RESULT", cons = ConsType.CT001, type = "String", len = "1", desc = "查询结果", memo = "略")
    private String openResult;
    
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("openResult"), openResult);

		return result;
	}

	/**
	 * @return the openResult
	 */
	public String getOpenResult() {
		return openResult;
	}

	/**
	 * @param openResult the openResult to set
	 */
	public void setOpenResult(String openResult) {
		this.openResult = openResult;
	}
}
