package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class GrpOweEntity {

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "合同号", memo = "略")
	protected long contractNo;

	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, type = "string", len = "18", desc = "账户名称", memo = "略")
	protected String contractName;

	@JSONField(name = "STATUS_NAME")
	@ParamDesc(path = "STATUS_NAME", cons = ConsType.CT001, type = "string", len = "18", desc = "状态", memo = "略")
	protected String statusName;

	@JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "string", len = "18", desc = "欠费", memo = "略")
	protected long oweFee;

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

}
