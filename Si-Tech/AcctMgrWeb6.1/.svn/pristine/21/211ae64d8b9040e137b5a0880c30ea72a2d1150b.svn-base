package com.sitech.acctmgr.atom.dto.cct;


import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8157InitInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "string", len = "40", desc = "服务号码", memo = "略")
	String phoneNo = "";
	/*@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "string", len = "18", desc = "用户ID", memo = "略")
	String idNo;*/


	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isEmptyOrNull(opCode)) {
			opCode = "8157";// 设置默认值
		}
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		

	}
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

}
