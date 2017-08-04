package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayTransQryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.ACTION_DATE", cons = ConsType.CT001, desc = "交易日期", len = "8", type = "string", memo = "略")
	private String actionDate;
	@ParamDesc(path = "BUSI_INFO.TRANSACTION_ID", cons = ConsType.CT001, desc = "交易流水", len = "32", type = "string", memo = "略")
	private String transActionId;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		actionDate = arg0.getStr(getPathByProperName("actionDate"));
		transActionId = arg0.getStr(getPathByProperName("transActionId"));

	}

	/**
	 * @return the actionDate
	 */
	public String getActionDate() {
		return actionDate;
	}

	/**
	 * @param actionDate the actionDate to set
	 */
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}

	/**
	 * @return the transActionId
	 */
	public String getTransActionId() {
		return transActionId;
	}

	/**
	 * @param transActionId the transActionId to set
	 */
	public void setTransActionId(String transActionId) {
		this.transActionId = transActionId;
	}
}
