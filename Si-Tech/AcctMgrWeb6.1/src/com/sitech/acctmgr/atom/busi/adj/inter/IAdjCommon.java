package com.sitech.acctmgr.atom.busi.adj.inter;

import java.util.Map;

/**
*
* <p>Title: 补收业务接口  </p>
* <p>Description: 补收业务接口，实现补收相关业务  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public interface IAdjCommon {
	
	/** 
	* 名称：补收函数  包含账目项拆分
	* @param 
	* @return 
	*/
	Map<String, Object> doAdjOweFinal(Map<String, Object> inParam);

	public Map<String, Object> MicroAdj(Map<String, Object> inParam);
	
	/**
	 * 名称：小额支付核心负补收
	 * @param inParam
	 * @return
	 * @author liuyc_billing
	 */
	public Map<String, Object> MinusAdj(Map<String, Object> inParam);

}
