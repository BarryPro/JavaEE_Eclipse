package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class ServAddNumEntity {

	 /**
     */
	@JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
	@JSONField(name = "PHONE_NO")
    private String phoneNo;

    /**
     */
	@JSONField(name = "ADD_SERVICE_NO")
    private String addServiceNo;

    /**
     */
	@JSONField(name = "ADD_NBR_TYPE")
    private String addNbrType;

    /**
     */
	@JSONField(name = "MASTER_SERV_ID")
    private String masterServId;

    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getPhoneNo(){
    	return this.phoneNo;
    }
 
    public void setPhoneNo(String phoneNo){
      this.phoneNo=phoneNo;
    }
 
    public String getAddServiceNo(){
    	return this.addServiceNo;
    }
 
    public void setAddServiceNo(String addServiceNo){
      this.addServiceNo=addServiceNo;
    }
 
    public String getAddNbrType(){
    	return this.addNbrType;
    }
 
    public void setAddNbrType(String addNbrType){
      this.addNbrType=addNbrType;
    }
 
    public String getMasterServId(){
    	return this.masterServId;
    }
 
    public void setMasterServId(String masterServId){
      this.masterServId=masterServId;
    }
 
}
