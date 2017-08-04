package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SDnyCreditCfmInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.ID_NO", cons = ConsType.CT001, desc = "用户ID", len = "15", type = "string", memo = "略")
	private long idNo;

	@ParamDesc(path = "BUSI_INFO.LIMIT_OWE", cons = ConsType.CT001, desc = "信用额度", len = "15", type = "string", memo = "略")
	private long limitOwe;

	// @ParamDesc(path = "BUSI_INFO.CREDIT_CODE", cons = ConsType.CT001, desc =
	// "等级代码", len = "15", type = "string", memo = "略")
	// private String creditCode;

	@ParamDesc(path = "BUSI_INFO.EXPIRE_TIME", cons = ConsType.CT001, desc = "失效时间", len = "15", type = "string", memo = "略")
	private String expireTime;

	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.CT001, desc = "操作类型", len = "15", type = "string", memo = "Y:修改   N:申请  R:取消")
	private String opType;

	@ParamDesc(path = "BUSI_INFO.OP_NOTE", cons = ConsType.CT001, desc = "备注", len = "100", type = "string", memo = "略")
	private String opNote;

	@ParamDesc(path = "BUSI_INFO.LOGIN_ACCEPT", cons = ConsType.CT001, desc = "操作流水", len = "100", type = "string", memo = "不使用时，默认传0")
	private long loginAccept = 0;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		limitOwe = Long.parseLong(arg0.getStr(getPathByProperName("limitOwe")));
		// creditCode = arg0.getStr(getPathByProperName("creditCode"));
		expireTime = arg0.getStr(getPathByProperName("expireTime"));
		opType = arg0.getStr(getPathByProperName("opType"));
		opNote = arg0.getStr(getPathByProperName("opNote"));
		if (arg0.getStr(getPathByProperName("loginAccept")) != null
				&& !arg0.getStr(getPathByProperName("loginAccept")).equals("")) {
			loginAccept = Long.parseLong(arg0
					.getStr(getPathByProperName("loginAccept")));
		}

	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public long getLimitOwe() {
		return limitOwe;
	}

	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}

	// public String getCreditCode() {
	// return creditCode;
	// }
	//
	// public void setCreditCode(String creditCode) {
	// this.creditCode = creditCode;
	// }

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	public String getOpType() {
		return opType;
	}

	public void setOpType(String opType) {
		this.opType = opType;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

}
