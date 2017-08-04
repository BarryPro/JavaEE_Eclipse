package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8297BankOrZfbQueryDetailOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="BUSI_TYPE",cons=ConsType.CT001,type="String",len="40",desc="业务类型",memo="1001:手机支付自动缴话费签约关系. 1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系")
	private String busiType;
	
	@ParamDesc(path="BUSI_NAME",cons=ConsType.CT001,type="String",len="40",desc="业务名称",memo="略")
	private String busiName;
	
	@ParamDesc(path="FLAG",cons=ConsType.CT001,type="String",len="1",desc="是否签约联动优势银行卡易充值或者支付宝易充值 0：未签约 1：签约",memo="略")
	private String flag;
	
	@ParamDesc(path="SIGN_TIME",cons=ConsType.CT001,type="String",len="14",desc="签约时间",memo="略")
	private String signTime;
	
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="自动缴费金额",memo="单位：分")
	private long payMoney;
	
	@ParamDesc(path="THRESHOLD_VALUE",cons=ConsType.CT001,type="String",len="14",desc="阀值，缴费临界值",memo="略")
	private long thresholdValue;
	
	@ParamDesc(path="AUTO_FLAG",cons=ConsType.CT001,type="String",len="14",desc="自动缴费开关",memo="1:开  0：关")
	private String autoFlag;
	
	@ParamDesc(path="PAY_NUM",cons=ConsType.CT001,type="String",len="14",desc="支付商编号",memo="支付宝易充值输出")
	private String payNum;
	
	@ParamDesc(path="SIGN_NUM",cons=ConsType.CT001,type="String",len="14",desc="签约协议号",memo="支付宝易充值输出")
	private String signNum;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("busiType"), busiType);
		result.setRoot(getPathByProperName("busiName"), busiName);
		result.setRoot(getPathByProperName("flag"), flag);
		result.setRoot(getPathByProperName("signTime"), signTime);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("thresholdValue"), thresholdValue);
		result.setRoot(getPathByProperName("autoFlag"), autoFlag);
		result.setRoot(getPathByProperName("payNum"), payNum);
		result.setRoot(getPathByProperName("signNum"), signNum);
		
		return result;
	}


	public String getBusiType() {
		return busiType;
	}


	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}


	public String getBusiName() {
		return busiName;
	}


	public void setBusiName(String busiName) {
		this.busiName = busiName;
	}


	public String getFlag() {
		return flag;
	}


	public void setFlag(String flag) {
		this.flag = flag;
	}


	public String getSignTime() {
		return signTime;
	}


	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}


	public long getPayMoney() {
		return payMoney;
	}


	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}


	public long getThresholdValue() {
		return thresholdValue;
	}


	public void setThresholdValue(long thresholdValue) {
		this.thresholdValue = thresholdValue;
	}


	public String getAutoFlag() {
		return autoFlag;
	}


	public void setAutoFlag(String autoFlag) {
		this.autoFlag = autoFlag;
	}


	public String getPayNum() {
		return payNum;
	}


	public void setPayNum(String payNum) {
		this.payNum = payNum;
	}


	public String getSignNum() {
		return signNum;
	}


	public void setSignNum(String signNum) {
		this.signNum = signNum;
	}

}
