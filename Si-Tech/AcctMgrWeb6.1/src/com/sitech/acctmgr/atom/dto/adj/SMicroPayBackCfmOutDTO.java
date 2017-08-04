package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SMicroPayBackCfmOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4835090278021272233L;


	@JSONField(name="IN_TRANS_ID")
	@ParamDesc(path="IN_TRANS_ID",cons=ConsType.CT001,type="String",len="40",desc="交易流水",memo="略")
	private String outTransId;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	

	@Override
	public MBean encode(){
		MBean result=super.encode();
		result.setRoot(getPathByProperName("outTransId"), outTransId);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		return result;
	}
	
	

	public String getOutTransId() {
		return outTransId;
	}


	public void setOutTransId(String outTransId) {
		this.outTransId = outTransId;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}



}
