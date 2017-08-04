package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class UserExpireEntity {
	  /**
     */
	@JSONField(name = "ID_NO")
    private Long idNo;

    /**
     */
	@JSONField(name = "EXPIRE_TIME_TYPE")
    private String expireTimeType;

    /**
     */
	@JSONField(name = "EXPIRE_TYPE")
    private Integer expireType;

    /**
     */
	@JSONField(name = "BEGIN_FLAG")
    private String beginFlag;

    /**
     */
	@JSONField(name = "BEGIN_TIME")
    private String beginTime;
	
    /**
     */
	@JSONField(name = "BEGIN_TIME1")
    private String beginTime1;

    /**
     */
	@JSONField(name = "OLD_EXPIRE")
    private String oldExpire;

    /**
     */
	@JSONField(name = "EXPIRE_TIME")
    @ParamDesc(path = "EXPIRE_TIME", desc = "有效期", cons = ConsType.CT001, len = "20", memo = "YYYY-MM-DD HH24:MI:SS")
    private String expireTime;
	
    /**
     */
	@JSONField(name = "EXPIRE_TIME1")
    @ParamDesc(path = "EXPIRE_TIME1", desc = "有效期", cons = ConsType.CT001, len = "14", memo = "YYYYMMDDHH24MISS")
    private String expireTime1;
	
    /**
     */
	@JSONField(name = "EXPIREDAYS")
    private String expireDays;

    /**
     */
	@JSONField(name = "LATEST_USE_TIME")
    private String latestUseTime;

    /**
     */
	@JSONField(name = "BAK_FIELD")
    private String bakField;

    /**
     */
	@JSONField(name = "FINISH_FLAG")
    private String finishFlag;

    /**
     */
	@JSONField(name = "OP_TIME")
    private String opTime;
	
    /**
     */
	@JSONField(name = "KEEP_TIME")
    private String keepTime;


    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getExpireTimeType(){
    	return this.expireTimeType;
    }
 
    public void setExpireTimeType(String expireTimeType){
      this.expireTimeType=expireTimeType;
    }
 
    public Integer getExpireType(){
    	return this.expireType;
    }
 
    public void setExpireType(Integer expireType){
      this.expireType=expireType;
    }
 
    public String getBeginFlag(){
    	return this.beginFlag;
    }
 
    public void setBeginFlag(String beginFlag){
      this.beginFlag=beginFlag;
    }
 
    public String getBeginTime(){
    	return this.beginTime;
    }
 
    public void setBeginTime(String beginTime){
      this.beginTime=beginTime;
    }
 
    public String getOldExpire(){
    	return this.oldExpire;
    }
 
    public void setOldExpire(String oldExpire){
      this.oldExpire=oldExpire;
    }
 
    public String getExpireTime(){
    	return this.expireTime;
    }
 
    public void setExpireTime(String expireTime){
      this.expireTime=expireTime;
    }
 
    public String getLatestUseTime(){
    	return this.latestUseTime;
    }
 
    public void setLatestUseTime(String latestUseTime){
      this.latestUseTime=latestUseTime;
    }
 
    public String getBakField(){
    	return this.bakField;
    }
 
    public void setBakField(String bakField){
      this.bakField=bakField;
    }
 
    public String getFinishFlag(){
    	return this.finishFlag;
    }
 
    public void setFinishFlag(String finishFlag){
      this.finishFlag=finishFlag;
    }
 
    public String getOpTime(){
    	return this.opTime;
    }
 
    public void setOpTime(String opTime){
      this.opTime=opTime;
    }

	/**
	 * @return the beginTime1
	 */
	public String getBeginTime1() {
		return beginTime1;
	}

	/**
	 * @param beginTime1 the beginTime1 to set
	 */
	public void setBeginTime1(String beginTime1) {
		this.beginTime1 = beginTime1;
	}

	/**
	 * @return the expireTime1
	 */
	public String getExpireTime1() {
		return expireTime1;
	}

	/**
	 * @param expireTime1 the expireTime1 to set
	 */
	public void setExpireTime1(String expireTime1) {
		this.expireTime1 = expireTime1;
	}

	/**
	 * @return the expireDays
	 */
	public String getExpireDays() {
		return expireDays;
	}

	/**
	 * @param expireDays the expireDays to set
	 */
	public void setExpireDays(String expireDays) {
		this.expireDays = expireDays;
	}

	/**
	 * @return the keepTime
	 */
	public String getKeepTime() {
		return keepTime;
	}

	/**
	 * @param keepTime the keepTime to set
	 */
	public void setKeepTime(String keepTime) {
		this.keepTime = keepTime;
	}

    @Override
    public String toString() {
        return "UserExpireEntity{" +
                "idNo=" + idNo +
                ", expireTimeType='" + expireTimeType + '\'' +
                ", expireType=" + expireType +
                ", beginFlag='" + beginFlag + '\'' +
                ", beginTime='" + beginTime + '\'' +
                ", beginTime1='" + beginTime1 + '\'' +
                ", oldExpire='" + oldExpire + '\'' +
                ", expireTime='" + expireTime + '\'' +
                ", expireTime1='" + expireTime1 + '\'' +
                ", expireDays='" + expireDays + '\'' +
                ", latestUseTime='" + latestUseTime + '\'' +
                ", bakField='" + bakField + '\'' +
                ", finishFlag='" + finishFlag + '\'' +
                ", opTime='" + opTime + '\'' +
                ", keepTime='" + keepTime + '\'' +
                '}';
    }
}
