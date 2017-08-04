package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SKdRemainInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="10",desc="账本类型",memo="")
	private String payType = "";
	@ParamDesc(path="BUSI_INFO.PRC_ID",cons=ConsType.CT001,type="String",len="10",desc="资费",memo="")
	private String prcId = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		payType = arg0.getStr(getPathByProperName("payType"));
		prcId = arg0.getStr(getPathByProperName("prcId"));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

	/**
	 * @return the prcId
	 */
	public String getPrcId() {
		return prcId;
	}

	/**
	 * @param prcId the prcId to set
	 */
	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}
}
