package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class SDnyCreditQryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// @ParamDesc(path = "CREDIT_CODE", cons = ConsType.CT001, len = "", type =
	// "string", desc = "动态信誉度等级", memo = "略")
	// private String creditCode = null;

	@ParamDesc(path = "LIMIT_OWE", cons = ConsType.CT001, len = "", type = "long", desc = "欠费额度", memo = "略")
	private long limitOwe = 0;

	@ParamDesc(path = "EXPIRE_TIME", cons = ConsType.CT001, len = "", type = "string", desc = "失效日期", memo = "略")
	private String expireTime;

	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, len = "", type = "string", desc = "用户ID", memo = "略")
	private long idNo = 0;

	@Override
	public MBean encode() {
		MBean result = super.encode();

		// result.setRoot(getPathByProperName("creditCode"), creditCode);
		result.setRoot(getPathByProperName("limitOwe"), limitOwe);
		result.setRoot(getPathByProperName("expireTime"), expireTime);
		result.setRoot(getPathByProperName("idNo"), idNo);
		return result;
	}


	// public String getCreditCode() {
	// return creditCode;
	// }
	//
	// public void setCreditCode(String creditCode) {
	// this.creditCode = creditCode;
	// }

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getLimitOwe() {
		return limitOwe;
	}

	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

}
