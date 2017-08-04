package com.sitech.acctmgr.atom.domains.fee;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class OutFeeData {

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "当前余额", memo = "单位：分")
	private long remainFee;

	@JSONField(name = "COMMON_REMAIN_FEE")
	@ParamDesc(path = "COMMON_REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "普通预存款余额", memo = "单位：分")
	private long commonRemainFee;

	@JSONField(name = "SPECIAL_REMAIN_FEE")
	@ParamDesc(path = "SPECIAL_REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "专款预存款余额", memo = "单位：分")
	private long specialRemainFee;

	@JSONField(name = "PREPAY_FEE")
	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "普通预存款", memo = "单位：分")
	private long prepayFee;

	@JSONField(name = "SEPCIAL_FEE")
	@ParamDesc(path = "SEPCIAL_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "专款预存款", memo = "单位：分")
	private long sepcialFee;

	@JSONField(name = "COMMON_PREPAY_FEE")
	@ParamDesc(path = "COMMON_PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "普通预存款", memo = "单位：分")
	private long commonPrepayFee;

	@JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "当前欠费", memo = "单位：分")
	private long oweFee;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "未出帐话费", memo = "单位：分")
	private long unbillFee;

	@JSONField(name = "SUM_SHOULDPAY")
	@ParamDesc(path = "SUM_SHOULDPAY", cons = ConsType.CT001, type = "long", len = "18", desc = "合计应收", memo = "单位：分")
	private long sumShouldPay;

	@JSONField(name = "DELAY_FEE")
	@ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "18", desc = "滞纳金", memo = "单位：分")
	private long delayFee;

	public long getCommonPrepayFee() {
		return commonPrepayFee;
	}

	public void setCommonPrepayFee(long commonPrepayFee) {
		this.commonPrepayFee = commonPrepayFee;
	}

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public long getCommonRemainFee() {
		return commonRemainFee;
	}

	public void setCommonRemainFee(long commonRemainFee) {
		this.commonRemainFee = commonRemainFee;
	}

	public long getSpecialRemainFee() {
		return specialRemainFee;
	}

	public void setSpecialRemainFee(long specialRemainFee) {
		this.specialRemainFee = specialRemainFee;
	}

	public long getPrepayFee() {
		return prepayFee;
	}

	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	public long getSepcialFee() {
		return sepcialFee;
	}

	public void setSepcialFee(long sepcialFee) {
		this.sepcialFee = sepcialFee;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	public long getUnbillFee() {
		return unbillFee;
	}

	public void setUnbillFee(long unbillFee) {
		this.unbillFee = unbillFee;
	}

	public long getSumShouldPay() {
		return sumShouldPay;
	}

	public void setSumShouldPay(long sumShouldPay) {
		this.sumShouldPay = sumShouldPay;
	}

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	@Override
	public String toString() {
		return "OutFeeData [remainFee=" + remainFee + ", commonRemainFee=" + commonRemainFee + ", specialRemainFee=" + specialRemainFee
				+ ", prepayFee=" + prepayFee + ", sepcialFee=" + sepcialFee + ", commonPrepayFee=" + commonPrepayFee + ", oweFee=" + oweFee
				+ ", unbillFee=" + unbillFee + ", sumShouldPay=" + sumShouldPay + ", delayFee=" + delayFee + "]";
	}

}
