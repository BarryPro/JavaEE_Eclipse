package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPayQueryInDTO extends CommonInDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="int",len="6",desc="开始时间",memo="年月日")
	private int beginDate = 0;
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.CT001,type="int",len="6",desc="结束时间",memo="年月日")
	private int endDate = 0;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		beginDate = Integer.parseInt(arg0.getStr(getPathByProperName("beginDate")));
		endDate = Integer.parseInt(arg0.getStr(getPathByProperName("endDate")));
		if(beginDate > endDate) {
			throw new BusiException(opCode, "00001", "开始时间不能大于结束时间");
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
	public int getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(int beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public int getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

}
