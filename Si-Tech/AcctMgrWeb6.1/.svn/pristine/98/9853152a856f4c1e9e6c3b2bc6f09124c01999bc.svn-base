package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.prod.UserGgPrcInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

public class SUserPrcDetailGgQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "PRC_LIST", desc = "gg资费订购列表", cons = ConsType.CT001, type = "complex", len = "1", memo = "")
	private List<UserGgPrcInfoEntity> prcList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("prcList"), prcList);
		return result;
	}

	public List<UserGgPrcInfoEntity> getPrcList() {
		return prcList;
	}

	public void setPrcList(List<UserGgPrcInfoEntity> prcList) {
		this.prcList = prcList;
	}
}
