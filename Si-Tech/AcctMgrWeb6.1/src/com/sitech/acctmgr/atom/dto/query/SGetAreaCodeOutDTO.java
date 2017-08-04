package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SGetAreaCodeOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2964272094387624177L;
	@ParamDesc(path="BUSI_INFO.PROV_CODE",cons=ConsType.QUES,type="String",len="4",desc="省代码",memo="略")
	private String provCode;
	@ParamDesc(path="BUSI_INFO.MODE_BEGIN",cons=ConsType.QUES,type="String",len="10",desc="省名称",memo="略")
	private String provName;
	@ParamDesc(path="BUSI_INFO.MODE_END",cons=ConsType.QUES,type="String",len="4",desc="区代码",memo="略")
	private String longCode;
	@ParamDesc(path="BUSI_INFO.CITY_NAME",cons=ConsType.QUES,type="String",len="10",desc="城市名称",memo="略")
	private String cityName;
	@ParamDesc(path="BUSI_INFO.HOME_AREA",cons=ConsType.QUES,type="String",len="32",desc="省市名称",memo="略")
	private String homeArea;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="7",desc="7位手机号段",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.HLJ_FLAG",cons=ConsType.QUES,type="String",len="1",desc="黑龙江移动号码标识",memo="略")
	private String hljFlag;
	

	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("provCode"), provCode);
		result.setRoot(getPathByProperName("provName"), provName);
		result.setRoot(getPathByProperName("cityName"), cityName);
		result.setRoot(getPathByProperName("longCode"), longCode);
		result.setRoot(getPathByProperName("homeArea"), homeArea);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("hljFlag"), hljFlag);

		return result;
	}


	/**
	 * @return the provCode
	 */
	public String getProvCode() {
		return provCode;
	}


	/**
	 * @param provCode the provCode to set
	 */
	public void setProvCode(String provCode) {
		this.provCode = provCode;
	}


	/**
	 * @return the provName
	 */
	public String getProvName() {
		return provName;
	}


	/**
	 * @param provName the provName to set
	 */
	public void setProvName(String provName) {
		this.provName = provName;
	}


	/**
	 * @return the longCode
	 */
	public String getLongCode() {
		return longCode;
	}


	/**
	 * @param longCode the longCode to set
	 */
	public void setLongCode(String longCode) {
		this.longCode = longCode;
	}


	/**
	 * @return the cityName
	 */
	public String getCityName() {
		return cityName;
	}


	/**
	 * @param cityName the cityName to set
	 */
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}


	/**
	 * @return the homeArea
	 */
	public String getHomeArea() {
		return homeArea;
	}


	/**
	 * @param homeArea the homeArea to set
	 */
	public void setHomeArea(String homeArea) {
		this.homeArea = homeArea;
	}


	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}


	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	/**
	 * @return the hljFlag
	 */
	public String getHljFlag() {
		return hljFlag;
	}


	/**
	 * @param hljFlag the hljFlag to set
	 */
	public void setHljFlag(String hljFlag) {
		this.hljFlag = hljFlag;
	}
}
