package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;

public class TransFeeEntity {

	 /**
     */
	@JSONField(name="TRANS_SN")
    private Long transSn;

    /**
     */
	@JSONField(name="PHONENO_OUT")
    private String phonenoOut;

    /**
     */
	@JSONField(name="CONTRACTNO_OUT")
    private Long contractnoOut;

    /**
     */
	@JSONField(name="IDNO_OUT")
    private Long idnoOut;

    /**
     */
	@JSONField(name="PHONENO_IN")
    private String phonenoIn;

    /**
     */
	@JSONField(name="CONTRACTNO_IN")
    private Long contractnoIn;

    /**
     */
	@JSONField(name="IDNO_IN")
    private Long idnoIn;

    /**
     */
	@JSONField(name="PAY_TYPE")
    private String payType;

    /**
     */
	@JSONField(name="TRANS_FEE")
    private Long transFee;

    /**
     */
	@JSONField(name="LOGIN_NO")
    private String loginNo;

    /**
     */
	@JSONField(name="TOTAL_DATE")
    private Integer totalDate;

    /**
     */
	@JSONField(name="OP_CODE")
    private String opCode;

    /**
     */
	@JSONField(name="OP_TYPE")
    private String opType;

    /**
     */
	@JSONField(name="FOREIGN_SN")
    private String foreignSn;

    /**
     */
	@JSONField(name="FOREIGN_DATE")
    private String foreignDate;

    /**
     */
	@JSONField(name="OP_TIME")
    private String opTime;
	
    /**
     */
	@JSONField(name="OP_TIME1")
    private String opTime1;

    /**
     */
	@JSONField(name="STATUS")
    private String status;

    /**
     */
	@JSONField(name="REMARK")
    private String remark;

    /**
     */
	@JSONField(name="FACTOR_ONE")
    private String factorOne;

    /**
     */
	@JSONField(name="FACTOR_TWO")
    private String factorTwo;

    /**
     */
	@JSONField(name="FACTOR_THREE")
    private String factorThree;

    /**
     */
	@JSONField(name="FACTOR_FOUR")
    private String factorFour;

    public Long getTransSn(){
    	return this.transSn;
    }
 
    public void setTransSn(Long transSn){
      this.transSn=transSn;
    }
 
    public String getPhonenoOut(){
    	return this.phonenoOut;
    }
 
    public void setPhonenoOut(String phonenoOut){
      this.phonenoOut=phonenoOut;
    }
 
    public Long getContractnoOut(){
    	return this.contractnoOut;
    }
 
    public void setContractnoOut(Long contractnoOut){
      this.contractnoOut=contractnoOut;
    }
 
    public Long getIdnoOut(){
    	return this.idnoOut;
    }
 
    public void setIdnoOut(Long idnoOut){
      this.idnoOut=idnoOut;
    }
 
    public String getPhonenoIn(){
    	return this.phonenoIn;
    }
 
    public void setPhonenoIn(String phonenoIn){
      this.phonenoIn=phonenoIn;
    }
 
    public Long getContractnoIn(){
    	return this.contractnoIn;
    }
 
    public void setContractnoIn(Long contractnoIn){
      this.contractnoIn=contractnoIn;
    }
 
    public Long getIdnoIn(){
    	return this.idnoIn;
    }
 
    public void setIdnoIn(Long idnoIn){
      this.idnoIn=idnoIn;
    }
 
    public String getPayType(){
    	return this.payType;
    }
 
    public void setPayType(String payType){
      this.payType=payType;
    }
 
    public Long getTransFee(){
    	return this.transFee;
    }
 
    public void setTransFee(Long transFee){
      this.transFee=transFee;
    }
 
    public String getLoginNo(){
    	return this.loginNo;
    }
 
    public void setLoginNo(String loginNo){
      this.loginNo=loginNo;
    }
 
    public Integer getTotalDate(){
    	return this.totalDate;
    }
 
    public void setTotalDate(Integer totalDate){
      this.totalDate=totalDate;
    }
 
    public String getOpCode(){
    	return this.opCode;
    }
 
    public void setOpCode(String opCode){
      this.opCode=opCode;
    }
 
    public String getOpType(){
    	return this.opType;
    }
 
    public void setOpType(String opType){
      this.opType=opType;
    }
 
    public String getForeignSn(){
    	return this.foreignSn;
    }
 
    public void setForeignSn(String foreignSn){
      this.foreignSn=foreignSn;
    }

    public String getStatus(){
    	return this.status;
    }
 
    public void setStatus(String status){
      this.status=status;
    }
 
    public String getRemark(){
    	return this.remark;
    }
 
    public void setRemark(String remark){
      this.remark=remark;
    }
 
    public String getFactorOne(){
    	return this.factorOne;
    }
 
    public void setFactorOne(String factorOne){
      this.factorOne=factorOne;
    }
 
    public String getFactorTwo(){
    	return this.factorTwo;
    }
 
    public void setFactorTwo(String factorTwo){
      this.factorTwo=factorTwo;
    }
 
    public String getFactorThree(){
    	return this.factorThree;
    }
 
    public void setFactorThree(String factorThree){
      this.factorThree=factorThree;
    }
 
    public String getFactorFour(){
    	return this.factorFour;
    }
 
    public void setFactorFour(String factorFour){
      this.factorFour=factorFour;
    }

	/**
	 * @return the foreignDate
	 */
	public String getForeignDate() {
		return foreignDate;
	}

	/**
	 * @param foreignDate the foreignDate to set
	 */
	public void setForeignDate(String foreignDate) {
		this.foreignDate = foreignDate;
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

	/**
	 * @return the opTime1
	 */
	public String getOpTime1() {
		return opTime1;
	}

	/**
	 * @param opTime1 the opTime1 to set
	 */
	public void setOpTime1(String opTime1) {
		this.opTime1 = opTime1;
	}

	@Override
	public String toString() {
		return "TransFeeEntity [transSn=" + transSn + ", phonenoOut=" + phonenoOut + ", contractnoOut=" + contractnoOut + ", idnoOut=" + idnoOut
				+ ", phonenoIn=" + phonenoIn + ", contractnoIn=" + contractnoIn + ", idnoIn=" + idnoIn + ", payType=" + payType + ", transFee="
				+ transFee + ", loginNo=" + loginNo + ", totalDate=" + totalDate + ", opCode=" + opCode + ", opType=" + opType + ", foreignSn="
				+ foreignSn + ", foreignDate=" + foreignDate + ", opTime=" + opTime + ", opTime1=" + opTime1 + ", status=" + status + ", remark="
				+ remark + ", factorOne=" + factorOne + ", factorTwo=" + factorTwo + ", factorThree=" + factorThree + ", factorFour=" + factorFour
				+ "]";
	}
 
}
