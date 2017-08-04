package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
*
* <p>Title: 手工充值卡缴费  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author qiaolin
* @version 1.0
*/
public interface I8025 {
	
	/** 
	* 名称：充值卡缴费<br/>
	* 功能：完成充值卡缴费校验、充值功能<br/>
	* @param PAY_PATH		：缴费渠道
	* @param PHONE_NO	  	：可空，服务号码
	* @return 
	*/
	OutDTO cfm(final InDTO inParam);
	
	/**
	* 名称：充值卡缴费
	* 功能：归接口调用，发送智能网平台指令做充值卡缴费（调用应用集成平台接口）
	* @param 
	* @return 
	*/
	OutDTO cardCfm(final InDTO inParam);
	
	/**
	* 名称：10086充值卡充值
	* 功能：充值卡充值--10086平台调用 融合1380138000
	* @param PHONE_NO			:发起充值手机号码
	* @param PHONENO_PAY		:被充值手机号码
	* @param CARD_PASSWORD		:充值卡密码
	* @param FOREIGN_SN			:充值流水号
	* @param CHANNEL_ID			:10086热线充值渠道标记
	* @return 
	*/
	OutDTO cardCfmBy10086(final InDTO inParam);
	
	/***
	* 名称：充值卡缴费记录查询
	* 功能：查询BOSS侧充值卡缴费到账记录，bal_paycard_recd
	* @return 
	 * */
	OutDTO query(final InDTO inParam);
}
