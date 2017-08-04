package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S2315InDTO extends CommonInDTO{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.REGION_CODE", cons = ConsType.QUES, type = "String", len = "10", desc = "地市", memo = "")
	String regionCode = "";
	
	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.QUES, type = "String", len = "10", desc = "操作类型", memo = "OFF：禁用模式；HRB：哈尔滨个性模式；HLJ：全省统一模式")
	String opType = "";
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));

	}

	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}
}
