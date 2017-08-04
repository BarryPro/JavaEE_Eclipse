package com.sitech.acctmgr.inter.billAccount;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:GPRS流量提醒开通关闭接口  </p>
* <p>Description: GPRS流量提醒开通关闭接口 </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IGprsRemind {	
	
	/**
	 * 开通和关闭gprs流量定时提醒短信功能，对应老系统s6335Cfm
	 */
	OutDTO gprsRemind(final InDTO inParam);
	
	/**
	 * 开通和关闭gprs流量定时提醒短信功能，对应老系统s6336Cfm
	 */
	OutDTO gprsRemindNew(final InDTO inParam);
	
	/**
	 * 开通和关闭国际漫游流量提醒功能，对应老系统s6337Cfm
	 */
	OutDTO gprsInterRemind(final InDTO inParam);
	
	/**
	* 开通和关闭语音、短信、彩信短信功能，对应老系统s6338Cfm
	*/
	OutDTO integratedRemind(final InDTO inParam);
	
	/**
	* 开通和关闭定时提醒功能，对应老系统s6339Cfm
	*/
	OutDTO gprsTimeRemind(final InDTO inParam);
	
	/**
	 * 开通关闭亲情网提醒，对应老系统sFamOffOn
	 */
	OutDTO familyOffOn(final InDTO inParam);
	
}
