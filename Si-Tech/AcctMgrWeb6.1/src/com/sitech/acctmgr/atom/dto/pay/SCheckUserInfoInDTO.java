package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCheckUserInfoInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户ID",memo="")
	protected long idNo;
	
	@ParamDesc(path="BUSI_INFO.INV_NO",cons=ConsType.CT001,type="String",len="14",desc="发票号码",memo="")
	protected String invNo;
	
	@ParamDesc(path="BUSI_INFO.INV_CODE",cons=ConsType.CT001,type="String",len="14",desc="发票代码",memo="")
	protected String invCode;
	
	@Override
	public void decode(MBean arg0) {
		setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		setInvNo(arg0.getStr(getPathByProperName("invNo")));
		setInvCode(arg0.getStr(getPathByProperName("invCode")));
	}

	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the invNo
	 */
	public String getInvNo() {
		return invNo;
	}

	/**
	 * @param invNo the invNo to set
	 */
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	/**
	 * @return the invCode
	 */
	public String getInvCode() {
		return invCode;
	}

	/**
	 * @param invCode the invCode to set
	 */
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}
	
}
