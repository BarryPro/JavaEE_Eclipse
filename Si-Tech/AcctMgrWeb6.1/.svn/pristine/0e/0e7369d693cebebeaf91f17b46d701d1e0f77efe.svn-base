package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8054GetSPInfoInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5260839848514503331L;

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8054";
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

}
