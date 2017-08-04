package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class FeiDouQryEntity {
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
		
	@JSONField(name="CHARGE_SUM")
	@ParamDesc(path="CHARGE_SUM",cons=ConsType.QUES,type="long",len="14",desc="充值金额",memo="略")	
	protected long chargeSum;
	
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.QUES,type="String",len="20",desc="操作时间",memo="略")	
	protected String opTime;

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getChargeSum() {
		return chargeSum;
	}

	public void setChargeSum(long chargeSum) {
		this.chargeSum = chargeSum;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
	
}
