package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 缴费出参 paySn对象  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PosPayOutEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4649900199872534705L; 
	/*
	 ID_NO, CONTRACT_NO, PHONE_NO, PAY_FEE, VOUCHER_ID, INSTALNUM, STATUS, OP_TIME 
	 */
	@JSONField(name = "PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="long",len="18",desc="流水",memo="略")
	private long paySn;
	
	@JSONField(name = "ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="18",desc="用户标识",memo="略")
	private long idNo;
	
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo;
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="手机号码",memo="略")
	private String phoneNo;
	
	@JSONField(name = "REFERENCE_NO")
	@ParamDesc(path="REFERENCE_NO",cons=ConsType.CT001,type="String",len="40",desc="系统参考号",memo="略")
	private String referenceNo;
	
	@JSONField(name = "PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="缴费金额",memo="略")
	private long payFee;	
	
	@JSONField(name = "VOUCHER_ID")
	@ParamDesc(path="VOUCHER_ID",cons=ConsType.CT001,type="String",len="30",desc="",memo="略")
	private String voucherId;
	
	@JSONField(name = "INSTALNUM")
	@ParamDesc(path="INSTALNUM",cons=ConsType.CT001,type="String",len="2",desc="缴费期数",memo="略")
	private String instalNum;
	
	@JSONField(name = "STATUS")
	@ParamDesc(path="STATUS",cons=ConsType.CT001,type="String",len="2",desc="",memo="略")
	private String status;
	
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="操作时间",memo="略")
	private String opTime;
	
	/**
	 * 
	 */
	public PosPayOutEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public String getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
	}

	public long getIdNo() {
		return idNo;
	}
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}
	public long getContractNo() {
		return contractNo;
	}
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public long getPayFee() {
		return payFee;
	}
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}
	public String getVoucherId() {
		return voucherId;
	}
	public void setVoucherId(String voucherId) {
		this.voucherId = voucherId;
	}
	public String getInstalNum() {
		return instalNum;
	}
	public void setInstalNum(String instalNum) {
		this.instalNum = instalNum;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOpTime() {
		return opTime;
	}
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}
	

}
