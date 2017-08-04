package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @Title:   []
 * @Description: 
 * @Date : 2015年2月28日下午2:46:22
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
public class SGrpUnifyBackCfmOutDTO extends CommonOutDTO {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 3723965995684439306L;
	
	@JSONField(name="ORI_REQ_SYS")
	@ParamDesc(path="ORI_REQ_SYS",cons=ConsType.CT001,type="String",len="4",desc="原始请求",memo="略")
	private String 	oriReqSys;
	@JSONField(name="ORI_TRANSACTION_ID")
	@ParamDesc(path="ORI_TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="原始流水",memo="略")
	private String 	oriTransactionID;
	@JSONField(name="ORI_ACTION_DATE")
	@ParamDesc(path="ORI_ACTION_DATE",cons=ConsType.CT001,type="String",len="8",desc="原始账期",memo="略")
	private String  oriActionDate ;
	@JSONField(name="TRANSACTION_ID")
	@ParamDesc(path="TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="统一流水",memo="略")
	private String  transactionId; 
	@JSONField(name="SETTLE_DATE")
	@ParamDesc(path="SETTLE_DATE",cons=ConsType.CT001,type="String",len="8",desc="交易账期",memo="略")
	private String 	settleDate;
	
	@JSONField(name="RSP_CODE")
	@ParamDesc(path="RSP_CODE",cons=ConsType.CT001,type="String",len="4",desc="二级返回码",memo="略")
	private String 	rspCode; 
	@JSONField(name="RSP_INFO")
	@ParamDesc(path="RSP_INFO",cons=ConsType.CT001,type="String",len="1024",desc="返回信息",memo="略")
	private String 	rspInfo; 
	
/*	public SGrpUnifyBackCfmOutDTO(){

	}
	
	public SGrpUnifyBackCfmOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.sOriReqSys = mBean.getBodyStr("OUT_DATA.ORI_REQ_SYS");
		this.sOriTransactionID = mBean.getBodyStr("OUT_DATA.ORI_TRANSACTION_ID");
		this.sOriActionDate = mBean.getBodyStr("OUT_DATA.ORI_ACTION_DATE");
		this.sRspCode = mBean.getBodyStr("OUT_DATA.RSP_CODE");
		this.sRspInfo = mBean.getBodyStr("OUT_DATA.RSP_INFO");
		this.sTransactionId = mBean.getBodyStr("OUT_DATA.TRANSACTION_ID");
		this.sSettleDate = mBean.getBodyStr("OUT_DATA.SETTLE_DATE");
	}*/
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result = super.encode();
		result.setRoot(getPathByProperName("oriReqSys"), oriReqSys);
		result.setRoot(getPathByProperName("oriTransactionID"), oriTransactionID);
		result.setRoot(getPathByProperName("oriActionDate"), oriActionDate);
		result.setRoot(getPathByProperName("rspCode"), rspCode);
		result.setRoot(getPathByProperName("rspInfo"), rspInfo);
		result.setRoot(getPathByProperName("transactionId"), transactionId);
		result.setRoot(getPathByProperName("settleDate"), settleDate);
		return result;
	}

	/**
	 * @return the oriReqSys
	 */
	public String getOriReqSys() {
		return oriReqSys;
	}

	/**
	 * @param oriReqSys the oriReqSys to set
	 */
	public void setOriReqSys(String oriReqSys) {
		this.oriReqSys = oriReqSys;
	}

	/**
	 * @return the oriTransactionID
	 */
	public String getOriTransactionID() {
		return oriTransactionID;
	}

	/**
	 * @param oriTransactionID the oriTransactionID to set
	 */
	public void setOriTransactionID(String oriTransactionID) {
		this.oriTransactionID = oriTransactionID;
	}

	/**
	 * @return the oriActionDate
	 */
	public String getOriActionDate() {
		return oriActionDate;
	}

	/**
	 * @param oriActionDate the oriActionDate to set
	 */
	public void setOriActionDate(String oriActionDate) {
		this.oriActionDate = oriActionDate;
	}

	/**
	 * @return the rspCode
	 */
	public String getRspCode() {
		return rspCode;
	}

	/**
	 * @param rspCode the rspCode to set
	 */
	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}

	/**
	 * @return the rspInfo
	 */
	public String getRspInfo() {
		return rspInfo;
	}

	/**
	 * @param rspInfo the rspInfo to set
	 */
	public void setRspInfo(String rspInfo) {
		this.rspInfo = rspInfo;
	}

	/**
	 * @return the transactionId
	 */
	public String getTransactionId() {
		return transactionId;
	}

	/**
	 * @param transactionId the transactionId to set
	 */
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	/**
	 * @return the settleDate
	 */
	public String getSettleDate() {
		return settleDate;
	}

	/**
	 * @param settleDate the settleDate to set
	 */
	public void setSettleDate(String settleDate) {
		this.settleDate = settleDate;
	}
  
	
}
