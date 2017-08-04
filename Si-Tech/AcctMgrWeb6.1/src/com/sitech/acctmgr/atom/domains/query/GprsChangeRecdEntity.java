package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class GprsChangeRecdEntity {

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, len = "10", type = "long", desc = "操作流水", memo = "略")
	private long loginAccept;

	@JSONField(name = "OPEN_TIME")
	@ParamDesc(path = "OPEN_TIME", cons = ConsType.CT001, len = "10", type = "String", desc = "开通时间", memo = "略")
	private String openTime;

	@JSONField(name = "OPEN_LOGIN_NO")
	@ParamDesc(path = "OPEN_LOGIN_NO", cons = ConsType.CT001, len = "10", type = "String", desc = "开通工号", memo = "略")
	private String openLoginNo;

	@JSONField(name = "CLOSE_TIME")
	@ParamDesc(path = "CLOSE_TIME", cons = ConsType.CT001, len = "10", type = "String", desc = "上次关闭的时间", memo = "略")
	private String closeTime;

	@JSONField(name = "CLOSE_LOGIN_NO")
	@ParamDesc(path = "CLOSE_LOGIN_NO", cons = ConsType.CT001, len = "10", type = "String", desc = "上次关闭的工号", memo = "略")
	private String closeLoginNo;

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getOpenLoginNo() {
		return openLoginNo;
	}

	public void setOpenLoginNo(String openLoginNo) {
		this.openLoginNo = openLoginNo;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public String getCloseLoginNo() {
		return closeLoginNo;
	}

	public void setCloseLoginNo(String closeLoginNo) {
		this.closeLoginNo = closeLoginNo;
	}

}
