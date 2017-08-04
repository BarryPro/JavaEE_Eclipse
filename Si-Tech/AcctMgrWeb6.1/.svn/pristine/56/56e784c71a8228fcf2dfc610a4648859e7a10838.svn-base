package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8250CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 762890844709039120L;

	@ParamDesc(path="BUSI_INFO.REGION_CODE",cons=ConsType.CT001,type="String",len="5",desc="配置地市",memo="略")
	private String regionCode;
	
	@ParamDesc(path="BUSI_INFO.OP_CODE",cons=ConsType.CT001,type="String",len="5",desc="opCode",memo="略")
	private String opCode;

	@ParamDesc(path="BUSI_INFO.REST_PAY",cons=ConsType.CT001,type="String",len="14",desc="每月返费金额",memo="略")
	private String restPay;
	
	@ParamDesc(path="BUSI_INFO.REST_PAYTYPE",cons=ConsType.CT001,type="String",len="5",desc="返费专款类型",memo="略")
	private String restPayType;
	
	@ParamDesc(path="BUSI_INFO.REST_MONTH",cons=ConsType.CT001,type="String",len="6",desc="返费月数",memo="略")
	private String restMonth;
	
	@ParamDesc(path="BUSI_INFO.EXPENSE_MONTH",cons=ConsType.CT001,type="String",len="6",desc="消费月数",memo="略")
	private String expenseMonth;
	
	@ParamDesc(path="BUSI_INFO.ACCUMULATE_TYPE",cons=ConsType.CT001,type="String",len="5",desc="是否累积到次月",memo="略")
	private String accumulateType;
		
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setAccumulateType(arg0.getStr(getPathByProperName("accumulateType")));
		setExpenseMonth(arg0.getStr(getPathByProperName("expenseMonth")));
		setOpCode(arg0.getStr(getPathByProperName("opCode")));
		setRestMonth(arg0.getStr(getPathByProperName("restMonth")));
		setRestPay(arg0.getStr(getPathByProperName("restPay")));
		setRestPayType(arg0.getStr(getPathByProperName("restPayType")));
		
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getRestPay() {
		return restPay;
	}

	public void setRestPay(String restPay) {
		this.restPay = restPay;
	}

	public String getRestPayType() {
		return restPayType;
	}

	public void setRestPayType(String restPayType) {
		this.restPayType = restPayType;
	}

	public String getRestMonth() {
		return restMonth;
	}

	public void setRestMonth(String restMonth) {
		this.restMonth = restMonth;
	}

	public String getExpenseMonth() {
		return expenseMonth;
	}

	public void setExpenseMonth(String expenseMonth) {
		this.expenseMonth = expenseMonth;
	}

	public String getAccumulateType() {
		return accumulateType;
	}

	public void setAccumulateType(String accumulateType) {
		this.accumulateType = accumulateType;
	}
}
