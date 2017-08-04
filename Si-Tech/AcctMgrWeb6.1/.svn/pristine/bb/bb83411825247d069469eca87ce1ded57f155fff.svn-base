package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8424QryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "手机号码", memo = "")
	protected String phoneNo;
	@ParamDesc(path = "BUSI_INFO.REGION_CODE", cons = ConsType.CT001, type = "String", len = "18", desc = "地市编码", memo = "略")
	protected String regionCode;
	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "String", len = "6", desc = "开始年月", memo = "略")
	protected String beginYm;
	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "String", len = "6", desc = "结束年月", memo = "")
	protected String endYm;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		if (arg0.getStr(getPathByProperName("phoneNo")) != null && !arg0.getStr(getPathByProperName("phoneNo")).equals("")) {
			setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		}

		if (arg0.getStr(getPathByProperName("regionCode")) != null && !arg0.getStr(getPathByProperName("regionCode")).equals("")) {
			setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		}
		
		if (arg0.getStr(getPathByProperName("beginYm")) != null && !arg0.getStr(getPathByProperName("beginYm")).equals("")) {
			setBeginYm(arg0.getStr(getPathByProperName("beginYm")));
		}
		
		if (arg0.getStr(getPathByProperName("endYm")) != null && !arg0.getStr(getPathByProperName("endYm")).equals("")) {
			setEndYm(arg0.getStr(getPathByProperName("endYm")));
		}

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
	 * @return the beginYm
	 */
	public String getBeginYm() {
		return beginYm;
	}

	/**
	 * @param beginYm the beginYm to set
	 */
	public void setBeginYm(String beginYm) {
		this.beginYm = beginYm;
	}

	/**
	 * @return the endYm
	 */
	public String getEndYm() {
		return endYm;
	}

	/**
	 * @param endYm the endYm to set
	 */
	public void setEndYm(String endYm) {
		this.endYm = endYm;
	}


}
