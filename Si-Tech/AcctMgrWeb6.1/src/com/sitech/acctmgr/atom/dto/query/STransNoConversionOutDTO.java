package com.sitech.acctmgr.atom.dto.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class STransNoConversionOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -648420605631333210L;
	
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.STAR,type="String",len="40",desc="电话号",memo="略")
	protected	String phoneNo;
	@JSONField(name="NO_TYPE")
	@ParamDesc(path="NO_TYPE",cons=ConsType.STAR,type="String",len="40",desc="号码类型",memo="略")
	protected	String noType;
	@JSONField(name="NO_TYPE_ID")
	@ParamDesc(path="NO_TYPE_ID",cons=ConsType.STAR,type="String",len="40",desc="号码类型ID",memo="略")
	protected	String noTypeId;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("noType"), noType);
		result.setRoot(getPathByProperName("noTypeId"), noTypeId);
		return result;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getNoType() {
		return noType;
	}

	public void setNoType(String noType) {
		this.noType = noType;
	}

	public String getNoTypeId() {
		return noTypeId;
	}

	public void setNoTypeId(String noTypeId) {
		this.noTypeId = noTypeId;
	}
	
	
}
