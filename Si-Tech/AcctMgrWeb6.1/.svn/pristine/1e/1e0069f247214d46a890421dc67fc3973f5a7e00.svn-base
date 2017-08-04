package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by wangyla on 2016/7/21.
 */
public class SFeeQueryBalanceQueryInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, desc = "服务号码", len = "15", type = "string", memo = "略")
	private String phoneNo;
	@ParamDesc(path = "BUSI_INFO.MAIN_FLAG", cons = ConsType.CT001, desc = "主副卡标志", len = "1", type = "string", memo = "可空，0:主卡；1:副卡")
	private String mainFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("mainFlag")))){
			mainFlag = arg0.getStr(getPathByProperName("mainFlag"));
		}
		
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the mainFlag
	 */
	public String getMainFlag() {
		return mainFlag;
	}

	/**
	 * @param mainFlag the mainFlag to set
	 */
	public void setMainFlag(String mainFlag) {
		this.mainFlag = mainFlag;
	}
}
