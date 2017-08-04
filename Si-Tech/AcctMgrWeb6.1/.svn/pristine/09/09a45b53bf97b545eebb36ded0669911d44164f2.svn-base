package com.sitech.acctmgr.atom.domains.detail;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")
public class PTOPEntity implements Serializable{

	@JSONField(name = "TARGET_PHONE")
	@ParamDesc(path="TARGET_PHONE",cons= ConsType.CT001,type="String",len="40",desc="对端号码",memo="略")
	private String targetPhone;
	
	@JSONField(name = "PHONE_SIGN")
	@ParamDesc(path = "PHONE_SIGN", cons = ConsType.CT001, type = "String", len = "2", desc = "通信标识", memo = "00表示通话验证不成功、01:表示被叫、02:表示主叫不超过30秒、03:表示主叫并超过30秒;10表示短信验证不成功；11表示收短信；12表示发短信")
	private String phoneSign;

	public String getTargetPhone() {
		return targetPhone;
	}

	public void setTargetPhone(String targetPhone) {
		this.targetPhone = targetPhone;
	}

	public String getPhoneSign() {
		return phoneSign;
	}

	public void setPhoneSign(String phoneSign) {
		this.phoneSign = phoneSign;
	}

	@Override
	public String toString(){
		return "targetPhone:" + targetPhone + ",phoneSign:" + phoneSign;
	}
	
	
}
