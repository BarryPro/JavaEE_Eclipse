package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.balance.BalanceEntity;
import com.sitech.acctmgr.atom.domains.invoice.MonthInvoiceDispEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8224QryInvoOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1809694410776959864L;
	@JSONField(name = "INVICE_DISP")
	@ParamDesc(path = "INVICE_DISP", cons = ConsType.CT001, type = "compx", len = "10", desc = "发票展示内容", memo = "略")
	private List<MonthInvoiceDispEntity> invDisp;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "int", len = "10", desc = "服务号码", memo = "略")
	private String phoneNo;

	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "int", len = "10", desc = "客户名称", memo = "略")
	private String custName;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "int", len = "10", desc = "账户号码", memo = "略")
	private long contractNo;

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.CT001, type = "int", len = "10", desc = "余额", memo = "略")
	private long remainFee;

	@JSONField(name = "PAY_SN_LIST")
	@ParamDesc(path = "PAY_SN_LIST", cons = ConsType.CT001, type = "int", len = "10", desc = "", memo = "略")
	private List<BalanceEntity> paySnList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invDisp"), this.invDisp);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("custName"), custName);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		result.setRoot(getPathByProperName("paySnList"), paySnList);
		result.setRoot(getPathByProperName("remainFee"), remainFee);

		return result;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public List<BalanceEntity> getPaySnList() {
		return paySnList;
	}

	public void setPaySnList(List<BalanceEntity> paySnList) {
		this.paySnList = paySnList;
	}

	public List<MonthInvoiceDispEntity> getInvDisp() {
		return invDisp;
	}

	public void setInvDisp(List<MonthInvoiceDispEntity> invDisp) {
		this.invDisp = invDisp;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

}
