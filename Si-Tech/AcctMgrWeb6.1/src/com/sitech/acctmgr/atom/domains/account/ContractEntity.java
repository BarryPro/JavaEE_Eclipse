package com.sitech.acctmgr.atom.domains.account;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * Created by wangyla on 2016/5/11.
 */
public class ContractEntity {
	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "用户ID", memo = "")
	private long id;
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "18", desc = "账户ID", memo = "")
	private long con;
	@JSONField(name = "CUST_ID")
	@ParamDesc(path = "CUST_ID", cons = ConsType.CT001, type = "long", len = "18", desc = "客户ID", memo = "")
	private long custId;
	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "支付类型", memo = "")
	private String payType;
	@JSONField(name = "EFF_DATE")
	@ParamDesc(path = "EFF_DATE", cons = ConsType.CT001, type = "string", len = "30", desc = "账户生效时间", memo = "")
	private String effDate;
	@JSONField(name = "EXP_DATE")
	@ParamDesc(path = "EXP_DATE", cons = ConsType.CT001, type = "string", len = "30", desc = "账户失效时间", memo = "")
	private String expDate;
	@JSONField(name = "ACCOUNT_NAME")
	@ParamDesc(path = "ACCOUNT_NAME", cons = ConsType.CT001, type = "string", len = "128", desc = "账户名称", memo = "")
	private String accountName;
	@JSONField(name = "ATT_TYPE")
	@ParamDesc(path = "ATT_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "账户类型代码", memo = "")
	private String attType;
	@JSONField(name = "PAY_CODE")
	@ParamDesc(path = "PAY_CODE", cons = ConsType.CT001, type = "string", len = "2", desc = "支付代码", memo = "")
	private String payCode;
	@JSONField(name = "ATTTYPE_NAME")
	@ParamDesc(path = "ATTTYPE_NAME", cons = ConsType.CT001, type = "string", len = "20", desc = "账户类型名称", memo = "")
	private String attTypeName;
	@JSONField(name = "PAYCODE_NAME")
	@ParamDesc(path = "PAYCODE_NAME", cons = ConsType.CT001, type = "string", len = "20", desc = "支付代码名称", memo = "")
	private String payCodeName;

	private long billOrder;

	@JSONField(serialize = false)
	private long payValue;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCon() {
		return con;
	}

	public void setCon(long con) {
		this.con = con;
	}

	public long getCustId() {
		return custId;
	}

	public void setCustId(long custId) {
		this.custId = custId;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAttType() {
		return attType;
	}

	public void setAttType(String attType) {
		this.attType = attType;
	}

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getAttTypeName() {
		return attTypeName;
	}

	public void setAttTypeName(String attTypeName) {
		this.attTypeName = attTypeName;
	}

	public String getPayCodeName() {
		return payCodeName;
	}

	public void setPayCodeName(String payCodeName) {
		this.payCodeName = payCodeName;
	}

	public long getPayValue() {
		return payValue;
	}

	public void setPayValue(long payValue) {
		this.payValue = payValue;
	}

	public long getBillOrder() {
		return billOrder;
	}

	public void setBillOrder(long billOrder) {
		this.billOrder = billOrder;
	}

	@Override
	public String toString() {
		return "ContractEntity [id=" + id + ", con=" + con + ", custId=" + custId + ", payType=" + payType + ", effDate=" + effDate + ", expDate="
				+ expDate + ", accountName=" + accountName + ", attType=" + attType + ", payCode=" + payCode + ", attTypeName=" + attTypeName
				+ ", payCodeName=" + payCodeName + ", billOrder=" + billOrder + ", payValue=" + payValue + "]";
	}

}
