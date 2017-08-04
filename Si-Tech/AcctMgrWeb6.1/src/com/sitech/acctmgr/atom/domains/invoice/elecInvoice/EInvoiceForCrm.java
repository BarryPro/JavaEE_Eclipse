package com.sitech.acctmgr.atom.domains.invoice.elecInvoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class EInvoiceForCrm implements Serializable{
	
	// 单月账期
	@JSONField(name="PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "服务号码", memo = "略")
	protected String phoneNo;
	
	@JSONField(name="REQUEST_SN")
	@ParamDesc(path = "REQUEST_SN", cons = ConsType.QUES, type = "String", len = "30", desc = "发票打印唯一流水", memo = "略")
	protected String requestSn;
	
	@JSONField(name="ORDER_ID")
	@ParamDesc(path = "ORDER_ID", cons = ConsType.QUES, type = "String", len = "30", desc = "订单流水", memo = "略")
	protected String orderSn;
	
	@JSONField(name="CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "客户名称", memo = "略")
	protected String custName;
	
	@JSONField(name="BRAND_ID")
	@ParamDesc(path = "BRAND_ID", cons = ConsType.QUES, type = "String", len = "10", desc = "品牌标识", memo = "略")
	protected String brandId;
	
	@JSONField(name="INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "发票号码", memo = "略")
	protected String invNo;
	
	@JSONField(name="INV_CODE")
	@ParamDesc(path = "INV_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票代码", memo = "略")
	protected String invCode;
	
	@JSONField(name="R_INV_NO")
	@ParamDesc(path = "R_INV_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "原发票号", memo = "略")
	protected String rInvNo;
	
	@JSONField(name="R_INV_CODE")
	@ParamDesc(path = "R_INV_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "原发票代码", memo = "略")
	protected String rInvCode;
	
	@JSONField(name="INV_DATE")
	@ParamDesc(path = "INV_DATE", cons = ConsType.QUES, type = "String", len = "20", desc = "打印年月日", memo = "略")
	protected String invDate;
	
	@JSONField(name="INV_TYPE")
	@ParamDesc(path = "INV_TYPE", cons = ConsType.QUES, type = "String", len = "20", desc = "发票类型", memo = "略")
	protected String invType;
	
	@JSONField(name="INV_FEE")
	@ParamDesc(path = "INV_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "发票金额", memo = "略")
	protected long invFee;
	
	@JSONField(name="STATE")
	@ParamDesc(path = "STATE", cons = ConsType.QUES, type = "String", len = "2", desc = "发票状态", memo = "略")
	protected String state;
	
	@JSONField(name="ERR_MSG")
	@ParamDesc(path = "ERR_MSG", cons = ConsType.QUES, type = "String", len = "100", desc = "错误信息", memo = "略")
	protected String errMsg;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "操作时间", memo = "略")
	protected String opTime;
    //
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "账号", memo = "略")
	protected String contractNo;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path = "PAY_SN", cons = ConsType.QUES, type = "String", len = "20", desc = "缴费流水", memo = "略")
	protected String paySn;
	
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path = "LOGIN_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "工号", memo = "略")
	protected String loginNo;
	
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.QUES, type = "String", len = "20", desc = "账期月", memo = "略")
	protected String billCycle;
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
	 * @return the requestSn
	 */
	public String getRequestSn() {
		return requestSn;
	}

	/**
	 * @param requestSn the requestSn to set
	 */
	public void setRequestSn(String requestSn) {
		this.requestSn = requestSn;
	}

	/**
	 * @return the orderSn
	 */
	public String getOrderSn() {
		return orderSn;
	}

	/**
	 * @param orderSn the orderSn to set
	 */
	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}

	/**
	 * @return the brandId
	 */
	public String getBrandId() {
		return brandId;
	}

	/**
	 * @param brandId the brandId to set
	 */
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	/**
	 * @return the invNo
	 */
	public String getInvNo() {
		return invNo;
	}

	/**
	 * @param invNo the invNo to set
	 */
	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	/**
	 * @return the invCode
	 */
	public String getInvCode() {
		return invCode;
	}

	/**
	 * @param invCode the invCode to set
	 */
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	/**
	 * @return the rInvNo
	 */
	public String getrInvNo() {
		return rInvNo;
	}

	/**
	 * @param rInvNo the rInvNo to set
	 */
	public void setrInvNo(String rInvNo) {
		this.rInvNo = rInvNo;
	}

	/**
	 * @return the rInvCode
	 */
	public String getrInvCode() {
		return rInvCode;
	}

	/**
	 * @param rInvCode the rInvCode to set
	 */
	public void setrInvCode(String rInvCode) {
		this.rInvCode = rInvCode;
	}

	/**
	 * @return the invDate
	 */
	public String getInvDate() {
		return invDate;
	}

	/**
	 * @param invDate the invDate to set
	 */
	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}

	/**
	 * @return the invType
	 */
	public String getInvType() {
		return invType;
	}

	/**
	 * @param invType the invType to set
	 */
	public void setInvType(String invType) {
		this.invType = invType;
	}

	/**
	 * @return the invFee
	 */
	public long getInvFee() {
		return invFee;
	}

	/**
	 * @param invFee the invFee to set
	 */
	public void setInvFee(long invFee) {
		this.invFee = invFee;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the errMsg
	 */
	public String getErrMsg() {
		return errMsg;
	}

	/**
	 * @param errMsg the errMsg to set
	 */
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getPaySn() {
		return paySn;
	}

	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(String billCycle) {
		this.billCycle = billCycle;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "EInvoiceForCrm [phoneNo=" + phoneNo + ", requestSn="
				+ requestSn + ", orderSn=" + orderSn + ", custName=" + custName
				+ ", brandId=" + brandId + ", invNo=" + invNo + ", invCode="
				+ invCode + ", rInvNo=" + rInvNo + ", rInvCode=" + rInvCode
				+ ", invDate=" + invDate + ", invType=" + invType + ", invFee="
				+ invFee + ", state=" + state + ", errMsg=" + errMsg
				+ ", opTime=" + opTime + ", contractNo=" + contractNo +", paySn=" + paySn +", loginNo=" + loginNo +", billCycle=" + billCycle +"]";
	}
	
	
	
}
