package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 
 * @author liuhl_bj
 *
 */
public class PreInvoiceRecycleEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.CT001, type = "long", len = "10", desc = "打印流水", memo = "略")
	private long printSn;

	@JSONField(name = "PRINT_FEE")
	@ParamDesc(path = "PRINT_FEE", cons = ConsType.CT001, type = "long", len = "10", desc = "打印金额", memo = "略")
	private long printFee;

	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "string", len = "10", desc = "操作时间", memo = "略")
	private String opTime;

	@JSONField(name = "GRP_CONTRACT_NO")
	@ParamDesc(path = "GRP_CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "10", desc = "产品账号", memo = "略")
	private long grpContractNo;

	@JSONField(name = "GRP_PHONE_NO")
	@ParamDesc(path = "GRP_PHONE_NO", cons = ConsType.CT001, type = "string", len = "10", desc = "产品号码", memo = "略")
	private String grpPhoneNo;

	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "产品名称", memo = "略")
	private String contractName;

	@JSONField(name = "UNIT_ID")
	@ParamDesc(path = "UNIT_ID", cons = ConsType.CT001, type = "long", len = "10", desc = "虚拟集团号码", memo = "略")
	private long unitId;

	@JSONField(name = "FLAG")
	@ParamDesc(path = "FLAG", cons = ConsType.CT001, type = "boolean", len = "10", desc = "是否为集团账户", memo = "0：个人    1：集团   2：一点支付账户")
	private int flag;

	@JSONField(name = "STATE")
	@ParamDesc(path = "STATE", cons = ConsType.CT001, type = "string", len = "10", desc = "状态", memo = "p:预开发票   c:取消   r:回收")
	private String state;

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public long getGrpContractNo() {
		return grpContractNo;
	}

	public void setGrpContractNo(long grpContractNo) {
		this.grpContractNo = grpContractNo;
	}

	public String getGrpPhoneNo() {
		return grpPhoneNo;
	}

	public void setGrpPhoneNo(String grpPhoneNo) {
		this.grpPhoneNo = grpPhoneNo;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}


}
