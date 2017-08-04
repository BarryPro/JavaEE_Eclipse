package com.sitech.acctmgr.atom.dto.invoice;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class S8157PrintInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2437286863730547360L;

	@ParamDesc(path = "BUSI_INFO.LOGIN_ACCEPT", cons = ConsType.CT001, type = "long", len = "20", desc = "转账流水", memo = "略")
	private long loginAccept;

	@ParamDesc(path = "BUSI_INFO.OPR_TIME", cons = ConsType.CT001, type = "long", len = "20", desc = "操作时间", memo = "YYYYMMDD")
	private int oprTime;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		loginAccept = ValueUtils.longValue(arg0.getStr(getPathByProperName("loginAccept")));
		oprTime = ValueUtils.intValue(arg0.getStr(getPathByProperName("oprTime")));

	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public int getOprTime() {
		return oprTime;
	}

	public void setOprTime(int oprTime) {
		this.oprTime = oprTime;
	}


}
