package com.sitech.acctmgr.atom.domains.balance;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title: 展示活动订购信息）
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2017
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author hanfl
 * @version 1.0
 */
public class ActEntity implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6844269534059277531L;

	@JSONField(name = "ACT_ID")
	@ParamDesc(path = "ACT_ID", cons = ConsType.QUES, type = "String", len = "20", desc = "活动编号", memo = "略")
	private String actId;

	@JSONField(name = "ACT_NAME")
	@ParamDesc(path = "ACT_NAME", cons = ConsType.QUES, type = "String", len = "20", desc = "活动名称", memo = "略")
	private String actName;

	@JSONField(name = "SERIAL_NO")
	@ParamDesc(path = "SERIAL_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "流水", memo = "略")
	private String serialNo;

	@JSONField(name = "MKT_DICTION")
	@ParamDesc(path = "MKT_DICTION", cons = ConsType.QUES, type = "String", len = "256", desc = "营销用语", memo = "略")
	private String mktDiction;

	@JSONField(name = "ORDER_TYPE")
	@ParamDesc(path = "ORDER_TYPE", cons = ConsType.QUES, type = "String", len = "256", desc = "订购标示 ", memo = "略")
	private String orderType;

	@JSONField(name = "ACT_CLASS")
	@ParamDesc(path = "ACT_CLASS", cons = ConsType.QUES, type = "String", len = "20", desc = "营销活动类型", memo = "略")
	private String actClass;
	
	@JSONField(name = "CONCEL_PRIFEE")
	@ParamDesc(path = "CONCEL_PRIFEE", cons = ConsType.QUES, type = "String", len = "256", desc = "", memo = "略")
	private String concelPrifee;
		
	@JSONField(name = "BUSI_ID")
	@ParamDesc(path = "BUSI_ID", cons = ConsType.QUES, type = "String", len = "20", desc = "销售流水", memo = "略")
	private String busiId;

	@JSONField(name = "OP_TIME")
	@ParamDesc(path = "OP_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "订购时间", memo = "略")
	private String opTime;

	@JSONField(name = "BUSINESS_TYPE")
	@ParamDesc(path = "BUSINESS_TYPE", cons = ConsType.QUES, type = "String", len = "20", desc = "营销用语", memo = "略")
	private String businessType;

	public Map<String, Object> toMap(){
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	/**
	 * @return the actId
	 */
	public String getActId() {
		return actId;
	}

	/**
	 * @return the actName
	 */
	public String getActName() {
		return actName;
	}

	/**
	 * @return the serialNo
	 */
	public String getSerialNo() {
		return serialNo;
	}

	/**
	 * @return the mktDiction
	 */
	public String getMktDiction() {
		return mktDiction;
	}

	/**
	 * @return the orderType
	 */
	public String getOrderType() {
		return orderType;
	}

	/**
	 * @return the actClass
	 */
	public String getActClass() {
		return actClass;
	}

	/**
	 * @return the concelPrifee
	 */
	public String getConcelPrifee() {
		return concelPrifee;
	}

	/**
	 * @return the busiId
	 */
	public String getBusiId() {
		return busiId;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @return the businessType
	 */
	public String getBusinessType() {
		return businessType;
	}

	/**
	 * @param actId the actId to set
	 */
	public void setActId(String actId) {
		this.actId = actId;
	}

	/**
	 * @param actName the actName to set
	 */
	public void setActName(String actName) {
		this.actName = actName;
	}

	/**
	 * @param serialNo the serialNo to set
	 */
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	/**
	 * @param mktDiction the mktDiction to set
	 */
	public void setMktDiction(String mktDiction) {
		this.mktDiction = mktDiction;
	}

	/**
	 * @param orderType the orderType to set
	 */
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	/**
	 * @param actClass the actClass to set
	 */
	public void setActClass(String actClass) {
		this.actClass = actClass;
	}

	/**
	 * @param concelPrifee the concelPrifee to set
	 */
	public void setConcelPrifee(String concelPrifee) {
		this.concelPrifee = concelPrifee;
	}

	/**
	 * @param busiId the busiId to set
	 */
	public void setBusiId(String busiId) {
		this.busiId = busiId;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @param businessType the businessType to set
	 */
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ActEntity [actId=" + actId + ", actName=" + actName + ", serialNo=" + serialNo + ", mktDiction="
				+ mktDiction + ", orderType=" + orderType + ", actClass=" + actClass + ", concelPrifee=" + concelPrifee
				+ ", busiId=" + busiId + ", opTime=" + opTime + ", businessType=" + businessType + "]";
	}

}
