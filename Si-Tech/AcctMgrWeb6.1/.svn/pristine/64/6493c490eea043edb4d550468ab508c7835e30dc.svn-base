package com.sitech.acctmgr.atom.dto.cct;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditQryInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "40", desc = "服务号码", memo = "PHONE_NO与ID_NO不能同时为空")
	String phoneNo = "";
	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.QUES, type = "String", len = "18", desc = "用户ID", memo = "PHONE_NO与ID_NO不能同时为空")
	String idNo;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		idNo = arg0.getStr(getPathByProperName("idNo"));
		if (StringUtils.isEmptyOrNull(phoneNo)
				&& StringUtils.isEmptyOrNull(idNo)) {
			throw new BusiException(getErrorCode(opCode, "00000"),
					"PHONE_NO,ID_NO不能同时为空");
		}

	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getIdNo() {
		return idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

}
