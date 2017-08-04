package com.sitech.acctmgr.atom.domains.pay;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.constant.PayBusiConst;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 核心预存款对象
 * @version 1.0
 */
public class PayBookEntity implements Serializable{

	@JSONField(name="TOTAL_DATE")
	private int 	totalDate;
	
	@JSONField(name="PAY_SN")
	private long 	paySn;
	
	@JSONField(name="PAY_PATH")
	private String 	payPath;
	
	@JSONField(name="PAY_METHOD")
	private String	payMethod;
	
	@JSONField(name="PAY_TYPE")
	private String	payType;
	
	@JSONField(name="PAY_FEE")
	private long	payFee;
	
	@JSONField(name="STATUS")
	private String	status;			//标识， 0：正常 1：冲正 2：分月划拨 3：分月划拨冲正
	
	@JSONField(name="BANK_CODE")
	private String	bankCode;		//银行代码[对支票交费]，可空
	
	@JSONField(name="BEGIN_TIME")
	private String	beginTime;
	
	@JSONField(name="END_TIME")
	private String	endTime	= PayBusiConst.END_TIME2;
	
	//是否打印发票标识，默认为0 (0：未打印；1：月结已打印；2：预存已打印)
	@JSONField(name="PRINT_FLAG")
	private String	printFlag;
	
	@JSONField(name="FOREIGN_SN")
	private String	foreignSn;
	
	@JSONField(name="FOREIGN_TIME")
	private String	foreignTime;
	
	@JSONField(name="YEAR_MONTH")
	private long 	yearMonth;
	
	@JSONField(name="BALANCE_ID")
	private long 	balanceId;
	
	@JSONField(name="BALANCE_TYPE")
	private String	balanceType;   //0 正常缴费  1 月末出账期间缴费  2 分月即时返回费用  3 分月条件返回费用
	
	@JSONField(name="ORIGINAL_SN")
	private long	originalSn;

	@JSONField(name="LOGIN_NO")
	private String loginNo;
	
	@JSONField(name="GROUP_ID")
	private String groupId;
	
	@JSONField(name="OP_CODE")
	private String opCode;
	
	@JSONField(name="OP_NOTE")
	private String opNote;

	@JSONField(name="OP_TIME")
	private String opTime;
	
	@JSONField(name="FACTOR_ONE")
	private String factorOne;
	
	@JSONField(name="FACTOR_TWO")
	private String factorTwo;
	
	@JSONField(name="FACTOR_THREE")
	private String factorThree;
	
	@JSONField(name="FACTOR_FOUR")
	private String factorFour;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "payBookEntity [totalDate=" + totalDate + ", paySn=" + paySn
				+ ", payPath=" + payPath + ", payMethod=" + payMethod
				+ ", payType=" + payType + ", payFee=" + payFee + ", status="
				+ status + ", bankCode=" + bankCode + ", beginTime="
				+ beginTime + ", endTime=" + endTime + ", printFlag="
				+ printFlag + ", foreignSn=" + foreignSn + ", foreignTime="
				+ foreignTime + ", yearMonth=" + yearMonth + ", balanceId="
				+ balanceId + ", balanceType=" + balanceType + ", originalSn="
				+ originalSn + ", loginNo=" + loginNo + ", groupId=" + groupId
				+ ", opCode=" + opCode + ", opNote=" + opNote + ",opTime="+opTime+ "]";
	}

	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	/**
	 * @return the originalSn
	 */
	public long getOriginalSn() {
		return originalSn;
	}

	/**
	 * @param originalSn the originalSn to set
	 */
	public void setOriginalSn(long originalSn) {
		this.originalSn = originalSn;
	}

	/**
	 * @return the balanceType
	 */
	public String getBalanceType() {
		return balanceType;
	}

	/**
	 * @param balanceType the balanceType to set
	 */
	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}

	/**
	 * @return the yearMonth
	 */
	public long getYearMonth() {
		return yearMonth;
	}

	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(long yearMonth) {
		this.yearMonth = yearMonth;
	}

	/**
	 * @return the balanceId
	 */
	public long getBalanceId() {
		return balanceId;
	}

	/**
	 * @param balanceId the balanceId to set
	 */
	public void setBalanceId(long balanceId) {
		this.balanceId = balanceId;
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
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}


	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}


	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}


	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}


	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}


	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}


	/**
	 * @return the bankCode
	 */
	public String getBankCode() {
		return bankCode;
	}


	/**
	 * @param bankCode the bankCode to set
	 */
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}


	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}


	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}


	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}


	/**
	 * @return the printFlag
	 */
	public String getPrintFlag() {
		return printFlag;
	}


	/**
	 * @param printFlag the printFlag to set
	 */
	public void setPrintFlag(String printFlag) {
		this.printFlag = printFlag;
	}


	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}


	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	/**
	 * @return the foreignTime
	 */
	public String getForeignTime() {
		return foreignTime;
	}


	/**
	 * @param foreignTime the foreignTime to set
	 */
	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
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
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
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
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @return the factorOne
	 */
	public String getFactorOne() {
		return factorOne;
	}

	/**
	 * @param factorOne the factorOne to set
	 */
	public void setFactorOne(String factorOne) {
		this.factorOne = factorOne;
	}

	/**
	 * @return the factorTwo
	 */
	public String getFactorTwo() {
		return factorTwo;
	}

	/**
	 * @param factorTwo the factorTwo to set
	 */
	public void setFactorTwo(String factorTwo) {
		this.factorTwo = factorTwo;
	}

	/**
	 * @return the factorThree
	 */
	public String getFactorThree() {
		return factorThree;
	}

	/**
	 * @param factorThree the factorThree to set
	 */
	public void setFactorThree(String factorThree) {
		this.factorThree = factorThree;
	}

	/**
	 * @return the factorFour
	 */
	public String getFactorFour() {
		return factorFour;
	}

	/**
	 * @param factorFour the factorFour to set
	 */
	public void setFactorFour(String factorFour) {
		this.factorFour = factorFour;
	}
	
	
}
