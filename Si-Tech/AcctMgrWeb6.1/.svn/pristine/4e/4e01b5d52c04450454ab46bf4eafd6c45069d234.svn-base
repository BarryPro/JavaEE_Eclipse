package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SJtPrepayInitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="String",len="18",desc="集团账户号码",memo="略")
	private String contractNo = "";
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="15",desc="操作员手机号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.CT001,type="String",len="14",desc="集团编码",memo="略")
	private String unitId = "";
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = arg0.getStr(getPathByProperName("contractNo"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		unitId = arg0.getStr(getPathByProperName("unitId"));
	}

	/**
	 * @return the contractNo
	 */
	public String getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
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
	 * @return the unitId
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}
}
