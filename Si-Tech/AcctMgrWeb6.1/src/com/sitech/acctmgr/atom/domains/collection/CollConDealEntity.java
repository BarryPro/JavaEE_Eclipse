package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 托收内容处理实体
 * 
 */
public class CollConDealEntity {
    @JSONField(name = "CONTRACT_NO")
    @ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "用户账号", type = "long", memo = "略")
    private long contractNo;

    @JSONField(name = "PAY_MONEY")
    @ParamDesc(path = "PAY_MONEY", cons = ConsType.CT001, len = "14", desc = "用户托收金额", type = "long", memo = "略")
    private long payMoney;

    @JSONField(name = "LOGIN_NO")
    @ParamDesc(path = "LOGIN_NO", cons = ConsType.CT001, len = "20", desc = "操作工号", type = "String", memo = "略")
    private String loginNo;

    @JSONField(name = "PASS_NO")
    @ParamDesc(path = "PASS_NO", cons = ConsType.CT001, len = "16", desc = "通过编号", type = "String", memo = "略")
    private String passNo;

    @JSONField(name = "GROUP_ID")
    @ParamDesc(path = "GROUP_ID", cons = ConsType.CT001, len = "20", desc = "组织编号", type = "String", memo = "略")
    private String groupId;
    
    @JSONField(name = "OP_CODE")
    @ParamDesc(path = "OP_CODE", cons = ConsType.CT001, len = "4", desc = "操作代码", type = "String", memo = "略")
    private String opCode;
    
    @JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, len = "6", desc = "托收单生成帐务月", type = "int", memo = "略")
    private int yearMonth;
    
    @JSONField(name = "PAY_TYPE")
    @ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, len = "5", desc = "支付类型", type = "String", memo = "略")
    private String payType;
    
    @JSONField(name = "OP_NOTE")
    @ParamDesc(path = "OP_NOTE", cons = ConsType.CT001, len = "60", desc = "服务注释", type = "String", memo = "略")
    private String opNote;
    
    @JSONField(name = "FETCH_NO")
    @ParamDesc(path = "FETCH_NO", cons = ConsType.CT001, len = "8", desc = "获取编号", type = "int", memo = "略")
    private int fetchNo;
    
    @JSONField(name = "DEAL_FLAG")
    @ParamDesc(path = "DEAL_FLAG", cons = ConsType.CT001, len = "1", desc = "处理标识", type = "String", memo = "略")
    private String dealFlag;

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getPassNo() {
		return passNo;
	}

	public void setPassNo(String passNo) {
		this.passNo = passNo;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public int getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public int getFetchNo() {
		return fetchNo;
	}

	public void setFetchNo(int fetchNo) {
		this.fetchNo = fetchNo;
	}

	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}
    
}
