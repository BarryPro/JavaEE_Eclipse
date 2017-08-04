package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SClassifyPreInitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3089841443993683271L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.QUES,type="String",len="5",desc="支付类型",memo="略")
	protected String payType = "";
	@ParamDesc(path="BUSI_INFO.QUERY_FLAG",cons=ConsType.QUES,type="String",len="5",desc="业务标识",memo="略")
	protected String queryFlag = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payType")))){
			setPayType(arg0.getObject(getPathByProperName("payType")).toString());
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("queryFlag")))){
			setQueryFlag(arg0.getObject(getPathByProperName("queryFlag")).toString());
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
	 * @return the queryFlag
	 */
	public String getQueryFlag() {
		return queryFlag;
	}

	/**
	 * @param queryFlag the queryFlag to set
	 */
	public void setQueryFlag(String queryFlag) {
		this.queryFlag = queryFlag;
	}
	
	
}
