package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SRoamPayCfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1328105593867663990L;

	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.PAY_FLAG",cons=ConsType.CT001,type="String",len="4",desc="支付标识",memo="略")
	protected String payFlag;
	@ParamDesc(path="BUSI_INFO.PRO_ID",cons=ConsType.QUES,type="String",len="1",desc="",memo="略")
	protected String proId ;
	@ParamDesc(path="BUSI_INFO.PRO_INST_ID",cons=ConsType.CT001,type="String",len="5",desc="",memo="略")
	protected String proInstId;
	@ParamDesc(path="BUSI_INFO.EFF_DATE",cons=ConsType.CT001,type="String",len="60",desc="日期",memo="略")
	protected String effDate;
	@ParamDesc(path="BUSI_INFO.EXPIRE_DATE",cons=ConsType.CT001,type="String",len="15",desc="日期",memo="略")
	protected String expireDate;
	@ParamDesc(path="BUSI_INFO.OP_TIME",cons=ConsType.CT001,type="String",len="1024",desc="操作时间",memo="略")
	protected String opTime;
	@ParamDesc(path="BUSI_INFO.OFFER_ID",cons=ConsType.CT001,type="String",len="1024",desc="资费ID",memo="略")
	protected String offerId;
	@ParamDesc(path="BUSI_INFO.FLAG",cons=ConsType.CT001,type="String",len="100",desc="标识",memo="略")
	protected String flag;
	@ParamDesc(path="BUSI_INFO.FEE",cons=ConsType.CT001,type="Long",len="100",desc="费用",memo="略")
	protected long fee;
	@ParamDesc(path="BUSI_INFO.FEE_CYCLE",cons=ConsType.CT001,type="String",len="100",desc="",memo="略")
	protected String feeCycle;
 
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPayFlag(arg0.getStr(getPathByProperName("payFlag")));
		setProId(arg0.getStr(getPathByProperName("proId")));
		setProInstId(arg0.getStr(getPathByProperName("proInstId")));
		setExpireDate(arg0.getStr(getPathByProperName("expireDate")));
		setEffDate(arg0.getStr(getPathByProperName("effDate")));
		setFlag(arg0.getStr(getPathByProperName("flag")));
		setFee(Long.parseLong(arg0.getObject(getPathByProperName("fee")).toString()));
		setFeeCycle(arg0.getStr(getPathByProperName("feeCycle")));
		setOpTime(arg0.getStr(getPathByProperName("opTime")));
		setOfferId(arg0.getStr(getPathByProperName("offerId")));

	}
	
	
	
	

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getPayFlag() {
		return payFlag;
	}

	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}

	public String getProId() {
		return proId;
	}

	public void setProId(String proId) {
		this.proId = proId;
	}

	public String getProInstId() {
		return proInstId;
	}

	public void setProInstId(String proInstId) {
		this.proInstId = proInstId;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getOfferId() {
		return offerId;
	}

	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public long getFee() {
		return fee;
	}

	public void setFee(long fee) {
		this.fee = fee;
	}

	public String getFeeCycle() {
		return feeCycle;
	}

	public void setFeeCycle(String feeCycle) {
		this.feeCycle = feeCycle;
	}
	
}
