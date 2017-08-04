package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSendMailInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "40", desc = "服务号码", memo = "")
	private String phoneno;

	@ParamDesc(path = "BUSI_INFO.QRY_DATE", cons = ConsType.STAR, type = "string", len = "18", desc = "查询年月", memo = "")
	private String qryDate;

	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		phoneno = arg0.getStr(getPathByProperName("phoneno"));
		qryDate = arg0.getStr(getPathByProperName("qryDate"));
	}

	public String getPhoneno() {
		return phoneno;
	}

	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}

	public String getQryDate() {
		return qryDate;
	}

	public void setQryDate(String qryDate) {
		this.qryDate = qryDate;
	}

}
