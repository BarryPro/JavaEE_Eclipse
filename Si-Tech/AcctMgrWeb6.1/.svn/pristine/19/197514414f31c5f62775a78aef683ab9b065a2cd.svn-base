package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   投诉退费冲正查询出参DTO</p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guow
 * @version 1.0
 */
public class S8041BackInitOutDTO  extends CommonOutDTO{	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3194344250310236198L;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected	String phoneNo;
	
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	protected	String remark;
		
	@JSONField(name="ADJ_REASON_ONE")
	@ParamDesc(path="ADJ_REASON_ONE",cons=ConsType.QUES,type="String",len="100",desc="退费一级原因",memo="略")
	protected	String adjReasonOne;
	
	@JSONField(name="ADJ_REASON_TWO")
	@ParamDesc(path="ADJ_REASON_TWO",cons=ConsType.QUES,type="String",len="100",desc="退费二级原因",memo="略")
	protected	String adjReasonTwo;
	
	@JSONField(name="ADJ_REASON_THREE")
	@ParamDesc(path="ADJ_REASON_THREE",cons=ConsType.QUES,type="String",len="100",desc="退费三级原因",memo="略")
	protected	String adjReasonThree;
	
	@JSONField(name="ADJ_REASON_ONE_NAME")
	@ParamDesc(path="ADJ_REASON_ONE_NAME",cons=ConsType.QUES,type="String",len="100",desc="退费一级原因",memo="略")
	protected	String adjReasonOneName;
	
	@JSONField(name="ADJ_REASON_TWO_NAME")
	@ParamDesc(path="ADJ_REASON_TWO_NAME",cons=ConsType.QUES,type="String",len="100",desc="退费二级原因",memo="略")
	protected	String adjReasonTwoName;
	
	@JSONField(name="ADJ_REASON_THREE_NAME")
	@ParamDesc(path="ADJ_REASON_THREE_NAME",cons=ConsType.QUES,type="String",len="100",desc="退费三级原因",memo="略")
	protected	String adjReasonThreeName;

	@JSONField(name="ADJ_TYPE")
	@ParamDesc(path="ADJ_TYPE",cons=ConsType.QUES,type="String",len="4",desc="退费类型",memo="略")
	protected	String adjType;
	
	@JSONField(name="ADJ_TYPE_NAME")
	@ParamDesc(path="ADJ_TYPE_NAME",cons=ConsType.QUES,type="String",len="20",desc="退费类型名称",memo="双倍 单倍")
	protected	String adjTypeName;
	
	@JSONField(name="BACK_TYPE_NAME")
	@ParamDesc(path="BACK_TYPE_NAME",cons=ConsType.QUES,type="String",len="20",desc="退费种类名称",memo="退预存款 退现金")
	protected	String backTypeName;
	
	@JSONField(name="ERR_SERIAL")
	@ParamDesc(path="ERR_SERIAL",cons=ConsType.QUES,type="String",len="50",desc="投诉电子单号",memo="略")
	protected String errSerial;
	
	@JSONField(name="OPER_CODE")
	@ParamDesc(path="OPER_CODE",cons=ConsType.QUES,type="String",len="50",desc="SP业务代码",memo="略")	
	protected String operCode;
	
	@JSONField(name="OPER_NAME")
	@ParamDesc(path="OPER_NAME",cons=ConsType.QUES,type="String",len="50",desc="SP业务名称",memo="略")	
	protected String operName;
	
	@JSONField(name="SP_NAME")
	@ParamDesc(path="SP_NAME",cons=ConsType.QUES,type="String",len="50",desc="sp企业名字",memo="略")	
	protected String spName;
	
	@JSONField(name="SP_CODE")
	@ParamDesc(path="SP_CODE",cons=ConsType.QUES,type="String",len="50",desc="SP企业代码",memo="略")	
	protected String spCode;
	
	@JSONField(name="LAST_TIME")
	@ParamDesc(path="LAST_TIME",cons=ConsType.QUES,type="String",len="25",desc="业务使用时间",memo="略")	
	protected String lastTime;
	
	@JSONField(name="OP_SN")
	@ParamDesc(path="OP_SN",cons=ConsType.QUES,type="String",len="50",desc="投诉系统流水",memo="略")	
	protected String opSn;

	@JSONField(name="BACK_FEE")
	@ParamDesc(path="BACK_FEE",cons=ConsType.QUES,type="long",len="14",desc="退费金额",memo="略")	
	protected long backFee;
	
