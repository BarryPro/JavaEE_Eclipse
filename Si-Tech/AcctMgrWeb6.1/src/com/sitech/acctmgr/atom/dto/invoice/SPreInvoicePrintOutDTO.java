package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPreInvoicePrintOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4671065283533784774L;

	@JSONField(name = "RETURN_CODE")
	@ParamDesc(path = "RETURN_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "返回代码", memo = "略")
	private String returnCode;

	@JSONField(name = "RETURN_MSG")
	@ParamDesc(path = "RETURN_MSG", cons = ConsType.QUES, type = "String", len = "20", desc = "返回信息", memo = "略")
	private String returnMsg;
	@Override
	public MBean encode() {

		MBean result = new MBean();
		result.setRoot(getPathByProperName("returnCode"), returnCode);
		result.setRoot(getPathByProperName("returnMsg"), returnMsg);
		return result;

	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}


}
