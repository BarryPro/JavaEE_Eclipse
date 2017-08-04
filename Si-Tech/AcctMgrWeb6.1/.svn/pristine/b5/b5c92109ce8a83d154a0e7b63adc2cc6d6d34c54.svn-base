package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8509ChangeShipStatusInDTO extends CommonInDTO {

	private static final long serialVersionUID = -8472959337475736370L;
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "服务号码", memo = "略")
	protected String phoneNo = "";

	@ParamDesc(path = "BUSI_INFO.FLAG", cons = ConsType.CT001, type = "string", len = "1", desc = "标志", memo = "1:关闭，0：开通")
	protected String flag;

	public void decode(MBean arg0) {
		super.decode(arg0);

		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setFlag(arg0.getStr(getPathByProperName("flag")).toString());

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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}
