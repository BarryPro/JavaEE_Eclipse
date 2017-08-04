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
public class S8297MobilePaySignQueryOutDTO extends CommonOutDTO {
	
	@ParamDesc(path="BUSI_TYPE",cons=ConsType.CT001,type="String",len="40",desc="业务类型",memo="1001:手机支付自动缴话费签约关系. 1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系")
	private String busiType;
	
	@ParamDesc(path="BUSI_NAME",cons=ConsType.CT001,type="String",len="40",desc="业务名称",memo="略")
	private String busiName;
	
	@ParamDesc(path="SIGN_TIME",cons=ConsType.CT001,type="String",len="14",desc="签约时间",memo="略")
	private String signTime;
	
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="14",desc="自动缴费金额",memo="单位：分")
	private long payMoney;
	
	@ParamDesc(path="PAY_DAY",cons=ConsType.CT001,type="String",len="14",desc="自动缴费时间，天",memo="")
	private String payDay;
	
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="操作时间",memo="")
	private String opTime;
	
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="开通工号",memo="")
	private String loginNo;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("busiType"), busiType);
		result.setRoot(getPathByProperName("busiName"), busiName);
		result.setRoot(getPathByProperName("signTime"), signTime);
		result.setRoot(getPathByProperName("payMoney"), payMoney);
		result.setRoot(getPathByProperName("payDay"), payDay);
		result.setRoot(getPathByProperName("loginNo"), loginNo);
		result.setRoot(getPathByProperName("opTime"), opTime);
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


	public String getPayDay() {
		return payDay;
	}


	public void setPayDay(String payDay) {
		this.payDay = payDay;
	}


	public String getOpTime() {
		return opTime;
	}


	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}


	public String getLoginNo() {
		return loginNo;
	}


	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	
}
