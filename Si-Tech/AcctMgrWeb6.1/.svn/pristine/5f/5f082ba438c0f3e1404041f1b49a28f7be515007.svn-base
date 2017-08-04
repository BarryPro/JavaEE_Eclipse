package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBalanceQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账户号码", memo = "略")
	private long contractNo = 0;

	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "预存", memo = "单位:分")
	private long prepayFee = 0;

	@ParamDesc(path = "REMAIN_BALANCE", cons = ConsType.CT001, type = "long", len = "20", desc = "余额", memo = "单位:分")
	private long curBalance = 0;

	@ParamDesc(path = "UNBILL_FEE_ALL", cons = ConsType.CT001, type = "long", len = "20", desc = "未出帐话费", memo = "单位:分")
	private long unBillFeeAll = 0;

	@ParamDesc(path = "OWE_FEE_ALL", cons = ConsType.CT001, type = "long", len = "20", desc = "总欠费", memo = "单位:分")
	private long oweFeeAll = 0;

	@ParamDesc(path = "BACK_DEPOSIT", cons = ConsType.CT001, type = "String", len = "20", desc = "可退押金", memo = "单位:分")
	private long backDeposit = 0;

	@ParamDesc(path = "BRAND_NAME", cons = ConsType.CT001, type = "String", len = "20", desc = "品牌名称", memo = "略")
	private String brandName = null;

	@ParamDesc(path = "OPEN_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "开户时间", memo = "略")
	private String openTime = "";

	@ParamDesc(path = "RUN_TIME", cons = ConsType.CT001, type = "String", len = "20", desc = "状态变更时间", memo = "略")
	private String runTime = "";

	@ParamDesc(path = "REGION_CODE", cons = ConsType.CT001, type = "String", len = "30", desc = "地市代码", memo = "略")
	private String regionCode = "";

	@ParamDesc(path = "RUN_CODE", cons = ConsType.CT001, type = "String", len = "30", desc = "运行状态", memo = "略")
	private String runCode = "";

	@ParamDesc(path = "RUN_NAME", cons = ConsType.CT001, type = "String", len = "30", desc = "状态名称", memo = "略")
	private String runName = "";

	@ParamDesc(path = "COMMON_REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "30", desc = "普通预存款余额", memo = "单位:分")
	private long commonRemainFee;

	@ParamDesc(path = "SPECIAL_REMAIN_FEE", cons = ConsType.CT001, type = "long", len = "30", desc = "转款预存款余额", memo = "单位:分")
	private long specialRemainFee;

	@ParamDesc(path = "DELAY_FEE", cons = ConsType.CT001, type = "long", len = "30", desc = "滞纳金", memo = "单位:分")
	private long delayFee;
	
	//专题需求所加
	@ParamDesc(path = "PREPAY_ALL", cons = ConsType.CT001, type = "long", len = "30", desc = "预存总额", memo = "单位:分")
	private long prepayAll;
	@ParamDesc(path = "EFF_PREPAY_ALL", cons = ConsType.CT001, type = "long", len = "30", desc = "已生效预存总额", memo = "单位:分")
	private long effPrepayAll;
	@ParamDesc(path = "WILL_PREPAY_ALL", cons = ConsType.CT001, type = "long", len = "30", desc = "预约生效预存总额", memo = "单位:分")
	private long willPrepayAll;
	@ParamDesc(path = "EXP_PREPAY_ALL", cons = ConsType.CT001, type = "long", len = "30", desc = "冻结预存总额", memo = "单位:分")
	private long expPrepayAll;
	@ParamDesc(path = "AVAILABLE_ALL", cons = ConsType.CT001, type = "long", len = "30", desc = "当月可用预存", memo = "单位:分")
	private long availableAll;
	@ParamDesc(path = "AVAILABLE_COMMON", cons = ConsType.CT001, type = "long", len = "30", desc = "当月可用普通预存", memo = "单位:分")
	private long availableCommon;
	@ParamDesc(path = "AVAILABLE_SPECIAL", cons = ConsType.CT001, type = "long", len = "30", desc = "当月可用专项预存", memo = "单位:分")
	private long availableSpecial;

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("prepayFee"), prepayFee);
		result.setRoot(getPathByProperName("commonRemainFee"), commonRemainFee);
		result.setRoot(getPathByProperName("specialRemainFee"), specialRemainFee);
		result.setRoot(getPathByProperName("curBalance"), curBalance);
		result.setRoot(getPathByProperName("unBillFeeAll"), unBillFeeAll);
		result.setRoot(getPathByProperName("oweFeeAll"), oweFeeAll);
		result.setRoot(getPathByProperName("backDeposit"), backDeposit);
		result.setRoot(getPathByProperName("brandName"), brandName);
		result.setRoot(getPathByProperName("openTime"), openTime);
		result.setRoot(getPathByProperName("runTime"), runTime);
		result.setRoot(getPathByProperName("regionCode"), regionCode);
		result.setRoot(getPathByProperName("runCode"), runCode);
		result.setRoot(getPathByProperName("runName"), runName);
		result.setRoot(getPathByProperName("delayFee"), delayFee);

		result.setRoot(getPathByProperName("prepayAll"), prepayAll);
		result.setRoot(getPathByProperName("effPrepayAll"), effPrepayAll);
		result.setRoot(getPathByProperName("willPrepayAll"), willPrepayAll);
		result.setRoot(getPathByProperName("expPrepayAll"), expPrepayAll);
		result.setRoot(getPathByProperName("availableAll"), availableAll);
		result.setRoot(getPathByProperName("availableCommon"), availableCommon);
		result.setRoot(getPathByProperName("availableSpecial"), availableSpecial);
		log.info(result.toString());
		return result;
	}

	public long getDelayFee() {
		return delayFee;
	}

	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	/**
	 * @return the runCode
	 */
	public String getRunCode() {
		return runCode;
	}

	/**
	 * @param runCode
	 *            the runCode to set
	 */
	public void setRunCode(String runCode) {
		this.runCode = runCode;
	}

	/**
	 * @return the runName
	 */
	public String getRunName() {
		return runName;
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

	/**
	 * @param runName
	 *            the runName to set
	 */
	public void setRunName(String runName) {
		this.runName = runName;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo
	 *            the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}

	/**
	 * @param prepayFee
	 *            the prepayFee to set
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
	 * @param curBalance
	 *            the curBalance to set
	 */
	public void setCurBalance(long curBalance) {
		this.curBalance = curBalance;
	}

	/**
	 * @return the unBillFeeAll
	 */
	public long getUnBillFeeAll() {
		return unBillFeeAll;
	}

	/**
	 * @param unBillFeeAll
	 *            the unBillFeeAll to set
	 */
	public void setUnBillFeeAll(long unBillFeeAll) {
		this.unBillFeeAll = unBillFeeAll;
	}

	/**
	 * @return the oweFeeAll
	 */
	public long getOweFeeAll() {
		return oweFeeAll;
	}

	/**
	 * @param oweFeeAll
	 *            the oweFeeAll to set
	 */
	public void setOweFeeAll(long oweFeeAll) {
		this.oweFeeAll = oweFeeAll;
	}

	/**
	 * @return the backDeposit
	 */
	public long getBackDeposit() {
		return backDeposit;
	}

	/**
	 * @param backDeposit
	 *            the backDeposit to set
	 */
	public void setBackDeposit(long backDeposit) {
		this.backDeposit = backDeposit;
	}

	/**
	 * @return the brandName
	 */
	public String getBrandName() {
		return brandName;
	}

	/**
	 * @param brandName
	 *            the brandName to set
	 */
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getRunTime() {
		return runTime;
	}

	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the prepayAll
	 */
	public long getPrepayAll() {
		return prepayAll;
	}

	/**
	 * @param prepayAll the prepayAll to set
	 */
	public void setPrepayAll(long prepayAll) {
		this.prepayAll = prepayAll;
	}

	/**
	 * @return the effPrepayAll
	 */
	public long getEffPrepayAll() {
		return effPrepayAll;
	}

	/**
	 * @param effPrepayAll the effPrepayAll to set
	 */
	public void setEffPrepayAll(long effPrepayAll) {
		this.effPrepayAll = effPrepayAll;
	}

	/**
	 * @return the willPrepayAll
	 */
	public long getWillPrepayAll() {
		return willPrepayAll;
	}

	/**
	 * @param willPrepayAll the willPrepayAll to set
	 */
	public void setWillPrepayAll(long willPrepayAll) {
		this.willPrepayAll = willPrepayAll;
	}

	/**
	 * @return the expPrepayAll
	 */
	public long getExpPrepayAll() {
		return expPrepayAll;
	}

	/**
	 * @param expPrepayAll the expPrepayAll to set
	 */
	public void setExpPrepayAll(long expPrepayAll) {
		this.expPrepayAll = expPrepayAll;
	}

	/**
	 * @return the availableAll
	 */
	public long getAvailableAll() {
		return availableAll;
	}

	/**
	 * @param availableAll the availableAll to set
	 */
	public void setAvailableAll(long availableAll) {
		this.availableAll = availableAll;
	}

	/**
	 * @return the availableCommon
	 */
	public long getAvailableCommon() {
		return availableCommon;
	}

	/**
	 * @param availableCommon the availableCommon to set
	 */
	public void setAvailableCommon(long availableCommon) {
		this.availableCommon = availableCommon;
	}

	/**
	 * @return the availableSpecial
	 */
	public long getAvailableSpecial() {
		return availableSpecial;
	}

	/**
	 * @param availableSpecial the availableSpecial to set
	 */
	public void setAvailableSpecial(long availableSpecial) {
		this.availableSpecial = availableSpecial;
	}

}
