package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SOweQueryInDTO extends CommonInDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.CT001, type = "String", len = "20", desc = "用户号码", memo = "略")
	private long idNo = 0;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

}
