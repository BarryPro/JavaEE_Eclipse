package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @Title:  总对总缴费落地 [8000]
 * @Description: 总对总缴费落地服务
 * @Date : 2015年2月28日上午10:59:07
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
public interface IGrpUnifyPay {

	 

	/**
	* 名称：总对总缴费落地 确认服务
	* @param 
	* @return 
	* @throws Exception
	* @author LIJXD
	 */
	OutDTO cfm(InDTO inParam);
}
