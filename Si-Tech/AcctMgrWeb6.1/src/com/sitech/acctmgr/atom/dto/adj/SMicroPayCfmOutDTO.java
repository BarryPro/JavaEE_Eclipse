package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
* @Description: 手机钱包支付扣费 出参DTO
* @Date :2016年10月24日
* @Company: SI-TECH
* @author : liuyc_billing
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class SMicroPayCfmOutDTO extends CommonOutDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7608559614955652697L;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	@JSONField(name="TRANS_ID")
	@ParamDesc(path="TRANS_ID",cons=ConsType.CT001,type="String",len="100",desc="交易流水",memo="略")
	private String transId;
	

	@Override
	public MBean encode(){
		MBean result=super.encode();
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("transId"), transId);
		return result;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public String getTransId() {
		return transId;
	}


	public void setTransId(String transId) {
		this.transId = transId;
	}




}
