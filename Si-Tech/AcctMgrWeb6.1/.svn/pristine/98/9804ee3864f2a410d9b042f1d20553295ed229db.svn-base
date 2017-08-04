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
public class PayInfoEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_no", cons = ConsType.CT001, type = "int", len = "10", desc = "服务号码", memo = "略")
	private String phoneNo;

	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.CT001, type = "int", len = "10", desc = "操作时间", memo = "略")
	private String opTime;

	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path = "LOGIN_ACCEPT", cons = ConsType.CT001, type = "int", len = "10", desc = "操作流水", memo = "略")
	private long loginAccept;

	@JSONField(name = "OP_NAME")
	@ParamDesc(path = "OP_NAME", cons = ConsType.CT001, type = "int", len = "10", desc = "操作代码", memo = "略")
	private String opName;

	@JSONField(name = "PAY_METHOD")
	@ParamDesc(path = "PAY_METHOD", cons = ConsType.CT001, type = "int", len = "10", desc = "缴费方式", memo = "略")
	private String payMethod;

	@JSONField(name = "PAY_MONEY")
	@ParamDesc(path = "PAY_MONEY", cons = ConsType.CT001, type = "int", len = "10", desc = "缴费金额", memo = "略")
	private long payMoney;

	@JSONField(name = "PREPAY_FEE")
	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "int", len = "10", desc = "预存款", memo = "略")
	private long prepayFee;

	@JSONField(name = "ALL_OWE")
	@ParamDesc(path = "ALL_OWE", cons = ConsType.CT001, type = "int", len = "10", desc = "话费", memo = "略")
	private long allOwe;

	@JSONField(name = "ALL_DELAY")
	@ParamDesc(path = "ALL_DELAY", cons = ConsType.CT001, type = "int", len = "10", desc = "滞纳金", memo = "略")
	private long allDelay;

	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, type = "int", len = "10", desc = "操作工号", memo = "略")
	private String loginNo;

	@JSONField(name = "PRINT_FLAG")
	@ParamDesc(path = "PRINT_FLAG", cons = ConsType.CT001, type = "int", len = "10", desc = "打印标示", memo = "0：未打印 1：已打印")
	private int printFlag;

	@JSONField(name = "POWER_FLAG")
	@ParamDesc(path = "POWER_FLAG", cons = ConsType.CT001, type = "int", len = "10", desc = "是否为银行渠道工号", memo = "0:否  1：是")
	private int powerFlag;

	@JSONField(name = "TOTAL_DATE")
	@ParamDesc(path = "TOTAL_DATE", cons = ConsType.CT001, type = "int", len = "10", desc = "缴费日期", memo = "")
	private String totalDate;

	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "用户名称", memo = "")
	private String custName;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "10", desc = "账户号码", memo = "")
	private long contractNo;

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public long getPrepayFee() {
		return prepayFee;
	}

	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	public long getAllOwe() {
		return allOwe;
	}

	public void setAllOwe(long allOwe) {
		this.allOwe = allOwe;
	}

	public long getAllDelay() {
		return allDelay;
	}

	public void setAllDelay(long allDelay) {
		this.allDelay = allDelay;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String string) {
		this.loginNo = string;
	}

	public int getPrintFlag() {
		return printFlag;
	}

	public void setPrintFlag(int printFlag) {
		this.printFlag = printFlag;
	}

	public int getPowerFlag() {
		return powerFlag;
	}

	public void setPowerFlag(int powerFlag) {
		this.powerFlag = powerFlag;
	}

	public String getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

}
