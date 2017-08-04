package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8428QueryInDTO extends CommonInDTO{
	
	@ParamDesc(path = "BUSI_INFO.REGION_GROUP", cons = ConsType.CT001, type = "String", len = "40", desc = "地市", memo = "略")
	protected String regionGroup;
	@ParamDesc(path="BUSI_INFO.DISTRICT_GROUP",cons=ConsType.CT001,type="String",len="18",desc="区县",memo="略")
	protected String districtGroup;
	@ParamDesc(path="BUSI_INFO.COUNT_YM",cons=ConsType.CT001,type="String",len="18",desc="统计年月",memo="略")
	protected String countYm;
	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, type = "string", len = "1", desc = "页数", memo = "")
	private String pageNum;
	
	@ParamDesc(path = "BUSI_INFO.QUERY_SN", cons = ConsType.CT001, type = "Long", len = "14", desc = "查詢流水", memo = "")
	private String querySn;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setRegionGroup(arg0.getStr(getPathByProperName("regionGroup")));
		setDistrictGroup(arg0.getStr(getPathByProperName("districtGroup")));
		setCountYm(arg0.getStr(getPathByProperName("countYm")));
		setPageNum(arg0.getStr(getPathByProperName("pageNum")));
		this.querySn = arg0.getStr(getPathByProperName("querySn"));
	}
	
	/**
	 * @return the querySn
	 */
	public String getQuerySn() {
		return querySn;
	}

	/**
	 * @param querySn the querySn to set
	 */
	public void setQuerySn(String querySn) {
		this.querySn = querySn;
	}

	/**
	 * @return the pageNum
	 */
	public String getPageNum() {
		return pageNum;
	}

	/**
	 * @param pageNum the pageNum to set
	 */
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
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
	 * @return the countYm
	 */
	public String getCountYm() {
		return countYm;
	}

	/**
	 * @param countYm the countYm to set
	 */
	public void setCountYm(String countYm) {
		this.countYm = countYm;
	}
	
	
	
}
