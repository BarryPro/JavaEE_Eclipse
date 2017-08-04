package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 宽带补收获取资费标识入参DTO
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuyc_billing
 * @version 1.0
 */
public class S8010GetItemInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1741416351209924434L;
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
	protected String phoneNo;
	@ParamDesc(path = "BUSI_INFO.NO_TYPE", cons = ConsType.STAR, type = "String", len = "40", desc = "号码类型", memo = "略")
	protected String noType;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setNoType(arg0.getStr(getPathByProperName("noType")));
	}
	
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getNoType() {
		return noType;
	}

	public void setNoType(String noType) {
		this.noType = noType;
	}
}
