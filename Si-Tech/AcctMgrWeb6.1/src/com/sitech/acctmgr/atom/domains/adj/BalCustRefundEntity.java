package com.sitech.acctmgr.atom.domains.adj;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class BalCustRefundEntity {

	@JSONField(name="INDEX_NO")
	@ParamDesc(path="INDEX_NO",cons=ConsType.QUES,type="long",len="10",desc="序号",memo="略")
	protected long indexNo;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="15",desc="服务号码",memo="略")
	protected String phoneNo;
	@JSONField(name="QUERY_TYPE")
	@ParamDesc(path="QUERY_TYPE",cons=ConsType.CT001,type="String",len="20",desc="查询类型",memo="略")
	protected String queryType;
	@JSONField(name="USE_TIME")
	@ParamDesc(path="USE_TIME",cons=ConsType.CT001,type="String",len="20",desc="使用时间",memo="略")
	protected String userTime;
	@JSONField(name="USE_TYPE")
	@ParamDesc(path="USE_TYPE",cons=ConsType.CT001,type="String",len="20",desc="使用类型",memo="略")
	protected String useType;
	@JSONField(name="OPER_NAME")
	@ParamDesc(path="OPER_NAME",cons=ConsType.QUES,type="String",len="14",desc="业务名称",memo="略")
	protected String operName;
	@JSONField(name="OPER_CODE")
	@ParamDesc(path="OPER_CODE",cons=ConsType.QUES,type="String",len="14",desc="业务代码",memo="略")
	protected String operCode;
	@JSONField(name="SP_NAME")
	@ParamDesc(path="SP_NAME",cons=ConsType.QUES,type="String",len="10",desc="SP企业名字",memo="略")
	protected String spName;
	@JSONField(name="SP_CODE")
	@ParamDesc(path="SP_CODE",cons=ConsType.QUES,type="String",len="14",desc="SP企业代码",memo="略")
	protected String spCode;
	@JSONField(name="FEE_TYPE")
	@ParamDesc(path="FEE_TYPE",cons=ConsType.QUES,type="String",len="10",desc="费用类型",memo="略")
	protected String feeType;
	@JSONField(name="FEE_VALUE")
	@ParamDesc(path="FEE_VALUE",cons=ConsType.QUES,type="String",len="10",desc="费用金额",memo="略")
	protected String feeValue;
	@JSONField(name="BACK_FLAG")
	@ParamDesc(path="BACK_FLAG",cons=ConsType.QUES,type="String",len="10",desc="返回类型",memo="略")
	protected String backFlag;
	@JSONField(name="YEAR_MONTH")
	@ParamDesc(path="YEAR_MONTH",cons=ConsType.QUES,type="String",len="10",desc="年月",memo="略")
	protected String yearMonth;
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> toMap(){
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}


	public long getIndexNo() {
		return indexNo;
	}


	public void setIndexNo(long indexNo) {
		this.indexNo = indexNo;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getQueryType() {
		return queryType;
	}


	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}


	public String getUserTime() {
		return userTime;
	}


	public void setUserTime(String userTime) {
		this.userTime = userTime;
	}


	public String getUseType() {
		return useType;
	}


	public void setUseType(String useType) {
		this.useType = useType;
	}


	public String getOperName() {
		return operName;
	}


	public void setOperName(String operName) {
		this.operName = operName;
	}


	public String getSpName() {
		return spName;
	}


	public void setSpName(String spName) {
		this.spName = spName;
	}


	public String getSpCode() {
		return spCode;
	}


	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}


	public String getFeeType() {
		return feeType;
	}


	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}


	public String getFeeValue() {
		return feeValue;
	}


	public void setFeeValue(String feeValue) {
		this.feeValue = feeValue;
	}


	public String getBackFlag() {
		return backFlag;
	}


	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}


	public String getYearMonth() {
		return yearMonth;
	}


	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}


	public String getOperCode() {
		return operCode;
	}


	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}
	
	
}
