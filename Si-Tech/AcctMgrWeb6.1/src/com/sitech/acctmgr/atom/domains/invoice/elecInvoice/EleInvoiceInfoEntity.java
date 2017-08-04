package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class EleInvoiceInfoEntity {

	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	@JSONField(name = "INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票类型", memo = "略")
	private String invType;

	@JSONField(name = "REQUEST_SN")
	@ParamDesc(path = "REQUEST_SN", cons = ConsType.QUES, type = "String", len = "20", desc = "请求流水", memo = "略")
	private String requestSn;

	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "操作时间", memo = "略")
	private String opTime;

	@JSONField(name = "STATE")
	@ParamDesc(path = "STATE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票状态", memo = "1：开具    6：冲红")
	private String state;

	@JSONField(name = "OP_NAME")
	@ParamDesc(path = "OP_NAME", cons = ConsType.QUES, type = "String", len = "20", desc = "操作名称", memo = "")
	private String opName;

	@JSONField(name = "OP_CODE")
	@ParamDesc(path = "OP_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "操作代码", memo = "略")
	private String opCode;

	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "操作工号", memo = "略")
	private String loginNo;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "开票合计金额", memo = "单位分")
	private long printFee;

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.QUES, type = "String", len = "20", desc = "操作流水", memo = "略")
	private String loginAccept;

	public String getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public String getRequestSn() {
		return requestSn;
	}

	public void setRequestSn(String requestSn) {
		this.requestSn = requestSn;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}


}
