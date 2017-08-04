package com.sitech.acctmgr.atom.domains.account;

import com.alibaba.fastjson.annotation.JSONField;

public class ContractDeadInfoEntity {

    /**
     */
	@JSONField(name = "CONTRACT_NO")
    private Long contractNo;

    /**
     */
	@JSONField(name = "ACCOUNT_LIMIT")
    private String accountLimit;

    /**
     */
	@JSONField(name = "ACCOUNT_TYPE")
    private String accountType;

    /**
     */
	@JSONField(name = "CONTRACTATT_TYPE")
    private String contractattType;
	
    /**
     */
	@JSONField(name = "CONTRACTATT_TYPE_NAME")
    private String contractattTypeName;

    /**
     */
	@JSONField(name = "CONTRACT_NAME")
    private String contractName;
	
    /**
     */
	@JSONField(name = "BLUR_CONTRACTNAME")
    private String blurContractName;
	
    /**
     */
	@JSONField(name = "PAY_CODE_NAME")
    private String payCodeName;

    /**
     */
	@JSONField(name = "CONTRACT_PASSWD")
    private String contractPasswd;

    /**
     */
	@JSONField(name = "CUST_ID")
    private Long custId;

    /**
     */
	@JSONField(name = "GROUP_ID")
    private String groupId;

    /**
     */
	@JSONField(name = "PAY_CODE")
    private String payCode;


    public Long getContractNo(){
    	return this.contractNo;
    }
 
    public void setContractNo(Long contractNo){
      this.contractNo=contractNo;
    }
 
    public String getAccountLimit(){
    	return this.accountLimit;
    }
 
    public void setAccountLimit(String accountLimit){
      this.accountLimit=accountLimit;
    }
 
    public String getAccountType(){
    	return this.accountType;
    }
 
    public void setAccountType(String accountType){
      this.accountType=accountType;
    }
 
    public String getContractattType(){
    	return this.contractattType;
    }
 
    public void setContractattType(String contractattType){
      this.contractattType=contractattType;
    }
 
    public String getContractName(){
    	return this.contractName;
    }
 
    public void setContractName(String contractName){
      this.contractName=contractName;
    }
 
    public String getContractPasswd(){
    	return this.contractPasswd;
    }
 
    public void setContractPasswd(String contractPasswd){
      this.contractPasswd=contractPasswd;
    }
 
    public Long getCustId(){
    	return this.custId;
    }
 
    public void setCustId(Long custId){
      this.custId=custId;
    }
 
    public String getGroupId(){
    	return this.groupId;
    }
 
    public void setGroupId(String groupId){
      this.groupId=groupId;
    }
 
    public String getPayCode(){
    	return this.payCode;
    }
 
    public void setPayCode(String payCode){
      this.payCode=payCode;
    }

	/**
	 * @return the blurContractName
	 */
	public String getBlurContractName() {
		return blurContractName;
	}

	/**
	 * @param blurContractName the blurContractName to set
	 */
	public void setBlurContractName(String blurContractName) {
		this.blurContractName = blurContractName;
	}

	/**
	 * @return the payCodeName
	 */
	public String getPayCodeName() {
		return payCodeName;
	}

	/**
	 * @param payCodeName the payCodeName to set
	 */
	public void setPayCodeName(String payCodeName) {
		this.payCodeName = payCodeName;
	}

	/**
	 * @return the contractattTypeName
	 */
	public String getContractattTypeName() {
		return contractattTypeName;
	}

	/**
	 * @param contractattTypeName the contractattTypeName to set
	 */
	public void setContractattTypeName(String contractattTypeName) {
		this.contractattTypeName = contractattTypeName;
	}
 
 
}
