package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8203CfmInDTO extends CommonInDTO{
	
	@JSONField(name="BUSI_INFO.LIMIT_AREA")
	@ParamDesc(path="BUSI_INFO.LIMIT_AREA",cons=ConsType.CT001,type="String",len="1",desc="限额区域",memo="略")
	protected String limitArea;
	
	@JSONField(name="BUSI_INFO.LIMIT_TYPE")
	@ParamDesc(path="BUSI_INFO.LIMIT_TYPE",cons=ConsType.CT001,type="String",len="1",desc="限额类型",memo="略")
	protected String limitType;
	
	@JSONField(name="BUSI_INFO.REGION_GROUP")
	@ParamDesc(path="BUSI_INFO.REGION_GROUP",cons=ConsType.CT001,type="String",len="1",desc="地市group",memo="略")
	protected String regionGroup;
	
	@JSONField(name="BUSI_INFO.MSG_PHONE")
	@ParamDesc(path="BUSI_INFO.MSG_PHONE",cons=ConsType.CT001,type="String",len="11",desc="发短信号码",memo="略")
	protected String msgPhone;
	
	@JSONField(name="BUSI_INFO.DISTRICT_GROUP")
	@ParamDesc(path="BUSI_INFO.DISTRICT_GROUP",cons=ConsType.CT001,type="String",len="1",desc="区县group",memo="略")
	protected String districtGroup;
	
	@JSONField(name="BUSI_INFO.REGION_MONTH_LIMIT")
	@ParamDesc(path="BUSI_INFO.REGION_MONTH_LIMIT",cons=ConsType.CT001,type="String",len="1",desc="地市月限额",memo="略")
	protected String regionMonthLimit;
	
	@JSONField(name="BUSI_INFO.REGION_DAY_LIMIT")
	@ParamDesc(path="BUSI_INFO.REGION_DAY_LIMIT",cons=ConsType.CT001,type="String",len="1",desc="地市日限额",memo="略")
	protected String regionDayLimit;
	
	@JSONField(name="BUSI_INFO.DISTRICT_MONTH_LIMIT")
	@ParamDesc(path="BUSI_INFO.DISTRICT_MONTH_LIMIT",cons=ConsType.CT001,type="String",len="1",desc="区县月限额",memo="略")
	protected String districtMonthLimit;
	
	@JSONField(name="BUSI_INFO.DISTRICT_DAY_LIMIT")
	@ParamDesc(path="BUSI_INFO.DISTRICT_DAY_LIMIT",cons=ConsType.CT001,type="String",len="1",desc="区县日限额",memo="略")
	protected String districtDayLimit;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setLimitArea(arg0.getStr(getPathByProperName("limitArea")));
		setLimitType(arg0.getStr(getPathByProperName("limitType")));
		setRegionGroup(arg0.getStr(getPathByProperName("regionGroup")));
		setDistrictGroup(arg0.getStr(getPathByProperName("districtGroup")));
		setMsgPhone(arg0.getStr(getPathByProperName("msgPhone")));
		setRegionMonthLimit(arg0.getStr(getPathByProperName("regionMonthLimit")));
		setRegionDayLimit(arg0.getStr(getPathByProperName("regionDayLimit")));
		setDistrictMonthLimit(arg0.getStr(getPathByProperName("districtMonthLimit")));
		setDistrictDayLimit(arg0.getStr(getPathByProperName("districtDayLimit")));
	}
	
	/**
	 * @return the msgPhone
	 */
	public String getMsgPhone() {
		return msgPhone;
	}


	/**
	 * @param msgPhone the msgPhone to set
	 */
	public void setMsgPhone(String msgPhone) {
		this.msgPhone = msgPhone;
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

	/**
	 * @return the regionMonthLimit
	 */
	public String getRegionMonthLimit() {
		return regionMonthLimit;
	}
	
	/**
	 * @param regionMonthLimit the regionMonthLimit to set
	 */
	public void setRegionMonthLimit(String regionMonthLimit) {
		this.regionMonthLimit = regionMonthLimit;
	}
	
	/**
	 * @return the regionDayLimit
	 */
	public String getRegionDayLimit() {
		return regionDayLimit;
	}
	
	/**
	 * @param regionDayLimit the regionDayLimit to set
	 */
	public void setRegionDayLimit(String regionDayLimit) {
		this.regionDayLimit = regionDayLimit;
	}
	
	/**
	 * @return the districtMonthLimit
	 */
	public String getDistrictMonthLimit() {
		return districtMonthLimit;
	}
	
	/**
	 * @param distirctMonthLimit the districtMonthLimit to set
	 */
	public void setDistrictMonthLimit(String districtMonthLimit) {
		this.districtMonthLimit = districtMonthLimit;
	}
	
	/**
	 * @return the districtDayLimit
	 */
	public String getDistrictDayLimit() {
		return districtDayLimit;
	}
	
	/**
	 * @param districtDayLimit the districtDayLimit to set
	 */
	public void setDistrictDayLimit(String districtDayLimit) {
		this.districtDayLimit = districtDayLimit;
	}
	
	
}
