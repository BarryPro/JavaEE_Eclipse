package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 托收电子回执单头汇总信息实体
 */
public class CollHeaderConEntity {
    @JSONField(name = "OPER_TYPE")
    @ParamDesc(path = "OPER_TYPE", cons = ConsType.CT001, len = "5", desc = "操作类型", type = "String", memo = "略")
    private String operType;

    @JSONField(name = "ENTER_CODE")
    @ParamDesc(path = "ENTER_CODE", cons = ConsType.CT001, len = "12", desc = "企业代码", type = "String", memo = "略")
    private String enterCode;

    @JSONField(name = "OP_DATE")
    @ParamDesc(path = "OP_DATE", cons = ConsType.CT001, len = "8", desc = "操作日期", type = "String", memo = "略")
    private String opDate;

    @JSONField(name = "DATA_FILE_NAME")
    @ParamDesc(path = "DATA_FILE_NAME", cons = ConsType.CT001, len = "22", desc = "数据文件名称", type = "String", memo = "略")
    private String dataFileName;

    @JSONField(name = "MOBILE_BANK_CODE")
    @ParamDesc(path = "MOBILE_BANK_CODE", cons = ConsType.CT001, len = "12", desc = "移动银行代码", type = "String", memo = "略")
    private String mobileBankCode;
    
    @JSONField(name = "MOBILE_ACCOUNT_NO")
    @ParamDesc(path = "MOBILE_ACCOUNT_NO", cons = ConsType.CT001, len = "32", desc = "移动银行帐号", type = "String", memo = "略")
    private String mobileAccountNo;
    
    @JSONField(name = "SHOULD_PAY")
    @ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, len = "15", desc = "应收金额", type = "String", memo = "略")
    private String shouldPay;
    
    @JSONField(name = "REAL_PAY")
    @ParamDesc(path = "REAL_PAY", cons = ConsType.CT001, len = "15", desc = "实收金额", type = "String", memo = "略")
    private String realPay;
    
    @JSONField(name = "SHOULD_SUM")
    @ParamDesc(path = "SHOULD_SUM", cons = ConsType.CT001, len = "8", desc = "应收帐户数目", type = "String", memo = "略")
    private String shouldSum;
    
    @JSONField(name = "DEAL_SUM")
    @ParamDesc(path = "DEAL_SUM", cons = ConsType.CT001, len = "8", desc = "结算中心处理数目", type = "String", memo = "略")
    private String dealSum;
    
    @JSONField(name = "REAL_SUM")
    @ParamDesc(path = "REAL_SUM", cons = ConsType.CT001, len = "8", desc = "结算中心处理成功数目", type = "String", memo = "略")
    private String realSum;

	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	public String getEnterCode() {
		return enterCode;
	}

	public void setEnterCode(String enterCode) {
		this.enterCode = enterCode;
	}

	public String getOpDate() {
		return opDate;
	}

	public void setOpDate(String opDate) {
		this.opDate = opDate;
	}

	public String getDataFileName() {
		return dataFileName;
	}

	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
	}

	public String getMobileBankCode() {
		return mobileBankCode;
	}

	public void setMobileBankCode(String mobileBankCode) {
		this.mobileBankCode = mobileBankCode;
	}

	public String getMobileAccountNo() {
		return mobileAccountNo;
	}

	public void setMobileAccountNo(String mobileAccountNo) {
		this.mobileAccountNo = mobileAccountNo;
	}

	public String getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(String shouldPay) {
		this.shouldPay = shouldPay;
	}

	public String getRealPay() {
		return realPay;
	}

	public void setRealPay(String realPay) {
		this.realPay = realPay;
	}

	public String getShouldSum() {
		return shouldSum;
	}

	public void setShouldSum(String shouldSum) {
		this.shouldSum = shouldSum;
	}

	public String getDealSum() {
		return dealSum;
	}

	public void setDealSum(String dealSum) {
		this.dealSum = dealSum;
	}

	public String getRealSum() {
		return realSum;
	}

	public void setRealSum(String realSum) {
		this.realSum = realSum;
	}
    
}
