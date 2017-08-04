package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAgentOprInitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -790400149267743436L;
	@ParamDesc(path="BUSI_INFO.AGT_PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="代理商号码",memo="略")
	protected String agtPhoneNo = "";
	@ParamDesc(path="BUSI_INFO.OPR_DATE",cons=ConsType.QUES,type="String",len="8",desc="操作日期",memo="可空")
	protected String oprDate = "";
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="可空")
	protected String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.QUERY_TYPE",cons=ConsType.QUES,type="String",len="1",desc="查询类型",memo="1：查询当天；2：查询指定日期；3：查询指定号码24小时内交易记录")
	protected String queryType = "";
	
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))){
			setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		}
		
		setAgtPhoneNo(arg0.getObject(getPathByProperName("agtPhoneNo")).toString());
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("oprDate")))){
			setOprDate(arg0.getObject(getPathByProperName("oprDate")).toString());
		}
		
		setQueryType(arg0.getObject(getPathByProperName("queryType")).toString());

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
	 * @return the agtPhoneNo
	 */
	public String getAgtPhoneNo() {
		return agtPhoneNo;
	}

	/**
	 * @param agtPhoneNo the agtPhoneNo to set
	 */
	public void setAgtPhoneNo(String agtPhoneNo) {
		this.agtPhoneNo = agtPhoneNo;
	}

	/**
	 * @return the oprDate
	 */
	public String getOprDate() {
		return oprDate;
	}

	/**
	 * @param oprDate the oprDate to set
	 */
	public void setOprDate(String oprDate) {
		this.oprDate = oprDate;
	}

	/**
	 * @return the queryType
	 */
	public String getQueryType() {
		return queryType;
	}

	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}
}
