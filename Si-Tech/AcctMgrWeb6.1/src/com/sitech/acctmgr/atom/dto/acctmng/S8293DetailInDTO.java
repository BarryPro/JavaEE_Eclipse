package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293DetailInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7896989998183783535L;
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.QUES,type="String",len="20",desc="虚拟集团标识",memo="略")
	private String unitId;
	@ParamDesc(path="BUSI_INFO.UNIT_NAME",cons=ConsType.QUES,type="String",len="100",desc="虚拟集团名称",memo="略")
	private String unitName;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="用户号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo;
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setUnitId(arg0.getObject(getPathByProperName("unitId")).toString());		
		setUnitName(arg0.getObject(getPathByProperName("unitName")).toString());		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());		
		setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));

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

	/**
	 * @return the unitName
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * @param unitName the unitName to set
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
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
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

}
