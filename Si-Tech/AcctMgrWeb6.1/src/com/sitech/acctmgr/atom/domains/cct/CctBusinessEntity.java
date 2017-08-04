package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

public class CctBusinessEntity {

	private static final long serialVersionUID = 1L;

    /**
     */
	@JSONField(name = "REGION_ID")
    private Integer regionId;

    /**
     */
    @JSONField(name = "CTRL_NO")
    private Integer ctrlNo;

    /**
     */
    @JSONField(name = "CTRL_FLAG")
    private Integer ctrlFlag;

    /**
     */
    @JSONField(name = "OP_CODE")
    private String opCode;


    public Integer getRegionId(){
    	return this.regionId;
    }
 
    public void setRegionId(Integer regionId){
      this.regionId=regionId;
    }
 
    public Integer getCtrlNo(){
    	return this.ctrlNo;
    }
 
    public void setCtrlNo(Integer ctrlNo){
      this.ctrlNo=ctrlNo;
    }
 
    public Integer getCtrlFlag(){
    	return this.ctrlFlag;
    }
 
    public void setCtrlFlag(Integer ctrlFlag){
      this.ctrlFlag=ctrlFlag;
    }
 
    public String getOpCode(){
    	return this.opCode;
    }
 
    public void setOpCode(String opCode){
      this.opCode=opCode;
    }
 
}
