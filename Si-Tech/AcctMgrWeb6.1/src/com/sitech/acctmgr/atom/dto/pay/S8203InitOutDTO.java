package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8203InitOutDTO extends CommonOutDTO{
	
	@JSONField(name="REGION_MONTH_LIMIT")
	@ParamDesc(path="REGION_MONTH_LIMIT",cons=ConsType.CT001,type="long",len="18",desc="地市月限额",memo="略")
	private long regionMonthLimit;
	
	@JSONField(name="REGION_DAY_LIMIT")
	@ParamDesc(path="REGION_DAY_LIMIT",cons=ConsType.CT001,type="long",len="18",desc="地市日限额",memo="略")
	private long regionDayLimit;
	
	@JSONField(name="DISTRICT_MONTH_LIMIT")
	@ParamDesc(path="DISTRICT_MONTH_LIMIT",cons=ConsType.CT001,type="long",len="18",desc="区县月限额",memo="略")
	private long districtMonthLimit;
	
	@JSONField(name="DISTRICT_DAY_LIMIT")
	@ParamDesc(path="DISTRICT_DAY_LIMIT",cons=ConsType.CT001,type="long",len="18",desc="区县日限额",memo="略")
	private long districtDayLimit;
	
	@JSONField(name="MSG_PHONE")
	@ParamDesc(path="MSG_PHONE",cons=ConsType.CT001,type="String",len="11",desc="发短信手机号",memo="略")
	private String msgPhone;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("regionMonthLimit"), regionMonthLimit);
		result.setRoot(getPathByProperName("regionDayLimit"), regionDayLimit);
		result.setRoot(getPathByProperName("districtMonthLimit"), districtMonthLimit);
		result.setRoot(getPathByProperName("districtDayLimit"), districtDayLimit);
		result.setRoot(getPathByProperName("msgPhone"), msgPhone);
		
		return result;
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
	 * @return the regionMonthLimit
	 */
	public long getRegionMonthLimit() {
		return regionMonthLimit;
	}
	
	/**
	 * @param regionMonthLimit the regionMonthLimit to set
	 */
	public void setRegionMonthLimit(long regionMonthLimit) {
		this.regionMonthLimit = regionMonthLimit;
	}
	
	/**
	 * @return the regionDayLimit
	 */
	public long getRegionDayLimit() {
		return regionDayLimit;
	}
	
	/**
	 * @param regionDayLimit the regionDayLimit to set
	 */
	public void setRegionDayLimit(long regionDayLimit) {
		this.regionDayLimit = regionDayLimit;
	}
	
	/**
	 * @return the distirctMonthLimit
	 */
	public long getDistrictMonthLimit() {
		return districtMonthLimit;
	}
	
	/**
	 * @param districtMonthLimit the districtMonthLimit to set
	 */
	public void setDistrictMonthLimit(long districtMonthLimit) {
		this.districtMonthLimit = districtMonthLimit;
	}
	
	/**
	 * @return the districtDayLimit
	 */
	public long getDistrictDayLimit() {
		return districtDayLimit;
	}
	
	/**
	 * @param districtDayLimit the districtDayLimit to set
	 */
	public void setDistrictDayLimit(long districtDayLimit) {
		this.districtDayLimit = districtDayLimit;
	}
	
	
	
	
}
