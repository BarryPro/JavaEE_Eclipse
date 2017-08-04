package com.sitech.acctmgr.atom.domains.account;

import com.alibaba.fastjson.annotation.JSONField;

public class ConUserRelEntity {

	 /**
     */
	@JSONField(name = "SERV_ACCT_ID")
    private Long servAcctId;

    /**
     */
	@JSONField(name = "CONTRACT_NO")
    private Long contractNo;

    /**
     */
	@JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
	@JSONField(name = "PAY_TYPE")
    private String payType;

    /**
     */
	@JSONField(name = "PAY_VALUE")
    private Double payValue;

    /**
     */
	@JSONField(name = "CHKOUT_PRI")
    private Integer chkoutPri;

    /**
     */
	@JSONField(name = "BILL_ORDER")
    private Integer billOrder;

    /**
     */
	@JSONField(name = "EFF_DATE")
    private String effDate;

    /**
     */
	@JSONField(name = "EXP_DATE")
    private String expDate;
	
    /**
     */
	@JSONField(name = "EFF_YMDHMS")
    private String effYmdhms;
	
    /**
     */
	@JSONField(name = "EXP_YMDHMS")
    private String expYmdhms;

    /**
     */
	@JSONField(name = "DATE_CYCLE")
    private Integer dateCycle;

    /**
     */
	@JSONField(name = "RATE_FLAG")
    private String rateFlag;

    /**
     */
	@JSONField(name = "CYCLE_TYPE")
    private String cycleType;

    /**
     */
	@JSONField(name = "FINISH_FLAG")
    private String finishFlag;

    public Long getServAcctId(){
    	return this.servAcctId;
    }
 
    public void setServAcctId(Long servAcctId){
      this.servAcctId=servAcctId;
    }
 
    public Long getContractNo(){
    	return this.contractNo;
    }
 
    public void setContractNo(Long contractNo){
      this.contractNo=contractNo;
    }
 
    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getPayType(){
    	return this.payType;
    }
 
    public void setPayType(String payType){
      this.payType=payType;
    }
 
    public Double getPayValue(){
    	return this.payValue;
    }
 
    public void setPayValue(Double payValue){
      this.payValue=payValue;
    }
 
    public Integer getChkoutPri(){
    	return this.chkoutPri;
    }
 
    public void setChkoutPri(Integer chkoutPri){
      this.chkoutPri=chkoutPri;
    }
 
    public Integer getBillOrder(){
    	return this.billOrder;
    }
 
    public void setBillOrder(Integer billOrder){
      this.billOrder=billOrder;
    }
 

 
    public Integer getDateCycle(){
    	return this.dateCycle;
    }
 
    public void setDateCycle(Integer dateCycle){
      this.dateCycle=dateCycle;
    }
 
    public String getRateFlag(){
    	return this.rateFlag;
    }
 
    public void setRateFlag(String rateFlag){
      this.rateFlag=rateFlag;
    }
 
    public String getCycleType(){
    	return this.cycleType;
    }
 
    public void setCycleType(String cycleType){
      this.cycleType=cycleType;
    }
 
    public String getFinishFlag(){
    	return this.finishFlag;
    }
 
    public void setFinishFlag(String finishFlag){
      this.finishFlag=finishFlag;
    }

	/**
	 * @return the effDate
	 */
	public String getEffDate() {
		return effDate;
	}

	/**
	 * @param effDate the effDate to set
	 */
	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	/**
	 * @return the expDate
	 */
	public String getExpDate() {
		return expDate;
	}

	/**
	 * @param expDate the expDate to set
	 */
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	/**
	 * @return the effYmdhms
	 */
	public String getEffYmdhms() {
		return effYmdhms;
	}

	/**
	 * @param effYmdhms the effYmdhms to set
	 */
	public void setEffYmdhms(String effYmdhms) {
		this.effYmdhms = effYmdhms;
	}

	/**
	 * @return the expYmdhms
	 */
	public String getExpYmdhms() {
		return expYmdhms;
	}

	/**
	 * @param expYmdhms the expYmdhms to set
	 */
	public void setExpYmdhms(String expYmdhms) {
		this.expYmdhms = expYmdhms;
	}

    @Override
    public String toString() {
        return "ConUserRelEntity{" +
                "servAcctId=" + servAcctId +
                ", contractNo=" + contractNo +
                ", idNo=" + idNo +
                ", payType='" + payType + '\'' +
                ", payValue=" + payValue +
                ", chkoutPri=" + chkoutPri +
                ", billOrder=" + billOrder +
                ", effDate='" + effDate + '\'' +
                ", expDate='" + expDate + '\'' +
                ", effYmdhms='" + effYmdhms + '\'' +
                ", expYmdhms='" + expYmdhms + '\'' +
                ", dateCycle=" + dateCycle +
                ", rateFlag='" + rateFlag + '\'' +
                ", cycleType='" + cycleType + '\'' +
                ", finishFlag='" + finishFlag + '\'' +
                '}';
    }
}
