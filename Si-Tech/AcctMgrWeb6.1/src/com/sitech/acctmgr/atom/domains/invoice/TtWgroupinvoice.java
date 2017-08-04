package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

/**
 * @author ：si-tech TRTD@liuhl
 * @genCode：xBatisTool
 * @CreatedAt：2017-04-05 15:33:07
 */
public class TtWgroupinvoice implements Serializable { 

  private static final long serialVersionUID = 1L;

    /**
     */
    private Long loginAccept;

    /**
     */
    private String sInvoiceNumber;

    /**
     */
    private String eInvoiceNumber;

    /**
     */
    private String invoiceNumber;

    /**
     */
    private String invoiceCode;

    /**
     */
    private String regionCode;

    /**
     */
    private String districtCode;

    /**
     */
    private String loginNo;

    /**
     */
	private String opTime;

    /**
     */
    private Integer yearMonth;

    /**
     */
    private String groupId;

    /**
     */
    private String flag;

    public Long getLoginAccept(){
    	return this.loginAccept;
    }
 
    public void setLoginAccept(Long loginAccept){
      this.loginAccept=loginAccept;
    }
 
    public String getSInvoiceNumber(){
    	return this.sInvoiceNumber;
    }
 
    public void setSInvoiceNumber(String sInvoiceNumber){
      this.sInvoiceNumber=sInvoiceNumber;
    }
 
    public String getEInvoiceNumber(){
    	return this.eInvoiceNumber;
    }
 
    public void setEInvoiceNumber(String eInvoiceNumber){
      this.eInvoiceNumber=eInvoiceNumber;
    }
 
    public String getInvoiceNumber(){
    	return this.invoiceNumber;
    }
 
    public void setInvoiceNumber(String invoiceNumber){
      this.invoiceNumber=invoiceNumber;
    }
 
    public String getInvoiceCode(){
    	return this.invoiceCode;
    }
 
    public void setInvoiceCode(String invoiceCode){
      this.invoiceCode=invoiceCode;
    }
 
    public String getRegionCode(){
    	return this.regionCode;
    }
 
    public void setRegionCode(String regionCode){
      this.regionCode=regionCode;
    }
 
    public String getDistrictCode(){
    	return this.districtCode;
    }
 
    public void setDistrictCode(String districtCode){
      this.districtCode=districtCode;
    }
 
    public String getLoginNo(){
    	return this.loginNo;
    }
 
    public void setLoginNo(String loginNo){
      this.loginNo=loginNo;
    }
 
    public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public Integer getYearMonth() {
    	return this.yearMonth;
    }
 
    public void setYearMonth(Integer yearMonth){
      this.yearMonth=yearMonth;
    }
 
    public String getGroupId(){
    	return this.groupId;
    }
 
    public void setGroupId(String groupId){
      this.groupId=groupId;
    }
 
    public String getFlag(){
    	return this.flag;
    }
 
    public void setFlag(String flag){
      this.flag=flag;
    }
 

}