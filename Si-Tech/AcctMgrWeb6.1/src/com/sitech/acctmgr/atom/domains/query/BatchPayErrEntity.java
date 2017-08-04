package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class BatchPayErrEntity {
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, type = "String", len = "40", desc = "手机号码", memo = "")
	protected String phoneNo;
	
	@JSONField(name="REGION_NAME")
	@ParamDesc(path = "REGION_NAME", cons = ConsType.CT001, type = "String", len = "18", desc = "地市", memo = "略")
	protected String regionName;
	
	@JSONField(name="ACTIVITY_NAME")
	@ParamDesc(path="ACTIVITY_NAME",cons=ConsType.CT001,type="String",len="100",desc="活动名称",memo="略")
	private String activityName = "";
	
	@JSONField(name="PAY_MONEY")
	@ParamDesc(path="PAY_MONEY",cons=ConsType.CT001,type="long",len="20",desc="应充值金额",memo="略")
	private long payMoney = 0;
	
	@JSONField(name="LOSE_DATE")
	@ParamDesc(path="LOSE_DATE",cons=ConsType.CT001,type="String",len="8",desc="充值失效日期",memo="略")
	private String loseDate = "";

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the activityName
	 */
	public String getActivityName() {
		return activityName;
	}

	/**
	 * @param activityName the activityName to set
	 */
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	/**
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the loseDate
	 */
	public String getLoseDate() {
		return loseDate;
	}

	/**
	 * @param loseDate the loseDate to set
	 */
	public void setLoseDate(String loseDate) {
		this.loseDate = loseDate;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
}
