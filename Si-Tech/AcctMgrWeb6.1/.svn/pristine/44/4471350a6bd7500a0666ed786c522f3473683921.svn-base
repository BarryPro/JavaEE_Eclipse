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
public class S8014PrintInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2437286863730547360L;

	@ParamDesc(path = "BUSI_INFO.TRANS_SN", cons = ConsType.CT001, type = "long", len = "20", desc = "转账流水", memo = "略")
	private long tranSn;

	@ParamDesc(path = "BUSI_INFO.USER_FLAG", cons = ConsType.CT001, type = "long", len = "20", desc = "用户标识", memo = "略")
	private int userFlag;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		tranSn = ValueUtils.longValue(arg0.getStr(getPathByProperName("tranSn")));
		userFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("userFlag")));

	}

	public int getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}

	public long getTranSn() {
		return tranSn;
	}

	public void setTranSn(long tranSn) {
		this.tranSn = tranSn;
	}

}
