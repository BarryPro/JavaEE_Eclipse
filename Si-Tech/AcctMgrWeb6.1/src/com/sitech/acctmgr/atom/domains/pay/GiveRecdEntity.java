package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

/**
 *
* @Title:   []
* @Description: 批量赠费导入总记录实体类
* @Date : 2015年12月29日下午3:20:01
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class GiveRecdEntity implements Serializable {


	public GiveRecdEntity() {
	}

	@JSONField(name="REGION_ID")
	@ParamDesc(path="REGION_ID",cons=ConsType.CT001,type="long",len="4",desc="地市编码",memo="略")
	private long regionId;
	
	@JSONField(name="BATCH_SN")
	@ParamDesc(path="BATCH_SN",cons=ConsType.CT001,type="string",len="32",desc="操作流水",memo="略")
	private String batchSn;

	@JSONField(name="ACT_NAME")
	@ParamDesc(path="ACT_NAME",cons=ConsType.QUES,type="string",len="200",desc="操作名称",memo="略")
	private String actName;


	@JSONField(name="SEND_DATE")
	@ParamDesc(path="SEND_DATE",cons=ConsType.QUES,type="string",len="8",desc="赠费时间",memo="略")
	private String sendDate;

	@JSONField(name="SMS_FLAG")
	@ParamDesc(path="SMS_FLAG",cons=ConsType.QUES,type="string",len="2",desc="短信标识",memo="0发送1不发送")
	private String smsFlag;

	@JSONField(name="SEND_MONTH")
	@ParamDesc(path="SEND_MONTH",cons=ConsType.QUES,type="string",len="8",desc="绑定月数",memo="略")
	private String sendMonth;

	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.QUES,type="string",len="18",desc="操作时间",memo="略")
	private String opTime;

	@JSONField(name="YEAR_MONTH")
	@ParamDesc(path="YEAR_MONTH",cons=ConsType.QUES,type="string",len="8",desc="操作年月",memo="略")
	private String yearMonth;

	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.QUES,type="string",len="4",desc="操作代码",memo="略")
	private String opCode;

	@JSONField(name="OP_NOTE")
	@ParamDesc(path="OP_NOTE",cons=ConsType.QUES,type="string",len="18",desc="操作备注",memo="略")
	private String opNote;

	@JSONField(name="FILE_NAME")
	@ParamDesc(path="FILE_NAME",cons=ConsType.QUES,type="string",len="50",desc="文件名",memo="略")
	private String fileName;

	@JSONField(name="AUDIT_TIME")
	@ParamDesc(path="AUDIT_TIME",cons=ConsType.QUES,type="string",len="18",desc="审核时间",memo="略")
	private String auditTime;

	@JSONField(name="AUDIT_LOGIN")
	@ParamDesc(path="AUDIT_LOGIN",cons=ConsType.QUES,type="string",len="10",desc="审核工号",memo="略")
	private String auditLogin;

	@JSONField(name="AUDIT_INFO")
	@ParamDesc(path="AUDIT_INFO",cons=ConsType.QUES,type="string",len="18",desc="审核备注",memo="略")
	private String auditInfo;

	@JSONField(name="AUDIT_FLAG")
	@ParamDesc(path="AUDIT_FLAG",cons=ConsType.QUES,type="string",len="18",desc="审核状态",memo="略")
	private String auditFlag;

	@JSONField(name="AUDIT_NAME")
	@ParamDesc(path="AUDIT_NAME",cons=ConsType.QUES,type="string",len="18",desc="审核状态名称",memo="略")
	private String auditName;

	@JSONField(name="TOTAL_NUM")
	@ParamDesc(path="TOTAL_NUM",cons=ConsType.QUES,type="string",len="18",desc="总数量",memo="略")
	private String totalNum;

	@JSONField(name="INVALID_NUM")
	@ParamDesc(path="INVALID_NUM",cons=ConsType.QUES,type="string",len="18",desc="成功数量",memo="略")
	private String invalidNum;

	@JSONField(name="TOTAL_FEE")
	@ParamDesc(path="TOTAL_FEE",cons=ConsType.QUES,type="string",len="18",desc="总费用",memo="略")
	private String totalFee;

	@JSONField(name="INVALID_FEE")
	@ParamDesc(path="INVALID_FEE",cons=ConsType.QUES,type="string",len="18",desc="成功费用",memo="略")
	private String invalidFee;


	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.QUES,type="string",len="18",desc="成功费用",memo="略")
	private String loginNo;
	
	@JSONField(name="USER_PHONE")
	@ParamDesc(path="USER_PHONE",cons=ConsType.QUES,type="string",len="18",desc="联系人电话",memo="略")
	private String userPhone;

	public long getRegionId() {
		return regionId;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public void setRegionId(long regionId) {
		this.regionId = regionId;
	}

	public String getBatchSn() {
		return batchSn;
	}

	public void setBatchSn(String batchSn) {
		this.batchSn = batchSn;
	}

	public String getActName() {
		return actName;
	}

	public void setActName(String actName) {
		this.actName = actName;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

	public String getSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String getSendMonth() {
		return sendMonth;
	}

	public void setSendMonth(String sendMonth) {
		this.sendMonth = sendMonth;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}

	public String getAuditLogin() {
		return auditLogin;
	}

	public void setAuditLogin(String auditLogin) {
		this.auditLogin = auditLogin;
	}

	public String getAuditInfo() {
		return auditInfo;
	}

	public void setAuditInfo(String auditInfo) {
		this.auditInfo = auditInfo;
	}

	public String getAuditFlag() {
		return auditFlag;
	}

	public void setAuditFlag(String auditFlag) {
		this.auditFlag = auditFlag;
	}

	public String getAuditName() {
		return auditName;
	}

	public void setAuditName(String auditName) {
		this.auditName = auditName;
	}

	public String getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(String totalNum) {
		this.totalNum = totalNum;
	}

	public String getInvalidNum() {
		return invalidNum;
	}

	public void setInvalidNum(String invalidNum) {
		this.invalidNum = invalidNum;
	}

	public String getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}

	public String getInvalidFee() {
		return invalidFee;
	}

	public void setInvalidFee(String invalidFee) {
		this.invalidFee = invalidFee;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	@Override
	public String toString() {
		return "GiveRecdEntity{" +
				"regionId=" + regionId +
				", batchSn='" + batchSn + '\'' +
				", actName='" + actName + '\'' +
				", sendDate='" + sendDate + '\'' +
				", smsFlag='" + smsFlag + '\'' +
				", sendMonth='" + sendMonth + '\'' +
				", opTime='" + opTime + '\'' +
				", yearMonth='" + yearMonth + '\'' +
				", opCode='" + opCode + '\'' +
				", opNote='" + opNote + '\'' +
				", fileName='" + fileName + '\'' +
				", auditTime='" + auditTime + '\'' +
				", auditLogin='" + auditLogin + '\'' +
				", auditInfo='" + auditInfo + '\'' +
				", auditFlag='" + auditFlag + '\'' +
				", auditName='" + auditName + '\'' +
				", totalNum='" + totalNum + '\'' +
				", invalidNum='" + invalidNum + '\'' +
				", totalFee='" + totalFee + '\'' +
				", invalidFee='" + invalidFee + '\'' +
				", loginNo='" + loginNo + '\'' +
				'}';
	}
}
