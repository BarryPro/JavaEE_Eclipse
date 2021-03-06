package com.sitech.acctmgr.atom.dto.invoice;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8248QryLoginNoInDTO extends CommonInDTO {

	/**
	 * region_id
	 */
	private static final long serialVersionUID = 7933264595937882367L;
	@ParamDesc(path = "BUSI_INFO.LOGIN_TYPE", cons = ConsType.CT001, type = "String", len = "10", desc = "工号类型", memo = "略")
	private String loginType;
	@ParamDesc(path = "BUSI_INFO.REGION_ID", cons = ConsType.CT001, type = "String", len = "10", desc = "地市代码", memo = "略")
	private String regionId;
	
	
	public String getLoginType() {
		return loginType;
	}


	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

	

	/**
	 * @return the regionId
	 */
	public String getRegionId() {
		return regionId;
	}


	/**
	 * @param regionId the regionId to set
	 */
	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}


	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		System.out.println("#####"+StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("regionId"))));
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("loginType")))||StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("regionId")))){
			throw new BusiException(getErrorCode("8048", "00021"), "工号类型或者地市代码丢失,请重新登录");
		}else{
			this.setLoginType(arg0.getStr(getPathByProperName("loginType")));
			//System.out.println("loginTYpe="+getPathByProperName("loginType"));
			this.setRegionId(arg0.getStr(getPathByProperName("regionId")));
		}
		
		
		
	}
}
