package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class UserDetailEntity {

	 /**
     */
	@JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
	@JSONField(name = "RUN_CODE")
    private String runCode;
	
    /**
     */
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
	@JSONField(name = "USER_PASSWD")
    private String userPasswd;

    /**
     */
	@JSONField(name = "CARD_TYPE")
    private Integer cardType;

    /**
     */
	@JSONField(name = "OLD_RUN")
    private String oldRun;

	/**
	 * @return the idNo
	 */
	public Long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the runCode
	 */
	public String getRunCode() {
		return runCode;
	}

	/**
	 * @param runCode the runCode to set
	 */
	public void setRunCode(String runCode) {
		this.runCode = runCode;
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
	 * @return the userGradeCode
	 */
	public String getUserGradeCode() {
		return userGradeCode;
	}

	/**
	 * @param userGradeCode the userGradeCode to set
	 */
	public void setUserGradeCode(String userGradeCode) {
		this.userGradeCode = userGradeCode;
	}

	/**
	 * @return the userPasswd
	 */
	public String getUserPasswd() {
		return userPasswd;
	}

	/**
	 * @param userPasswd the userPasswd to set
	 */
	public void setUserPasswd(String userPasswd) {
		this.userPasswd = userPasswd;
	}

	/**
	 * @return the cardType
	 */
	public Integer getCardType() {
		return cardType;
	}

	/**
	 * @param cardType the cardType to set
	 */
	public void setCardType(Integer cardType) {
		this.cardType = cardType;
	}

	/**
	 * @return the oldRun
	 */
	public String getOldRun() {
		return oldRun;
	}

	/**
	 * @param oldRun the oldRun to set
	 */
	public void setOldRun(String oldRun) {
		this.oldRun = oldRun;
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

}
