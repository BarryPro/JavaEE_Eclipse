package com.sitech.acctmgr.atom.domains.base;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

/**
 * 
* @Title:   []
* @Description: 一点支付缴费：被支付账户对象列表
* @Date : 2015年3月12日下午6:01:25
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class RegionListEntity implements Serializable {


	@JSONField(name="REGION_CODE")
	@ParamDesc(path="REGION_CODE",cons=ConsType.CT001,type="string",len="10",desc="地市编码",memo="全省：2200")
	private String regionCode;

	@JSONField(name="REGION_GROUP")
	@ParamDesc(path="REGION_GROUP",cons=ConsType.CT001,type="string",len="128",desc="账户名称",memo="略")
	private String regionGroup;
	
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="string",len="18",desc="缴费方式",memo="略")
	private String regionName;

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

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RegionListEntity [regionCode=" + regionCode + ", regionGroup="
				+ regionGroup + ", regionName=" + regionName + "]";
	}

	

	
}
