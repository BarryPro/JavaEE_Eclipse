package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.prod.UserPrcDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SUserPrcDetailQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "DETAIL_LIST", desc = "详细列表", cons = ConsType.CT001, type = "complex", len = "1", memo = "")
	private List<UserPrcDetailEntity> userPrcDetailList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("userPrcDetailList"), userPrcDetailList);
		return result;
	}

	public List<UserPrcDetailEntity> getUserPrcDetailList() {
		return userPrcDetailList;
	}

	public void setUserPrcDetailList(List<UserPrcDetailEntity> userPrcDetailList) {
		this.userPrcDetailList = userPrcDetailList;
	}

}
