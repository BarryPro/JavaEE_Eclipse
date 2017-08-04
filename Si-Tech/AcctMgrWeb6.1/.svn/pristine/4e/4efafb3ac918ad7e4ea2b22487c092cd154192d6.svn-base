package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SQry1500OutDTO extends CommonOutDTO{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "当前预存", memo = "单位：分")
    private long prepayFee = 0;
    @ParamDesc(path = "CUR_BALANCE", cons = ConsType.CT001, type = "long", len = "20", desc = "余额", memo = "单位：分")
    private long curBalance = 0;
    @ParamDesc(path = "UNBILL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "未出帐话费", memo = "单位：分")
    private long unBillFee = 0;
    @ParamDesc(path = "SPECIAL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "专款", memo = "单位：分")
    private long specialFee = 0;
    @ParamDesc(path = "COMMON_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "普通款", memo = "单位：分")
    private long commonFee = 0;
    @ParamDesc(path = "OWE_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "往月欠费", memo = "单位：分")
    private long oweFee = 0;
    @ParamDesc(path = "EXPIRE_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "有效期", memo = "略")
    private String expireTime = "";
    
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("curBalance"), curBalance);
		result.setRoot(getPathByProperName("unBillFee"), unBillFee);
		result.setRoot(getPathByProperName("specialFee"), specialFee);
		result.setRoot(getPathByProperName("commonFee"), commonFee);
		result.setRoot(getPathByProperName("oweFee"), oweFee);
		result.setRoot(getPathByProperName("expireTime"), expireTime);
		
		return result;
	}

	/**
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}

	/**
	 * @param prepayFee the prepayFee to set
	 */
	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	/**
	 * @return the curBalance
	 */
	public long getCurBalance() {
		return curBalance;
	}

	/**
	 * @param curBalance the curBalance to set
	 */
	public void setCurBalance(long curBalance) {
		this.curBalance = curBalance;
	}

	/**
	 * @return the unBillFee
	 */
	public long getUnBillFee() {
		return unBillFee;
	}

	/**
	 * @param unBillFee the unBillFee to set
	 */
	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	/**
	 * @return the specialFee
	 */
	public long getSpecialFee() {
		return specialFee;
	}

	/**
	 * @param specialFee the specialFee to set
	 */
	public void setSpecialFee(long specialFee) {
		this.specialFee = specialFee;
	}

	/**
	 * @return the commonFee
	 */
	public long getCommonFee() {
		return commonFee;
	}

	/**
	 * @param commonFee the commonFee to set
	 */
	public void setCommonFee(long commonFee) {
		this.commonFee = commonFee;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the expireTime
	 */
	public String getExpireTime() {
		return expireTime;
	}

	/**
	 * @param expireTime the expireTime to set
	 */
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}
}
