package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STopPayTransQryOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="ACTION_DATE",cons= ConsType.CT001,type="string",len="8",desc="交易日期",memo="略")
	String actionDate;
	@ParamDesc(path="TRANSACTION_ID",cons=ConsType.CT001,type="string",len="32",desc="交易流水",memo="略")
	String transActionId;
	@ParamDesc(path="RSPCODE",cons=ConsType.CT001,type="string",len="32",desc="返回代码",memo="略")
	String rspCode;
	@ParamDesc(path="RSPMSG",cons=ConsType.CT001,type="string",len="32",desc="返回信息",memo="略")
	String rspMsg;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("actionDate"), actionDate);
		result.setRoot(getPathByProperName("transActionId"), transActionId);
		result.setRoot(getPathByProperName("rspCode"), rspCode);
		result.setRoot(getPathByProperName("rspMsg"), rspMsg);
		return result;
	}

	public String getActionDate() {
		return actionDate;
	}

	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}

	public String getTransActionId() {
		return transActionId;
	}

	public void setTransActionId(String transActionId) {
		this.transActionId = transActionId;
	}

	public String getRspCode() {
		return rspCode;
	}

	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}

	public String getRspMsg() {
		return rspMsg;
	}

	public void setRspMsg(String rspMsg) {
		this.rspMsg = rspMsg;
	}
}
