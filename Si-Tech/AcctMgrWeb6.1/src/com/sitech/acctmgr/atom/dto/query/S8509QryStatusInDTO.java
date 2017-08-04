package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8509QryStatusInDTO extends CommonInDTO {

	private static final long serialVersionUID = -8472959337475736370L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号码", memo = "略")
	protected String phoneNo = "";

	public void decode(MBean arg0) {
		super.decode(arg0);
		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			throw new BusiException(AcctMgrError.getErrorCode("8509", "00000"), "服务号码不能为空");
		}
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());

	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
}
