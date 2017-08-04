package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

/**
 * 
* @Title:   []
* @Description: 缴费记录常用出参
* @Date : 2015年3月12日下午6:02:12
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class PaysnBaseEntity implements Serializable { 

	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="缴费金额",memo="略")
	protected long payFee;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="18",desc="缴费流水",memo="略")
	protected long paySn;
	
	@JSONField(name="PHONE")
	@ParamDesc(path="PHONE",cons=ConsType.CT001,type="String",len="40",desc="缴费号码",memo="略")
	protected String phone;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="int",len="8",desc="缴费日期",memo="略")
	protected int totalDate;
	@JSONField(name="PAY_TIME")
	@ParamDesc(path="PAY_TIME",cons=ConsType.CT001,type="string",len="20",desc="缴费时间",memo="略")
	protected String payTime;
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="string",len="20",desc="缴费工号",memo="略")
	protected String loginNo;
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="string",len="1024",desc="缴费备注",memo="略")
	private String remark;
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="string",len="4",desc="操作代码",memo="略")
	private String opCode;
	@JSONField(name="FUNCTION_NAME")
	@ParamDesc(path="FUNCTION_NAME",cons=ConsType.CT001,type="string",len="4",desc="操作代码",memo="略")
	private String functionName;
	
	@JSONField(name="AGENT_PHONE")
	@ParamDesc(path="AGENT_PHONE",cons=ConsType.QUES,type="String",len="40",desc="代理商服务号码",memo="略")
	protected String agentPhone;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="缴费号码",memo="略")
	protected String phoneNo;

	
	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the agentPhone
	 */
	public String getAgentPhone() {
		return agentPhone;
	}

	/**
	 * @param agentPhone the agentPhone to set
	 */
	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}
	
	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}
	
	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}
	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}
	/**
	 * @return the totalDate
	 */
	public int getTotalDate() {
		return totalDate;
	}
	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}
	/**
	 * @return the payTime
	 */
	public String getPayTime() {
		return payTime;
	}
	/**
	 * @param payTime the payTime to set
	 */
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}
	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}
	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}
	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}
	/**
	 * @return the functionName
	 */
	public String getFunctionName() {
		return functionName;
	}
	/**
	 * @param functionName the functionName to set
	 */
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PaysnBaseEntity [paySn=" + paySn + ", totalDate=" + totalDate
				+ ", payTime=" + payTime + ", loginNo=" + loginNo + ", remark="
				+ remark + ", opCode=" + opCode + ", functionName="
				+ functionName + "]";
	}
	 
	
}
