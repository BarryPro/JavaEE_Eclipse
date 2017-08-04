package com.sitech.acctmgr.atom.domains.detail;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")
public class TargetPhoneEntity implements Serializable{

	@JSONField(name = "TARGET_PHONE")
	@ParamDesc(path="TARGET_PHONE",cons= ConsType.CT001,type="String",len="40",desc="对端号码",memo="略")
	private String targetPhone;
	
	@JSONField(name = "QUERY_TYPE")
	@ParamDesc(path="QUERY_TYPE",cons= ConsType.CT001,type="String",len="10",desc="验证类型",memo="通话类型：7001")
	private String queryType;
	
	public String getTargetPhone() {
		return targetPhone;
	}

	public void setTargetPhone(String targetPhone) {
		this.targetPhone = targetPhone;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	@Override
	public String toString() {
		return "TargetPhoneEntity{" +
				"targetPhone='" + targetPhone + '\'' +
				", queryType='" + queryType + '\'' +
				'}';
	}


}
