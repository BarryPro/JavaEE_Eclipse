package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class UserdetaildeadEntity {

	 /**
     */
	@JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
	@JSONField(name = "RUN_CODE")
    private String runCode;
	
	@JSONField(name = "RUN_NAME")
    private String runName;

    /**
     */
	@JSONField(name = "RUN_TIME")
    private String runTime;

    /**
     */
	@JSONField(name = "USER_GRADE_CODE")
    private String userGradeCode;

    /**
     */
	@JSONField(name = "STOP_FLAG")
    private String stopFlag;

    /**
     */
	@JSONField(name = "OWED_FLAG")
    private String owedFlag;

    /**
     */
	@JSONField(name = "USER_PASSWD")
    private String userPasswd;

    /**
     */
	@JSONField(name = "PASSWD_TYPE")
    private String passwdType;

    /**
     */
	@JSONField(name = "CARD_TYPE")
    private Integer cardType;

    /**
     */
	@JSONField(name = "VIP_CARD_NO")
    private String vipCardNo;

    /**
     */
	@JSONField(name = "VIP_CREATE_TYPE")
    private Integer vipCreateType;

    /**
     */
	@JSONField(name = "OLD_RUN")
    private String oldRun;

    /**
     */
	@JSONField(name = "QUERY_CDRFLAG")
    private String queryCdrflag;

    /**
     */
	@JSONField(name = "LMT_ADJUST_TYPE")
    private String lmtAdjustType;

    /**
     */
	@JSONField(name = "OP_TIME")
    private String opTime;

    /**
     */
	@JSONField(name = "LOGIN_NO")
    private String loginNo;

    /**
     */
	@JSONField(name = "OP_CODE")
    private String opCode;

    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getRunCode(){
    	return this.runCode;
    }
 
    public void setRunCode(String runCode){
      this.runCode=runCode;
    }
 
    public String getUserGradeCode(){
    	return this.userGradeCode;
    }
 
    public void setUserGradeCode(String userGradeCode){
      this.userGradeCode=userGradeCode;
    }
 
    public String getStopFlag(){
    	return this.stopFlag;
    }
 
    public void setStopFlag(String stopFlag){
      this.stopFlag=stopFlag;
    }
 
    public String getOwedFlag(){
    	return this.owedFlag;
    }
 
    public void setOwedFlag(String owedFlag){
      this.owedFlag=owedFlag;
    }
 
    public String getUserPasswd(){
    	return this.userPasswd;
    }
 
    public void setUserPasswd(String userPasswd){
      this.userPasswd=userPasswd;
    }
 
    public String getPasswdType(){
    	return this.passwdType;
    }
 
    public void setPasswdType(String passwdType){
      this.passwdType=passwdType;
    }
 
    public Integer getCardType(){
    	return this.cardType;
    }
 
    public void setCardType(Integer cardType){
      this.cardType=cardType;
    }
 
    public String getVipCardNo(){
    	return this.vipCardNo;
    }
 
    public void setVipCardNo(String vipCardNo){
      this.vipCardNo=vipCardNo;
    }
 
    public Integer getVipCreateType(){
    	return this.vipCreateType;
    }
 
    public void setVipCreateType(Integer vipCreateType){
      this.vipCreateType=vipCreateType;
    }
 
    public String getOldRun(){
    	return this.oldRun;
    }
 
    public void setOldRun(String oldRun){
      this.oldRun=oldRun;
    }
 
    public String getQueryCdrflag(){
    	return this.queryCdrflag;
    }
 
    public void setQueryCdrflag(String queryCdrflag){
      this.queryCdrflag=queryCdrflag;
    }
 
    public String getLmtAdjustType(){
    	return this.lmtAdjustType;
    }
 
    public void setLmtAdjustType(String lmtAdjustType){
      this.lmtAdjustType=lmtAdjustType;
    }
 
    public String getLoginNo(){
    	return this.loginNo;
    }
 
    public void setLoginNo(String loginNo){
      this.loginNo=loginNo;
    }
 
    public String getOpCode(){
    	return this.opCode;
    }
 
    public void setOpCode(String opCode){
      this.opCode=opCode;
    }

	/**
	 * @return the runName
	 */
	public String getRunName() {
		return runName;
	}

	/**
	 * @param runName the runName to set
	 */
	public void setRunName(String runName) {
		this.runName = runName;
	}

	/**
	 * @return the runTime
	 */
	public String getRunTime() {
		return runTime;
	}

	/**
	 * @param runTime the runTime to set
	 */
	public void setRunTime(String runTime) {
		this.runTime = runTime;
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
 
}
