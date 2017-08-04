package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * Created by liuhl_bj on 2016/8/9.
 */
public class SGrpUserOffLineByUnitIdOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "USER_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "集团用户列表", memo = "略")
	private List<UserDeadEntity> userList;

	@ParamDesc(path = "CNT", cons = ConsType.CT001, type = "int", len = "1", desc = "帐户列表个数", memo = "略")
	private int cnt;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody(getPathByProperName("userList"), userList);
		result.setBody(getPathByProperName("cnt"), cnt);
		return result;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public List<UserDeadEntity> getUserList() {
		return userList;
	}

	public void setUserList(List<UserDeadEntity> userList) {
		this.userList = userList;
	}

}
