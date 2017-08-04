package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S2315OutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "REGION_CODE", cons = ConsType.CT001, type = "String", len = "20", desc = "地市", memo = "略")
	protected String regionCode;
	@ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, type = "String", len = "20", desc = "地市名称", memo = "略")
	protected String regionName;
	@ParamDesc(path = "OP_TYPE", cons = ConsType.CT001, type = "String", len = "20", desc = "操作类型", memo = "略")
	protected String opType;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("regionCode"), regionCode);
		result.setRoot(getPathByProperName("regionName"), regionName);
		result.setRoot(getPathByProperName("opType"), opType);
		return result;
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

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	
}
