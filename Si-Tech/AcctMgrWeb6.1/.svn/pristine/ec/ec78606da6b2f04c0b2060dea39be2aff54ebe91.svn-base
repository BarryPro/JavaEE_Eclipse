package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayTransQryOpenInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.ActionDate", cons = ConsType.CT001, desc = "原交易发起方操作请求日期", len = "8", type = "string", memo = "略")
	private String actionDate;
	@ParamDesc(path = "BUSI_INFO.TransactionID", cons = ConsType.CT001, desc = "原交易发起方操作流水号", len = "32", type = "string", memo = "略")
	private String transActionId;
	@ParamDesc(path = "BUSI_INFO.IDValue", cons = ConsType.CT001, desc = "原交易报文中的号码", len = "32", type = "string", memo = "略")
	private String idValue;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		actionDate = arg0.getStr(getPathByProperName("actionDate"));
		transActionId = arg0.getStr(getPathByProperName("transActionId"));
		idValue = arg0.getStr(getPathByProperName("idValue"));
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

	/**
	 * @return the idValue
	 */
	public String getIdValue() {
		return idValue;
	}

	/**
	 * @param idValue the idValue to set
	 */
	public void setIdValue(String idValue) {
		this.idValue = idValue;
	}
}
