package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8509OperRecdInDTO extends CommonInDTO {

	private static final long serialVersionUID = -8472959337475736370L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号码", memo = "略")
	private String phoneNo = "";

	@ParamDesc(path = "BUSI_INFO.BEGIN_YM", cons = ConsType.CT001, type = "string", len = "10", desc = "开始年月", memo = "略")
	private String beginYm;

	@ParamDesc(path = "BUSI_INFO.END_YM", cons = ConsType.CT001, type = "string", len = "10", desc = "结束年月", memo = "略")
	private String endYm;

	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setBeginYm(arg0.getStr(getPathByProperName("beginYm")));
		setEndYm(arg0.getStr(getPathByProperName("endYm")));
	}

	public String getBeginYm() {
		return beginYm;
	}

	public void setBeginYm(String beginYm) {
		this.beginYm = beginYm;
	}

	public String getEndYm() {
		return endYm;
	}

	public void setEndYm(String endYm) {
		this.endYm = endYm;
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
