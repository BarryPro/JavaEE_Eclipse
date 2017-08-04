package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCRMIntellPrtCollectInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.BEGIN_DATE",cons=ConsType.CT001,type="String",len="14",desc="开始时间",memo="例如：20170417")
	protected String beginDate;
	
	@ParamDesc(path="BUSI_INFO.END_DATE",cons=ConsType.CT001,type="String",len="14",desc="结束时间",memo="例如：20170417")
	protected String endDate;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setBeginDate(arg0.getStr(getPathByProperName("beginDate")));
		setEndDate(arg0.getStr(getPathByProperName("endDate")));
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
