package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SMallPayQryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="PHONE_NO和CONTRACT_NO不能同时为空，传其中一个入参")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="8",desc="开始时间",memo="年月日")
	private String beginDate = "";
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.CT001,type="String",len="8",desc="结束时间",memo="年月日")
	private String endDate = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="String",len="18",desc="账户号码",memo="PHONE_NO和CONTRACT_NO不能同时为空，传其中一个入参")
	protected String contractNo = "";
	@ParamDesc(path="BUSI_INFO.OTHER_FLAG",cons=ConsType.QUES,type="String",len="1",desc="查询方式",memo="0:号码 1:账户")
	protected String otherFlag = "";

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		beginDate = arg0.getStr(getPathByProperName("beginDate"));
		endDate = arg0.getStr(getPathByProperName("endDate"));
		otherFlag = arg0.getStr(getPathByProperName("otherFlag"));
		if(arg0.getObject(getPathByProperName("phoneNo")) != null && !arg0.getObject(getPathByProperName("phoneNo")).equals("")){
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			contractNo = arg0.getStr(getPathByProperName("contractNo"));
		}
		if(Integer.parseInt(beginDate) > Integer.parseInt(endDate)) {
			throw new BusiException("0000", "00001", "开始时间不能大于结束时间");
		}
		if(StringUtils.isEmptyOrNull(phoneNo)&&StringUtils.isEmptyOrNull(contractNo)){
			throw new BusiException("0000", "00002", "服务号码和账户号码不能同时为空");
		}
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
	 * @return the beginDate
	 */
	public String getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	 * @return the otherFlag
	 */
	public String getOtherFlag() {
		return otherFlag;
	}

	/**
	 * @param otherFlag the otherFlag to set
	 */
	public void setOtherFlag(String otherFlag) {
		this.otherFlag = otherFlag;
	}
	
}
