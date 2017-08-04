package com.sitech.acctmgr.atom.entity.inter;

import java.util.Map;

/**
 *
 * <p>Title: 滞纳金  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IDelay {

	/**
	 * 取滞纳金率
	 * @param  CONTRACT_NO: 账户ID
	 * @param  NET_FLAG: 在离网标识  可空  0：在网  1：离网
	 * @return DELAY_RATE：滞纳金比率<br/>
	 * 	       DELAY_BEGIN：滞纳金开始时间
	 */
	public abstract Map<String, Object> getDelayRate(Map<String, Object> inParam);

	/**
	 * 名称：取滞纳金
	 * @param BILL_BEGIN
	 * @param OWE_FEE
	 * @param DELAY_BEGIN
	 * @param DELAY_RATE
	 * @param BILL_CYCLE
	 * @param TOTAL_DATE
	 * @return DELAY_FEE
	 */
	public abstract long getDelayFee(Map<String, Object> inParam);

}
