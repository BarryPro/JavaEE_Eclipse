package com.sitech.acctmgr.atom.domains.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class CRMOrderInfoEntity {

	@JSONField(name = "OP_CODE")
	@ParamDesc(path = "OP_CODE", cons = ConsType.QUES, type = "String", len = "100", desc = "业务编码", memo = "略")
	private String opCode;

	@JSONField(name = "OP_NAME")
	@ParamDesc(path = "OP_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "业务名称", memo = "略")
	private String opName;

	@JSONField(name = "ORDER_ID")
	@ParamDesc(path = "ORDER_ID", cons = ConsType.QUES, type = "String", len = "100", desc = "订单编号", memo = "略")
	private String orderId;

	@JSONField(name = "SERVICE_NO")
	@ParamDesc(path = "SERVICE_NO", cons = ConsType.QUES, type = "String", len = "100", desc = "用户手机号码", memo = "略")
	private String serviceNo;

	@JSONField(name = "TAX_LIST")
	@ParamDesc(path = "TAX_LIST", cons = ConsType.QUES, type = "compx", len = "100", desc = "税率列表", memo = "略")
	private List<CRMTaxEntity> taxList;

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getServiceNo() {
		return serviceNo;
	}

	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}

	public List<CRMTaxEntity> getTaxList() {
		return taxList;
	}

	public void setTaxList(List<CRMTaxEntity> taxList) {
		this.taxList = taxList;
	}

	@Override
	public String toString() {
		return "CRMOrderInfoEntity [opCode=" + opCode + ", opName=" + opName + ", orderId=" + orderId + ", serviceNo=" + serviceNo + ", taxList="
				+ taxList + "]";
	}

}
