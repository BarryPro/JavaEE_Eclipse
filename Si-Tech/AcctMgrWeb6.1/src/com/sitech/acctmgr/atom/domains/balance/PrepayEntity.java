package com.sitech.acctmgr.atom.domains.balance;

import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class PrepayEntity {
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
