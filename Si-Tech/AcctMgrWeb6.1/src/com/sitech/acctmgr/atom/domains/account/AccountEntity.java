package com.sitech.acctmgr.atom.domains.account;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title: 展示账户信息（账户类型，账户余额，账户未出帐话费）
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl
 * @version 1.0
 */
public class AccountEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8276125212039500352L;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号码", memo = "略")
	private long contractNo;

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "余额", memo = "单位：分")
	private long remainFee;

	@JSONField(name = "ACCOUNT_TYPE")
	@ParamDesc(path = "ACCOUNT_TYPE", cons = ConsType.QUES, type = "string", len = "20", desc = "账户类型", memo = "略")
	private String accountType;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "未出帐话费", memo = "单位：分")
	private long unbillFee;

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public long getUnbillFee() {
		return unbillFee;
	}

	public void setUnbillFee(long unbillFee) {
		this.unbillFee = unbillFee;
	}

	@Override
	public String toString() {
		return "AccountEntity [contractNo=" + contractNo + ", remainFee="
				+ remainFee + ", accountType=" + accountType + ", unbillFee="
				+ unbillFee + "]";
	}

}
