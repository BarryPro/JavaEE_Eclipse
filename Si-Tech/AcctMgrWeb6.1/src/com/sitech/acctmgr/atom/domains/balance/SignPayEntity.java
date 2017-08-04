package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;

public class SignPayEntity {

	/**
	*/
	@JSONField(name = "PHONE_NO_SIGN")
	private String phoneNoSign;

	/**
	*/
	@JSONField(name = "ID_NO_SIGN")
	private long idNoSign;

	/**
	 */
	@JSONField(name = "PHONE_NO_PAY")
	private String phoneNoPay;

	/**
	*/
	@JSONField(name = "ID_NO_PAY")
	private long idNoPay;

	/**
	*/
	@JSONField(name = "PAY_MONEY")
	private long payMoney;

	/**
	*/
	@JSONField(name = "BUSI_TYPE")
	private String busiType;

	/**
	*/
	@JSONField(name = "LOGIN_NO")
	private String loginNo;

	/**
	*/
	@JSONField(name = "OP_TIME")
	private String opTime;

	/**
	 */
	@JSONField(name = "YEAR_MONTH")
	private long yearMonth;

	/**
	 */
	@JSONField(name = "LOGIN_ACCEPT")
	private long loginAccept;

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
	 * @return the phoneNoSign
	 */
	public String getPhoneNoSign() {
		return phoneNoSign;
	}

	/**
	 * @return the idNoSign
	 */
	public long getIdNoSign() {
		return idNoSign;
	}

	/**
	 * @return the phoneNoPay
	 */
	public String getPhoneNoPay() {
		return phoneNoPay;
	}

	/**
	 * @return the idNoPay
	 */
	public long getIdNoPay() {
		return idNoPay;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @return the busiType
	 */
	public String getBusiType() {
		return busiType;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @return the yearMonth
	 */
	public long getYearMonth() {
		return yearMonth;
	}

	/**
	 * @return the loginAccept
	 */
	public long getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param phoneNoSign the phoneNoSign to set
	 */
	public void setPhoneNoSign(String phoneNoSign) {
		this.phoneNoSign = phoneNoSign;
	}

	/**
	 * @param idNoSign the idNoSign to set
	 */
	public void setIdNoSign(long idNoSign) {
		this.idNoSign = idNoSign;
	}

	/**
	 * @param phoneNoPay the phoneNoPay to set
	 */
	public void setPhoneNoPay(String phoneNoPay) {
		this.phoneNoPay = phoneNoPay;
	}

	/**
	 * @param idNoPay the idNoPay to set
	 */
	public void setIdNoPay(long idNoPay) {
		this.idNoPay = idNoPay;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @param busiType the busiType to set
	 */
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(long yearMonth) {
		this.yearMonth = yearMonth;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

}
