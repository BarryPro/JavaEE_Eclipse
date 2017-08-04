package com.sitech.acctmgr.atom.domains.pay;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
* @Title:   []
* @Description:  集团自由划拨实体类
* @Date : 2016年8月15日上午10:57:12
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class GroupChargeEntity implements Serializable {

	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="缴费流水",memo="略")
	private long 	paySn;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="string",len="8",desc=" 操作日期",memo="略")
	private String  totalDate;
	
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="string",len="4",desc="操作代码",memo="略")
	private String 	opCode;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="14",desc="被划拨号码",memo="")
	private String 	phoneNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="string",len="18",desc="被划拨账户",memo="略")
	private long 	contractNo;
	
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="string",len="20",desc="导入工号",memo="")
	private String 	loginNo;
	
	@JSONField(name="IMPORT_TIME")
	@ParamDesc(path="IMPORT_TIME",cons=ConsType.CT001,type="string",len="20",desc="导入时间",memo="略")
	private String 	import_time;
	
	@JSONField(name="GROUP_CONTRACT_NO")
	@ParamDesc(path="GROUP_CONTRACT_NO",cons=ConsType.CT001,type="long",len="14",desc="集团账户",memo="略")
	private long 	groupContractNo;

	@JSONField(name="GROUP_PRODUCT_NAME")
	@ParamDesc(path="GROUP_PRODUCT_NAME",cons=ConsType.CT001,type="string",len="120",desc="集团账户",memo="略")
	private String 	groupProductName;

	@JSONField(name="FILE_NAME")
	@ParamDesc(path="FILE_NAME",cons=ConsType.CT001,type="string",len="500",desc="文件名",memo="略")
	private String 	fileName;
	
	@JSONField(name="IMPORT_BATCH_SN")
	@ParamDesc(path="IMPORT_BATCH_SN",cons=ConsType.CT001,type="long",len="14",desc="导入批次流水",memo="略")
	private long 	importBatchSn;
	
	@JSONField(name="PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="划拨金额",memo="略")
	private long 	payMoney;

	@JSONField(name="TRANS_LOGIN")
	@ParamDesc(path="TRANS_LOGIN",cons=ConsType.CT001,type="string",len="20",desc="划拨工号",memo="")
	private String 	transLogin;
	
	@JSONField(name="TRASN_TIME")
	@ParamDesc(path="TRASN_TIME",cons=ConsType.CT001,type="string",len="20",desc="划拨时间",memo="略")
	private String 	trasnTime;

	@JSONField(name="TRANS_BATCH_SN")
	@ParamDesc(path="TRANS_BATCH_SN",cons=ConsType.CT001,type="long",len="14",desc="划拨批次流水",memo="略")
	private long 	trans_batch_sn;
	
	@JSONField(name="ERR_TIME")
	@ParamDesc(path="ERR_TIME",cons=ConsType.CT001,type="string",len="20",desc="错误时间",memo="略")
	private String 	errTime;
	
	@JSONField(name="ERR_MSG")
	@ParamDesc(path="ERR_MSG",cons=ConsType.CT001,type="string",len="10",desc="地市编码",memo="全省：2200")
	private String 	errMsg;

	@JSONField(name="RUN_NAME")
	@ParamDesc(path="RUN_NAME",cons=ConsType.CT001,type="string",len="10",desc="用户状态",memo="略")
	private String 	runName;

	@JSONField(name="PAY_TIME")
	@ParamDesc(path="PAY_TIME",cons=ConsType.CT001,type="string",len="14",desc="充值时间",memo="略")
	private String 	payTime;
 
	@Override
	public String toString() {
		return "GroupChargeEntity [paySn=" + paySn + ", totalDate=" + totalDate + ", opCode=" + opCode + ", phoneNo="
				+ phoneNo + ", contractNo=" + contractNo + ", loginNo=" + loginNo + ", import_time=" + import_time
				+ ", groupContractNo=" + groupContractNo + ", groupProductName=" + groupProductName + ", fileName="
				+ fileName + ", importBatchSn=" + importBatchSn + ", payMoney=" + payMoney + ", transLogin=" + transLogin
				+ ", trasnTime=" + trasnTime + ", trans_batch_sn=" + trans_batch_sn + ", errTime=" + errTime + ", errMsg="
				+ errMsg + ", runName="+ runName +", payTime=" + payTime + "]";
	}

	public Map<String, Object> toMap(){
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public String getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getImport_time() {
		return import_time;
	}

	public void setImport_time(String import_time) {
		this.import_time = import_time;
	}

	public long getGroupContractNo() {
		return groupContractNo;
	}

	public void setGroupContractNo(long groupContractNo) {
		this.groupContractNo = groupContractNo;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getImportBatchSn() {
		return importBatchSn;
	}

	public void setImportBatchSn(long importBatchSn) {
		this.importBatchSn = importBatchSn;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public String getTransLogin() {
		return transLogin;
	}

	public void setTransLogin(String transLogin) {
		this.transLogin = transLogin;
	}

	public String getTrasnTime() {
		return trasnTime;
	}

	public void setTrasnTime(String trasnTime) {
		this.trasnTime = trasnTime;
	}

	public long getTrans_batch_sn() {
		return trans_batch_sn;
	}

	public void setTrans_batch_sn(long trans_batch_sn) {
		this.trans_batch_sn = trans_batch_sn;
	}

	public String getErrTime() {
		return errTime;
	}

	public void setErrTime(String errTime) {
		this.errTime = errTime;
	}

	public String getErrMsg() {
		return errMsg;
	}

	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	public String getRunName() {
		return runName;
	}

	public void setRunName(String runName) {
		this.runName = runName;
	}


	public String getPayTime() {
		return payTime;
	}

	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public String getGroupProductName() {
		return groupProductName;
	}

	public void setGroupProductName(String groupProductName) {
		this.groupProductName = groupProductName;
	}
}
