package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl
 *
 */
public class SMonthShareQryOutDTO extends CommonOutDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "USER_PRC_LIST", cons = ConsType.CT001, desc = "资费列表", len = "10", type = "list", memo = "")
	private List<UserPrcEntity> userPrcList;

	@ParamDesc(path = "USER_PRC_DETAIL_LIST", cons = ConsType.CT001, desc = "详细资费列表", len = "10", type = "list", memo = "")
	private List<UserPdPrcDetailInfoEntity> userPrcDetailList;
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("userPrcList"), userPrcList);
		result.setRoot(getPathByProperName("userPrcDetailList"), userPrcDetailList);
		return result;
	}

	public List<UserPrcEntity> getUserPrcList() {
		return userPrcList;
	}

	public void setUserPrcList(List<UserPrcEntity> userPrcList) {
		this.userPrcList = userPrcList;
	}

	public List<UserPdPrcDetailInfoEntity> getUserPrcDetailList() {
		return userPrcDetailList;
	}

	public void setUserPrcDetailList(List<UserPdPrcDetailInfoEntity> userPrcDetailList) {
		this.userPrcDetailList = userPrcDetailList;
	}


}
