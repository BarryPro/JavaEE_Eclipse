package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PosPayEntity implements Serializable{

	private static final long serialVersionUID = 2496887267416022095L;

	@JSONField(name="MERCHANT_NAME")
	@ParamDesc(path="MERCHANT_NAME",cons=ConsType.CT001,type="String",len="40",desc="商户名称",memo="略")
	private String merchantName;
	
	@JSONField(name="TERMINAL_NUM")
	@ParamDesc(path="TERMINAL_NUM",cons=ConsType.CT001,type="String",len="8",desc="终端编号",memo="略")
	private String terminalNum;
	
	@JSONField(name="CARD_ID")
	@ParamDesc(path="CARD_ID",cons=ConsType.CT001,type="long",len="20",desc="交易卡号",memo="略")
	private String cardId;
	
	@JSONField(name="MERCHANT_ID")
	@ParamDesc(path="MERCHANT_ID",cons=ConsType.CT001,type="string",len="19",desc="商户编码",memo="略")
	private String merchantId;
	
	@JSONField(name="BANK_NAME")
	@ParamDesc(path="BANK_NAME",cons=ConsType.CT001,type="string",len="20",desc="发卡机构名称",memo="略")
	private String bankName;
	
	@JSONField(name="VOUCHER_ID")
	@ParamDesc(path="VOUCHER_ID",cons=ConsType.CT001,type="string",len="18",desc="交易凭证号",memo="略")
	private String voucherId;
	
	@JSONField(name="BATCH_NO")
	@ParamDesc(path="BATCH_NO",cons=ConsType.CT001,type="string",len="10",desc="交易批次号",memo="略")
	private String batchNo;
	
	@JSONField(name="BUSI_TYPE")
	@ParamDesc(path="BUSI_TYPE",cons=ConsType.CT001,type="string",len="10",desc="交易类型",memo="略")
	private String busiType;
	
	@JSONField(name="INSTAL_NUM")
	@ParamDesc(path="INSTAL_NUM",cons=ConsType.CT001,type="string",len="10",desc="分期付款期数",memo="略")
	private long instalNum;
	
	@JSONField(name="BUDGET_START_PAY")
	@ParamDesc(path="BUDGET_START_PAY",cons=ConsType.CT001,type="string",len="14",desc="分期付款首期金额",memo="略")
	private long budgetStartPay;
	
	@JSONField(name="REFERENCE_NO")
	@ParamDesc(path="REFERENCE_NO",cons=ConsType.CT001,type="string",len="20",desc="系统参考号",memo="略")
	private String referenceNo;
	
	@JSONField(name="OPER_ID")
	@ParamDesc(path="OPER_ID",cons=ConsType.CT001,type="string",len="2",desc="操作员编号",memo="略")
	private String operId;
	
	@JSONField(name="CARD_TYPE")
	@ParamDesc(path="CARD_TYPE",cons=ConsType.CT001,type="string",len="3",desc="卡类型",memo="国际卡组织如CUP,VIS等")
	private String cardType;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="string",len="8",desc="交易日期",memo="略")
	private String totalDate;
	
	@JSONField(name="TRANS_TIME")
	@ParamDesc(path="TRANS_TIME",cons=ConsType.CT001,type="string",len="14",desc="交易时间",memo="略")
	private String transTime;

	@JSONField(name="AUTH_NO")
	private String  authNo;		//授权号
	
	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PosPayEntity [merchantName=" + merchantName + ", terminalNum="
				+ terminalNum + ", cardId=" + cardId + ", merchantId="
				+ merchantId + ", bankName=" + bankName + ", voucherId="
				+ voucherId + ", batchNo=" + batchNo + ", busiType=" + busiType
				+ ", instalNum=" + instalNum + ", budgetStartPay="
				+ budgetStartPay + ", referenceNo=" + referenceNo + ", operId="
				+ operId + ", cardType=" + cardType + ", totalDate="
				+ totalDate + ", transTime=" + transTime + ", authNo=" + authNo
				+ "]";
	}
	

	/**
	 * @return the authNo
	 */
	public String getAuthNo() {
		return authNo;
	}

	/**
	 * @param authNo the authNo to set
	 */
	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}

	/**
	 * @return the referenceNo
	 */
	public String getReferenceNo() {
		return referenceNo;
	}

	/**
	 * @param referenceNo the referenceNo to set
	 */
	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
	}

	/**
	 * @return the merchantName
	 */
	public String getMerchantName() {
		return merchantName;
	}

	/**
	 * @param merchantName the merchantName to set
	 */
	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	/**
	 * @return the terminalNum
	 */
	public String getTerminalNum() {
		return terminalNum;
	}

	/**
	 * @param terminalNum the terminalNum to set
	 */
	public void setTerminalNum(String terminalNum) {
		this.terminalNum = terminalNum;
	}

	/**
	 * @return the cardId
	 */
	public String getCardId() {
		return cardId;
	}

	/**
	 * @param cardId the cardId to set
	 */
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

	/**
	 * @return the merchantId
	 */
	public String getMerchantId() {
		return merchantId;
	}

	/**
	 * @param merchantId the merchantId to set
	 */
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}

	/**
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**
	 * @return the voucherId
	 */
	public String getVoucherId() {
		return voucherId;
	}

	/**
	 * @param voucherId the voucherId to set
	 */
	public void setVoucherId(String voucherId) {
		this.voucherId = voucherId;
	}

	/**
	 * @return the batchNo
	 */
	public String getBatchNo() {
		return batchNo;
	}

	/**
	 * @param batchNo the batchNo to set
	 */
	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	/**
	 * @return the busiType
	 */
	public String getBusiType() {
		return busiType;
	}

	/**
	 * @param busiType the busiType to set
	 */
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	/**
	 * @return the instalNum
	 */
	public long getInstalNum() {
		return instalNum;
	}

	/**
	 * @param instalNum the instalNum to set
	 */
	public void setInstalNum(long instalNum) {
		this.instalNum = instalNum;
	}

	/**
	 * @return the budgetStartPay
	 */
	public long getBudgetStartPay() {
		return budgetStartPay;
	}

	/**
	 * @param budgetStartPay the budgetStartPay to set
	 */
	public void setBudgetStartPay(long budgetStartPay) {
		this.budgetStartPay = budgetStartPay;
	}

	/**
	 * @return the operId
	 */
	public String getOperId() {
		return operId;
	}

	/**
	 * @param operId the operId to set
	 */
	public void setOperId(String operId) {
		this.operId = operId;
	}

	/**
	 * @return the cardType
	 */
	public String getCardType() {
		return cardType;
	}

	/**
	 * @param cardType the cardType to set
	 */
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	/**
	 * @return the totalDate
	 */
	public String getTotalDate() {
		return totalDate;
	}

	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	/**
	 * @return the transTime
	 */
	public String getTransTime() {
		return transTime;
	}

	/**
	 * @param transTime the transTime to set
	 */
	public void setTransTime(String transTime) {
		this.transTime = transTime;
	}
	
	
}
