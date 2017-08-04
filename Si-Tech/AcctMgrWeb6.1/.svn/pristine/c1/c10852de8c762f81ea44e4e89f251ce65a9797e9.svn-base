package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class InvInfoEntity {

	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.QUES, type = "string", len = "10", desc = "发票号码", memo = "略")
	private String invNo;

	@JSONField(name = "INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "string", len = "10", desc = "发票代码", memo = "略")
	private String invCode;

	@JSONField(name = "PRINT_YM")
	@ParamDesc(path = "PRINT_YM", cons = ConsType.QUES, type = "string", len = "10", desc = "打印日期", memo = "略")
	private int printYm;

	@JSONField(name = "INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.QUES, type = "string", len = "10", desc = "发票类型", memo = "略")
	private String invType;

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public int getPrintYm() {
		return printYm;
	}

	public void setPrintYm(int printYm) {
		this.printYm = printYm;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

}
