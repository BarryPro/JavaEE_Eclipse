package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBackPayQryInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	protected String phoneNo = "";
	
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.QUES,type="String",len="8",desc="开始日期",memo="年月日")
	protected String beginDate = "";
	
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.QUES,type="String",len="8",desc="结束日期",memo="年月日")
	protected String endDate = "";
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		setPhoneNo(arg0.getObject(getPathByProperName("phoneNo")).toString());
		setBeginDate(arg0.getObject(getPathByProperName("beginDate")).toString());
		setEndDate(arg0.getObject(getPathByProperName("endDate")).toString());
	
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
}
