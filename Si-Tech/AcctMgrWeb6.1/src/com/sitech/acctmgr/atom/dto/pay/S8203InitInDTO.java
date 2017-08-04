package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8203InitInDTO extends CommonInDTO{
	
	@JSONField(name="BUSI_INFO.LIMIT_AREA")
	@ParamDesc(path="BUSI_INFO.LIMIT_AREA",cons=ConsType.CT001,type="String",len="10",desc="限额区域",memo="略")
	protected String limitArea;
	
	@JSONField(name="BUSI_INFO.LIMIT_TYPE")
	@ParamDesc(path="BUSI_INFO.LIMIT_TYPE",cons=ConsType.CT001,type="String",len="10",desc="限额类型",memo="略")
	protected String limitType;
	
	@JSONField(name="BUSI_INFO.REGION_GROUP")
	@ParamDesc(path="BUSI_INFO.REGION_GROUP",cons=ConsType.CT001,type="String",len="10",desc="地市",memo="略")
	protected String regionGroup;
	
	@JSONField(name="BUSI_INFO.DISTRICT_GROUP")
	@ParamDesc(path="BUSI_INFO.DISTRICT_GROUP",cons=ConsType.CT001,type="String",len="10",desc="区县",memo="略")
	protected String districtGroup;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setLimitArea(arg0.getStr(getPathByProperName("limitArea")));
		setLimitType(arg0.getStr(getPathByProperName("limitType")));
		setRegionGroup(arg0.getStr(getPathByProperName("regionGroup")));
		setDistrictGroup(arg0.getStr(getPathByProperName("districtGroup")));
	}
	
	/**
	 * @return the limitArea
	 */
	public String getLimitArea() {
		return limitArea;
	}
	
	/**
	 * @param limitArea the limitArea to set
	 */
	public void setLimitArea(String limitArea) {
		this.limitArea = limitArea;
	}
	
	/**
	 * @return the limitType
	 */
	public String getLimitType() {
		return limitType;
	}
	
	/**
	 * @param limitType the limitType to set
	 */
	public void setLimitType(String limitType) {
		this.limitType = limitType;
	}
	
	/**
	 * @return the regionGroup
	 */
	public String getRegionGroup() {
		return regionGroup;
	}
	
	/**
	 * @param regionGroup the regionGroup to set
	 */
	public void setRegionGroup(String regionGroup) {
		this.regionGroup = regionGroup;
	}
	
	/**
	 * @return the districtGroup
	 */
	public String getDistrictGroup() {
		return districtGroup;
	}
	
	/**
	 * @param districtGroup the districtGroup to set
	 */
	public void setDistrictGroup(String districtGroup) {
		this.districtGroup = districtGroup;
	}
	
}
