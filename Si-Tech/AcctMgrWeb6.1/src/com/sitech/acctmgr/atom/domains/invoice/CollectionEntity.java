package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 托收单实体
 * 
 * @author liuhl_bj
 *
 */
public class CollectionEntity {

	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, type = "string", len = "10", desc = "工号", memo = "略")
	private String loginNo;

	@JSONField(name = "PRINT_DATE")
	@ParamDesc(path = "PRINT_DATE", cons = ConsType.CT001, type = "string", len = "10", desc = "打印日期", memo = "略")
	private String printDate;

	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "账户名称", memo = "略")
	private String contractName;

	@JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.CT001, type = "string", len = "10", desc = "银行名称", memo = "略")
	private String bankName;

	@JSONField(name = "BANK_ACCOUNT")
	@ParamDesc(path = "BANK_ACCOUNT", cons = ConsType.CT001, type = "string", len = "10", desc = "银行账号", memo = "略")
	private String bankAccount;

	@JSONField(name = "BANK_CODE")
	@ParamDesc(path = "BANK_CODE", cons = ConsType.CT001, type = "string", len = "10", desc = "银行代码", memo = "略")
	private String bankCode;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "string", len = "10", desc = "账户号码", memo = "略")
	private long contractNo;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "string", len = "10", desc = "服务号码", memo = "略")
	private String phoneNo;

	@JSONField(name = "BIG_MONEY")
	@ParamDesc(path = "BIG_MONEY", cons = ConsType.CT001, type = "string", len = "10", desc = "大写金额", memo = "略")
	private String bigMoney;

	@JSONField(name = "SMALL_MONEY")
	@ParamDesc(path = "SMALL_MONEY", cons = ConsType.CT001, type = "string", len = "10", desc = "小写金额", memo = "略")
	private String smallMoney;

	@JSONField(name = "FEE1")
	@ParamDesc(path = "FEE1", cons = ConsType.CT001, type = "string", len = "10", desc = "月租费", memo = "略")
	private long fee1;

	@JSONField(name = "FEE2")
	@ParamDesc(path = "FEE2", cons = ConsType.CT001, type = "string", len = "10", desc = "特服费", memo = "略")
	private long fee2;

	@JSONField(name = "FEE3")
	@ParamDesc(path = "FEE3", cons = ConsType.CT001, type = "string", len = "10", desc = "市话费", memo = "略")
	private long fee3;

	@JSONField(name = "FEE4")
	@ParamDesc(path = "FEE4", cons = ConsType.CT001, type = "string", len = "10", desc = "长途费", memo = "略")
	private long fee4;

	@JSONField(name = "FEE5")
	@ParamDesc(path = "FEE5", cons = ConsType.CT001, type = "string", len = "10", desc = "漫游费", memo = "略")
	private long fee5;

	@JSONField(name = "FEE6")
	@ParamDesc(path = "FEE6", cons = ConsType.CT001, type = "string", len = "10", desc = "信息费", memo = "略")
	private long fee6;

	@JSONField(name = "FEE7")
	@ParamDesc(path = "FEE7", cons = ConsType.CT001, type = "string", len = "10", desc = "频占费", memo = "略")
	private long fee7;

	@JSONField(name = "FEE8")
	@ParamDesc(path = "FEE8", cons = ConsType.CT001, type = "string", len = "10", desc = "IP话费", memo = "略")
	private long fee8;

	@JSONField(name = "FEE9")
	@ParamDesc(path = "FEE9", cons = ConsType.CT001, type = "string", len = "10", desc = "其他费", memo = "略")
	private long fee9;

	@JSONField(name = "FEE10")
	@ParamDesc(path = "FEE10", cons = ConsType.CT001, type = "string", len = "10", desc = "可视电话费", memo = "略")
	private long fee10;

	@JSONField(name = "FEE11")
	@ParamDesc(path = "FEE11", cons = ConsType.CT001, type = "string", len = "10", desc = "预存划拨", memo = "略")
	private long fee11;

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

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

	public String getBigMoney() {
		return bigMoney;
	}

	public void setBigMoney(String bigMoney) {
		this.bigMoney = bigMoney;
	}

	public String getSmallMoney() {
		return smallMoney;
	}

	public void setSmallMoney(String smallMoney) {
		this.smallMoney = smallMoney;
	}

	public long getFee1() {
		return fee1;
	}

	public void setFee1(long fee1) {
		this.fee1 = fee1;
	}

	public long getFee2() {
		return fee2;
	}

	public void setFee2(long fee2) {
		this.fee2 = fee2;
	}

	public long getFee3() {
		return fee3;
	}

	public void setFee3(long fee3) {
		this.fee3 = fee3;
	}

	public long getFee4() {
		return fee4;
	}

	public void setFee4(long fee4) {
		this.fee4 = fee4;
	}

	public long getFee5() {
		return fee5;
	}

	public void setFee5(long fee5) {
		this.fee5 = fee5;
	}

	public long getFee6() {
		return fee6;
	}

	public void setFee6(long fee6) {
		this.fee6 = fee6;
	}

	public long getFee7() {
		return fee7;
	}

	public void setFee7(long fee7) {
		this.fee7 = fee7;
	}

	public long getFee8() {
		return fee8;
	}

	public void setFee8(long fee8) {
		this.fee8 = fee8;
	}

	public long getFee9() {
		return fee9;
	}

	public void setFee9(long fee9) {
		this.fee9 = fee9;
	}

	public long getFee10() {
		return fee10;
	}

	public void setFee10(long fee10) {
		this.fee10 = fee10;
	}

	public long getFee11() {
		return fee11;
	}

	public void setFee11(long fee11) {
		this.fee11 = fee11;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getPrintDate() {
		return printDate;
	}

	public void setPrintDate(String printDate) {
		this.printDate = printDate;
	}

}
