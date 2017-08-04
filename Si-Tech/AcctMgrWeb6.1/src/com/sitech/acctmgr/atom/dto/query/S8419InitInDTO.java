package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8419InitInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.AGT_PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="代理商号码",memo="略")
	protected String agtPhoneNo = "";
	/*
	@ParamDesc(path="BUSI_INFO.PASS_WORD",cons=ConsType.QUES,type="String",len="20",desc="代理商密码",memo="略")
	protected String passWord = "";
	*/
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.QUES,type="String",len="8",desc="开始时间",memo="略")
	protected String beginDate = "";
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.QUES,type="String",len="8",desc="结束时间",memo="略")
	protected String endDate = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);	
		setAgtPhoneNo(arg0.getObject(getPathByProperName("agtPhoneNo")).toString());
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginDate")))) {
			setBeginDate(arg0.getObject(getPathByProperName("beginDate")).toString());
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endDate")))) {
			setEndDate(arg0.getObject(getPathByProperName("endDate")).toString());
		}
		
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
}
