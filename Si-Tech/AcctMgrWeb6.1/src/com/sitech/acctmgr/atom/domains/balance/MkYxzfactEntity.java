package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 *
 * <p>Title:  返费对象</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2017</p>
 * <p>Company: SI-TECH </p>
 * @author  hanfl
 * @version 1.0
 */
public class MkYxzfactEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1533641822522363888L;

	@JSONField(name = "OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="5",desc="opCode",memo="略")
	private String opCode;
	
	@JSONField(name = "LJ_PAY")
	@ParamDesc(path="LJ_PAY",cons=ConsType.CT001,type="long",len="14",desc="立即返费金额",memo="略")
	private long ljPay;
	
	@JSONField(name = "LJ_PAYTYPE")
	@ParamDesc(path="LJ_PAYTYPE",cons=ConsType.CT001,type="String",len="5",desc="返费类型",memo="略")
	private String ljPayType;
	
	@JSONField(name = "REST_PAY")
	@ParamDesc(path="REST_PAY",cons=ConsType.CT001,type="long",len="14",desc="剩余每月返费金额",memo="略")
	private long restPay;
	
	@JSONField(name = "REST_MONTH")
	@ParamDesc(path="REST_MONTH",cons=ConsType.CT001,type="int",len="6",desc="剩余返费月数",memo="略")
	private int restMonth;	
	
	@JSONField(name = "REST_TOTAL_PAY")
	@ParamDesc(path="REST_TOTAL_PAY",cons=ConsType.CT001,type="long",len="14",desc="剩余返费总金额",memo="略")
	private long restTotalPay;
	
	@JSONField(name = "REST_PAYTYPE")
	@ParamDesc(path="REST_PAYTYPE",cons=ConsType.CT001,type="String",len="5",desc="返费类型",memo="略")
	private String restPayType;
		
	@JSONField(name = "EXPENSE_MONTH")
	@ParamDesc(path="EXPENSE_MONTH",cons=ConsType.CT001,type="int",len="6",desc="消费月数",memo="略")
	private int expenseMonth;
		
	@JSONField(name = "ACCUMULATE_TYPE")
	@ParamDesc(path="ACCUMULATE_TYPE",cons=ConsType.CT001,type="String",len="5",desc="是否累积到次月",memo="略")
	private String accumulateType;
	
	@JSONField(name = "LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="工号",memo="略")
	private String loginNo;
	
	@JSONField(name = "REGION_CODE")
	@ParamDesc(path="REGION_CODE",cons=ConsType.CT001,type="String",len="5",desc="配置地市",memo="略")
	private String regionCode;
	
	@JSONField(name = "REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="5",desc="地市名称",memo="略")
	private String regionName;
	
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="14",desc="操作时间",memo="略")
	private String opTime;
	
	@JSONField(name = "LOGIN_ACCEPT")
	@ParamDesc(path="LOGIN_ACCEPT",cons=ConsType.CT001,type="long",len="14",desc="操作流水",memo="")
	private long loginAccept;

	@JSONField(name = "PAY_NAME")
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="String",len="20",desc="返费类型",memo="")
	private long payName;
	
	public MkYxzfactEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getRegionCode() {
		return regionCode;
	}

	public String getRegionName() {
		return regionName;
	}

	public String getOpCode() {
		return opCode;
	}

	public long getRestPay() {
		return restPay;
	}
	
	public String getRestPayType() {
		return restPayType;
	}
	
	public int getRestMonth() {
		return restMonth;
	}

	public int getExpenseMonth() {
		return expenseMonth;
	}

	public String getAccumulateType() {
		return accumulateType;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public long getLjPay() {
		return ljPay;
	}

	public String getLjPayType() {
		return ljPayType;
	}

	public long getRestTotalPay() {
		return restTotalPay;
	}

	public String getOpTime() {
		return opTime;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public void setRestPay(long restPay) {
		this.restPay = restPay;
	}

	public void setRestPayType(String restPayType) {
		this.restPayType = restPayType;
	}

	public void setRestMonth(int restMonth) {
		this.restMonth = restMonth;
	}

	public void setExpenseMonth(int expenseMonth) {
		this.expenseMonth = expenseMonth;
	}

	public void setAccumulateType(String accumulateType) {
		this.accumulateType = accumulateType;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public void setLjPay(long ljPay) {
		this.ljPay = ljPay;
	}

	public void setLjPayType(String ljPayType) {
		this.ljPayType = ljPayType;
	}

	public void setRestTotalPay(long restTotalPay) {
		this.restTotalPay = restTotalPay;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public long getPayName() {
		return payName;
	}

	public void setPayName(long payName) {
		this.payName = payName;
	}


}