	@JSONField(name="COM_FEE")
	@ParamDesc(path="COM_FEE",cons=ConsType.QUES,type="long",len="14",desc="补偿金额",memo="略")	
	protected long comFee;
	
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonOutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("remark"), remark);
		result.setRoot(getPathByProperName("adjReasonOne"), adjReasonOne);
		result.setRoot(getPathByProperName("adjReasonTwo"), adjReasonTwo);
		result.setRoot(getPathByProperName("adjReasonThree"), adjReasonThree);
		result.setRoot(getPathByProperName("adjReasonOneName"), adjReasonOneName);
		result.setRoot(getPathByProperName("adjReasonTwoName"), adjReasonTwoName);
		result.setRoot(getPathByProperName("adjReasonThreeName"), adjReasonThreeName);
		result.setRoot(getPathByProperName("adjType"), adjType);
		result.setRoot(getPathByProperName("adjTypeName"), adjTypeName);
		result.setRoot(getPathByProperName("backTypeName"), backTypeName);
		result.setRoot(getPathByProperName("errSerial"), errSerial);
		result.setRoot(getPathByProperName("operCode"), operCode);
		result.setRoot(getPathByProperName("operName"), operName);
		result.setRoot(getPathByProperName("spName"), spName);
		result.setRoot(getPathByProperName("spCode"), spCode);
		result.setRoot(getPathByProperName("lastTime"), lastTime);
		result.setRoot(getPathByProperName("opSn"), opSn);	
		result.setRoot(getPathByProperName("backFee"), backFee);
		result.setRoot(getPathByProperName("comFee"), comFee);
		return result;
	}



	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}


	

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
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
	 * @return the adjReasonOne
	 */
	public String getAdjReasonOne() {
		return adjReasonOne;
	}



	/**
	 * @param adjReasonOne the adjReasonOne to set
	 */
	public void setAdjReasonOne(String adjReasonOne) {
		this.adjReasonOne = adjReasonOne;
	}



	/**
	 * @return the adjReasonTwo
	 */
	public String getAdjReasonTwo() {
		return adjReasonTwo;
	}



	/**
	 * @param adjReasonTwo the adjReasonTwo to set
	 */
	public void setAdjReasonTwo(String adjReasonTwo) {
		this.adjReasonTwo = adjReasonTwo;
	}



	/**
	 * @return the adjReasonThree
	 */
	public String getAdjReasonThree() {
		return adjReasonThree;
	}



	/**
	 * @param adjReasonThree the adjReasonThree to set
	 */
	public void setAdjReasonThree(String adjReasonThree) {
		this.adjReasonThree = adjReasonThree;
	}
	
	
	public String getAdjReasonOneName() {
		return adjReasonOneName;
	}



	public void setAdjReasonOneName(String adjReasonOneName) {
		this.adjReasonOneName = adjReasonOneName;
	}



	public String getAdjReasonTwoName() {
		return adjReasonTwoName;
	}



	public void setAdjReasonTwoName(String adjReasonTwoName) {
		this.adjReasonTwoName = adjReasonTwoName;
	}



	public String getAdjReasonThreeName() {
		return adjReasonThreeName;
	}



	public void setAdjReasonThreeName(String adjReasonThreeName) {
		this.adjReasonThreeName = adjReasonThreeName;
	}



	/**
	 * @return the adjType
	 */
	public String getAdjType() {
		return adjType;
	}



	/**
	 * @param adjType the adjType to set
	 */
	public void setAdjType(String adjType) {
		this.adjType = adjType;
	}



	/**
	 * @return the adjTypeName
	 */
	public String getAdjTypeName() {
		return adjTypeName;
	}



	/**
	 * @param adjTypeName the adjTypeName to set
	 */
	public void setAdjTypeName(String adjTypeName) {
		this.adjTypeName = adjTypeName;
	}



	/**
	 * @return the backTypeName
	 */
	public String getBackTypeName() {
		return backTypeName;
	}



	/**
	 * @param backTypeName the backTypeName to set
	 */
	public void setBackTypeName(String backTypeName) {
		this.backTypeName = backTypeName;
	}



	/**
	 * @return the errSerial
	 */
	public String getErrSerial() {
		return errSerial;
	}



	/**
	 * @param errSerial the errSerial to set
	 */
	public void setErrSerial(String errSerial) {
		this.errSerial = errSerial;
	}



	/**
	 * @return the backFee
	 */
	public long getBackFee() {
		return backFee;
	}



	/**
	 * @param backFee the backFee to set
	 */
	public void setBackFee(long backFee) {
		this.backFee = backFee;
	}



	/**
	 * @return the comFee
	 */
	public long getComFee() {
		return comFee;
	}



	/**
	 * @param comFee the comFee to set
	 */
	public void setComFee(long comFee) {
		this.comFee = comFee;
	}



	public String getOperCode() {
		return operCode;
	}



	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}



	public String getOperName() {
		return operName;
	}



	public void setOperName(String operName) {
		this.operName = operName;
	}





	public String getSpName() {
		return spName;
	}



	public void setSpName(String spName) {
		this.spName = spName;
	}



	public String getSpCode() {
		return spCode;
	}



	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}



	public String getLastTime() {
		return lastTime;
	}



	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}



	public String getOpSn() {
		return opSn;
	}



	public void setOpSn(String opSn) {
		this.opSn = opSn;
	}
}
