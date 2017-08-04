package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @Description: 手机钱包查询 出参DTO
 * @Date :2016年10月21日
 * @Company: SI-TECH
 * @author : liuyc_billing
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p>
 */
public class SMicroPayInitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4585496109396052753L;
	
	
	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="100",desc="可用余额",memo="略")
	private long leftPrepayFee;
	@JSONField(name="OWE_FLAG")
	@ParamDesc(path="OWE_FLAG",cons=ConsType.CT001,type="long",len="20",desc="欠费标识",memo="1：欠费，0：不欠费")
	private long OweFlag;
	@JSONField(name="OPEN_TIME")
	@ParamDesc(path="OPEN_TIME",cons=ConsType.CT001,type="String",len="100",desc="开户时间",memo="略")
	private String vOpenTime;
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="100",desc="上月点对点语音消费",memo="略")
	private long vPayFee;
	
	
	@Override
	public MBean encode(){
		MBean result=super.encode();
		result.setRoot(getPathByProperName("leftPrepayFee"), leftPrepayFee);
		result.setRoot(getPathByProperName("OweFlag"), OweFlag);
		result.setRoot(getPathByProperName("vOpenTime"), vOpenTime);
		result.setRoot(getPathByProperName("vPayFee"), vPayFee);
		return result;
	}
	

	public long getLeftPrepayFee() {
		return leftPrepayFee;
	}

	public void setLeftPrepayFee(long leftPrepayFee) {
		this.leftPrepayFee = leftPrepayFee;
	}

	public long getOweFlag() {
		return OweFlag;
	}

	public void setOweFlag(long oweFlag) {
		OweFlag = oweFlag;
	}

	public String getvOpenTime() {
		return vOpenTime;
	}

	public void setvOpenTime(String vOpenTime) {
		this.vOpenTime = vOpenTime;
	}

	public long getvPayFee() {
		return vPayFee;
	}

	public void setvPayFee(long vPayFee) {
		this.vPayFee = vPayFee;
	}


}
