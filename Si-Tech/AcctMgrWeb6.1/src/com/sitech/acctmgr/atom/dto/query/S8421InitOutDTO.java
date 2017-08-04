package com.sitech.acctmgr.atom.dto.query;


import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8421InitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	@ParamDesc(path="AGREEMENT_FLAG",cons=ConsType.CT001,type="String",len="1",desc="签约标志",memo="略")
	private String agreementFlag;
	@ParamDesc(path="AGREEMENT_TIME",cons=ConsType.CT001,type="String",len="8",desc="签约时间",memo="略")
	private String agreementTime;
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="18",desc="扣费金额",memo="略")
	private long payMoney;
	@ParamDesc(path="BALANCE",cons=ConsType.CT001,type="long",len="18",desc="阀值",memo="略")
	private long balance;
	@ParamDesc(path="AUTO_FLAG",cons=ConsType.CT001,type="String",len="10",desc="自动交费标识",memo="")
	private String autoFlag;
	@ParamDesc(path="BANK_TYPE",cons=ConsType.CT001,type="String",len="6",desc="支付商编号",memo="略")
	private String bankType;
	@ParamDesc(path="SIGN_ID",cons=ConsType.CT001,type="String",len="32",desc="签约协议号",memo="略")
	private String signId;
	
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("agreementFlag"), agreementFlag);
		result.setRoot(getPathByProperName("agreementTime"), agreementTime);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("balance"), balance);
		result.setRoot(getPathByProperName("bankType"), bankType);
		result.setRoot(getPathByProperName("signId"), signId);
		result.setRoot(getPathByProperName("autoFlag"), autoFlag);
		
		log.info(result.toString());
		return result;
	}


	/**
	 * @return the agreementFlag
	 */
	public String getAgreementFlag() {
		return agreementFlag;
	}


	/**
	 * @param agreementFlag the agreementFlag to set
	 */
	public void setAgreementFlag(String agreementFlag) {
		this.agreementFlag = agreementFlag;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}


	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}


	/**
	 * @return the balance
	 */
	public long getBalance() {
		return balance;
	}


	/**
	 * @param balance the balance to set
	 */
	public void setBalance(long balance) {
		this.balance = balance;
	}


	/**
	 * @return the agreementTime
	 */
	public String getAgreementTime() {
		return agreementTime;
	}


	/**
	 * @param agreementTime the agreementTime to set
	 */
	public void setAgreementTime(String agreementTime) {
		this.agreementTime = agreementTime;
	}


	/**
	 * @return the bankType
	 */
	public String getBankType() {
		return bankType;
	}


	/**
	 * @param bankType the bankType to set
	 */
	public void setBankType(String bankType) {
		this.bankType = bankType;
	}


	/**
	 * @return the signId
	 */
	public String getSignId() {
		return signId;
	}


	/**
	 * @param signId the signId to set
	 */
	public void setSignId(String signId) {
		this.signId = signId;
	}


	/**
	 * @return the autoFlag
	 */
	public String getAutoFlag() {
		return autoFlag;
	}


	/**
	 * @param autoFlag the autoFlag to set
	 */
	public void setAutoFlag(String autoFlag) {
		this.autoFlag = autoFlag;
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

}
