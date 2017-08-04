package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @Title:   []
 * @Description: 
 * @Date : 20161202
 * @Company: SI-TECH
 * @author : qiaolin
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
public class SGrpUnifyBackCfmInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.ORI_REQ_SYS",cons=ConsType.CT001,type="String",len="4",desc="请求信息",memo="略")
	private String 	oriReqSys;
	@ParamDesc(path="BUSI_INFO.ORI_ACTION_DATE",cons=ConsType.CT001,type="String",len="32",desc="请求缴费日期",memo="略")
	private String  oriActionDate ;
	@ParamDesc(path="BUSI_INFO.ORI_TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="原始统一流水",memo="略")
	private String 	oriTransactionID;
	@ParamDesc(path="BUSI_INFO.REVOKE_REASON",cons=ConsType.CT001,type="String",len="32",desc="冲正原因",memo="略")
	private String	revokeReason;
	@ParamDesc(path="BUSI_INFO.TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="统一流水",memo="略")
	private String transactionId; 
	@ParamDesc(path="BUSI_INFO.SETTLE_DATE",cons=ConsType.CT001,type="String",len="8",desc="交易账期",memo="略")
	private String 	settleDate;
	
	@ParamDesc(path="BUSI_INFO.ACTIVITY_CODE",cons=ConsType.CT001,type="String",len="8",desc="",memo="对账字段")
	private String 	activityCode;
	@ParamDesc(path="BUSI_INFO.SESSION_ID",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String 	sessionID;
	@ParamDesc(path="BUSI_INFO.TRANS_IDO",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String 	transIDO;
	@ParamDesc(path="BUSI_INFO.TRANS_IDO_TIME",cons=ConsType.CT001,type="String",len="14",desc="",memo="对账字段")
	private String 	transIDOTime;
	@ParamDesc(path="BUSI_INFO.TRANS_IDH",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String  transIDH;
	@ParamDesc(path="BUSI_INFO.TRANS_IDH_TIME",cons=ConsType.CT001,type="String",len="14",desc="",memo="对账字段")
	private String 	transIDHTime;
	@ParamDesc(path="BUSI_INFO.MSG_SENDER",cons=ConsType.CT001,type="String",len="4",desc="",memo="对账字段")
	private String 	msgSender;
	@ParamDesc(path="BUSI_INFO.MSG_RECEIVER",cons=ConsType.CT001,type="String",len="4",desc="",memo="对账字段")
	private String 	msgReceiver;
	@ParamDesc(path="BUSI_INFO.BIP_CODE",cons=ConsType.CT001,type="String",len="32",desc="业务代码"
			,memo="网站签约缴费：BIP1A160；短信签约缴费：BIP1A161；电话签约缴费：BIP1A162；预付费自动缴费：BIP1A163")	
	private String bipCode ;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setOriReqSys(arg0.getStr(getPathByProperName("oriReqSys")));
		setOriActionDate(arg0.getStr(getPathByProperName("oriActionDate")));
		setOriTransactionID(arg0.getStr(getPathByProperName("oriTransactionID")));
		setRevokeReason(arg0.getStr(getPathByProperName("revokeReason")));
		setTransactionId(arg0.getStr(getPathByProperName("transactionId")));
		setBipCode(arg0.getStr(getPathByProperName("bipCode")));
		setSettleDate(arg0.getStr(getPathByProperName("settleDate")));
		setActivityCode(arg0.getStr(getPathByProperName("activityCode")));
		setSessionID(arg0.getStr(getPathByProperName("sessionID")));
		setTransIDO(arg0.getStr(getPathByProperName("transIDO")));
		setTransIDOTime(arg0.getStr(getPathByProperName("transIDOTime")));
		setTransIDH(arg0.getStr(getPathByProperName("transIDH")));
		setTransIDHTime(arg0.getStr(getPathByProperName("transIDHTime")));
		setMsgSender(arg0.getStr(getPathByProperName("msgSender")));
		setMsgReceiver(arg0.getStr(getPathByProperName("msgReceiver")));
		if(StringUtils.isEmptyOrNull(getPathByProperName("opCode"))){
			opCode="8003";
		}
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getOriReqSys() {
		return oriReqSys;
	}

	public void setOriReqSys(String oriReqSys) {
		this.oriReqSys = oriReqSys;
	}

	public String getOriActionDate() {
		return oriActionDate;
	}

	public void setOriActionDate(String oriActionDate) {
		this.oriActionDate = oriActionDate;
	}

	public String getOriTransactionID() {
		return oriTransactionID;
	}

	public void setOriTransactionID(String oriTransactionID) {
		this.oriTransactionID = oriTransactionID;
	}

	public String getRevokeReason() {
		return revokeReason;
	}

	public void setRevokeReason(String revokeReason) {
		this.revokeReason = revokeReason;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getSettleDate() {
		return settleDate;
	}

	public void setSettleDate(String settleDate) {
		this.settleDate = settleDate;
	}

	public String getActivityCode() {
		return activityCode;
	}

	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}

	public String getSessionID() {
		return sessionID;
	}

	public void setSessionID(String sessionID) {
		this.sessionID = sessionID;
	}

	public String getTransIDO() {
		return transIDO;
	}

	public void setTransIDO(String transIDO) {
		this.transIDO = transIDO;
	}

	public String getTransIDOTime() {
		return transIDOTime;
	}

	public void setTransIDOTime(String transIDOTime) {
		this.transIDOTime = transIDOTime;
	}

	public String getTransIDH() {
		return transIDH;
	}

	public void setTransIDH(String transIDH) {
		this.transIDH = transIDH;
	}

	public String getTransIDHTime() {
		return transIDHTime;
	}

	public void setTransIDHTime(String transIDHTime) {
		this.transIDHTime = transIDHTime;
	}

	public String getMsgSender() {
		return msgSender;
	}

	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}

	public String getMsgReceiver() {
		return msgReceiver;
	}

	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}

	public String getBipCode() {
		return bipCode;
	}

	public void setBipCode(String bipCode) {
		this.bipCode = bipCode;
	}
}
