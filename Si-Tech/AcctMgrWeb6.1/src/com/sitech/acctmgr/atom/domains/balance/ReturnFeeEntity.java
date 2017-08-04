package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class ReturnFeeEntity {

	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, type = "String", len = "20", desc = "账本类型", memo = "略")
	private String payType = "";

	@JSONField(name = "FOREIGN_SN")
	@ParamDesc(path = "FOREIGN_SN", cons = ConsType.CT001, type = "String", len = "20", desc = "外部流水", memo = "略")
	private String foreginSn;

	@JSONField(name = "ALL_FEE")
	@ParamDesc(path = "ALL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "返费总金额", memo = "略")
	private long allFee = 0;

	@JSONField(name = "BEGIN_TIME")
	@ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "开始时间", memo = "略")
	private String beginTime = "";

	@JSONField(name = "END_TIME")
	@ParamDesc(path = "END_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "结束时间", memo = "略")
	private String endTime = "";

	@JSONField(name = "RETURN_NUM")
	@ParamDesc(path = "RETURN_NUM", cons = ConsType.CT001, type = "long", len = "10", desc = "返费月数", memo = "略")
	private long returnNum = 0;

	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType
	 *            the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

	/**
	 * @return the allFee
	 */
	public long getAllFee() {
		return allFee;
	}

	/**
	 * @param allFee
	 *            the allFee to set
	 */
	public void setAllFee(long allFee) {
		this.allFee = allFee;
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime
	 *            the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime
	 *            the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the returnNum
	 */
	public long getReturnNum() {
		return returnNum;
	}

	/**
	 * @param returnNum
	 *            the returnNum to set
	 */
	public void setReturnNum(long returnNum) {
		this.returnNum = returnNum;
	}

	public String getForeginSn() {
		return foreginSn;
	}

	public void setForeginSn(String foreginSn) {
		this.foreginSn = foreginSn;
	}

}
