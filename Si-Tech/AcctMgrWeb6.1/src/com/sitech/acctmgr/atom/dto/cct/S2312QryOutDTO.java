package com.sitech.acctmgr.atom.dto.cct;

import java.util.List;

import com.sitech.acctmgr.atom.domains.cct.UnStopHolidayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S2312QryOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "REGION_CODE", cons = ConsType.CT001, len = "10", type = "string", desc = "地市代码", memo = "略")
	private String regionCode;
	@ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, len = "40", type = "string", desc = "地市名称", memo = "略")
	private String regionName;
	@ParamDesc(path = "RESULT_LIST", cons=ConsType.STAR,type="complex", len = "40", desc = "节假日列表", memo = "略")
    protected List<UnStopHolidayEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("regionCode"), regionCode);
		result.setRoot(getPathByProperName("regionName"), regionName);
	    result.setRoot(getPathByProperName("resultList"), resultList);
		
		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<UnStopHolidayEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<UnStopHolidayEntity> resultList) {
		this.resultList = resultList;
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
}
