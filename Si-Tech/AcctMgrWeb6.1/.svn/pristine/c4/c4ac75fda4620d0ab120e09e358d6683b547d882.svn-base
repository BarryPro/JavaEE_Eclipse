package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPrcDetailQueryInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "BUSI_INFO.PRC_ID", cons = ConsType.CT001, type = "String", len = "20", desc = "资费定价代码", memo = "略")
	private String prcId;

	@ParamDesc(path = "BUSI_INFO.PRC_GROUP_ID", cons = ConsType.CT001, type = "String", len = "10", desc = "资费归属组织节点", memo = "略")
	private String prcGroupId;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		prcId = arg0.getStr(getPathByProperName("prcId"));
		prcGroupId = arg0.getStr(getPathByProperName("prcGroupId"));
	}

	public String getPrcId() {
		return prcId;
	}
	
	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}

	public String getPrcGroupId() {
		return prcGroupId;
	}

	public void setPrcGroupId(String prcGroupId) {
		this.prcGroupId = prcGroupId;
	}
}
