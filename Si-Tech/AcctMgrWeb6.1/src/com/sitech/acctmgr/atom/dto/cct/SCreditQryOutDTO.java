package com.sitech.acctmgr.atom.dto.cct;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCreditQryOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "服务号码", memo = "略")
	protected String phoneNo;
	
	@JSONField(name="CREDIT_GRADE")
	@ParamDesc(path = "CREDIT_GRADE", cons = ConsType.QUES, type = "String", len = "40", desc = "信用等级名称", memo = "略")
	protected String creditGrade;
	
	@JSONField(name="CREDIT_CODE")
	@ParamDesc(path = "CREDIT_CODE", cons = ConsType.QUES, type = "String", len = "10", desc = "信用度等级", memo = "略")
	protected String creditCode;
	
	@JSONField(name="CREDIT_CODE2")
	@ParamDesc(path = "CREDIT_CODE2", cons = ConsType.QUES, type = "String", len = "10", desc = "信用度等级", memo = "略")
	protected String creditCode2;
	
	@JSONField(name="OVER_FEE")
	@ParamDesc(path = "OVER_FEE", cons = ConsType.QUES, type = "long", len = "10", desc = "信用度透支额度", memo = "单位:分")
	protected long overFee;
	
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, type = "int", len = "10", desc = "生效日期", memo = "格式：yyyymmddhhmiss")
	protected String beginTime;
	
	@JSONField(name="END_TIME")
	@ParamDesc(path = "END_TIME", cons = ConsType.CT001, type = "int", len = "10", desc = "失效日期", memo = "格式：yyyymmddhhmiss")
	protected String endTime;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("creditGrade"), creditGrade);
		result.setRoot(getPathByProperName("creditCode"), creditCode);
		result.setRoot(getPathByProperName("creditCode2"), creditCode2);
		result.setRoot(getPathByProperName("overFee"), overFee);
		result.setRoot(getPathByProperName("beginTime"), beginTime);
		result.setRoot(getPathByProperName("endTime"), endTime);
		log.info(result.toString());
		return result;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getCreditGrade() {
		return creditGrade;
	}

	public void setCreditGrade(String creditGrade) {
		this.creditGrade = creditGrade;
	}
	

	public long getOverFee() {
		return overFee;
	}

	public void setOverFee(long overFee) {
		this.overFee = overFee;
	}

	public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}


	public void setOverFee(int overFee) {
		this.overFee = overFee;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the creditCode2
	 */
	public String getCreditCode2() {
		return creditCode2;
	}

	/**
	 * @param creditCode2 the creditCode2 to set
	 */
	public void setCreditCode2(String creditCode2) {
		this.creditCode2 = creditCode2;
	}


}
