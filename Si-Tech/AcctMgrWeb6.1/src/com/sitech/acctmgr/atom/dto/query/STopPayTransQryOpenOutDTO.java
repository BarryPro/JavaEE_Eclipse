package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayTransQryOpenOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="ActionDate",cons= ConsType.CT001,type="string",len="8",desc="原交易发起方操作请求日期",memo="略")
	String actionDate;
	@ParamDesc(path="TransactionID",cons=ConsType.CT001,type="string",len="32",desc="原交易发起方操作流水号",memo="略")
	String transActionId;
	@ParamDesc(path="OprTime",cons=ConsType.CT001,type="string",len="32",desc="查询时间",memo="略")
	String queryTime;
	@ParamDesc(path="BizCode",cons=ConsType.CT001,type="string",len="4",desc="返回代码",memo="略")
	String rspCode;
	@ParamDesc(path="BizDesc",cons=ConsType.CT001,type="string",len="256",desc="错误信息描述",memo="略")
	String rspMsg;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("actionDate"), actionDate);
		result.setRoot(getPathByProperName("transActionId"), transActionId);
		result.setRoot(getPathByProperName("queryTime"), queryTime);
		result.setRoot(getPathByProperName("rspCode"), rspCode);
		result.setRoot(getPathByProperName("rspMsg"), rspMsg);
		return result;
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
	 * @return the rspCode
	 */
	public String getRspCode() {
		return rspCode;
	}

	/**
	 * @param rspCode the rspCode to set
	 */
	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}

	/**
	 * @return the rspMsg
	 */
	public String getRspMsg() {
		return rspMsg;
	}

	/**
	 * @param rspMsg the rspMsg to set
	 */
	public void setRspMsg(String rspMsg) {
		this.rspMsg = rspMsg;
	}

	/**
	 * @return the queryTime
	 */
	public String getQueryTime() {
		return queryTime;
	}

	/**
	 * @param queryTime the queryTime to set
	 */
	public void setQueryTime(String queryTime) {
		this.queryTime = queryTime;
	}
}
