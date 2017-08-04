package com.sitech.acctmgr.atom.domains.user;

import java.io.Serializable; 

import com.alibaba.fastjson.annotation.JSONField;

public class ExpireOprEntity implements Serializable { 

  private static final long serialVersionUID = 1L;

    /**
     */
  @JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
  @JSONField(name = "DAYS")
    private Integer days;

    /**
     */
  @JSONField(name = "LOGIN_NO")
    private String loginNo;

    /**
     */
  @JSONField(name = "OP_CODE")
    private String opCode;
    
    /**
     */
  @JSONField(name = "FUNC_NAME")
    private String funcName;

    /**
     */
  @JSONField(name = "OP_TIME")
    private String opTime;

    /**
     */
  @JSONField(name = "REMARK")
    private String remark;

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
	 * @return the days
	 */
	public Integer getDays() {
		return days;
	}

	/**
	 * @param days the days to set
	 */
	public void setDays(Integer days) {
		this.days = days;
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
	 * @return the funcName
	 */
	public String getFuncName() {
		return funcName;
	}

	/**
	 * @param funcName the funcName to set
	 */
	public void setFuncName(String funcName) {
		this.funcName = funcName;
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