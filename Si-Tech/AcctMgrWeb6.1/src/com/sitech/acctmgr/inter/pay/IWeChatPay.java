package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 缴费微信支付接口  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IWeChatPay {

	/**
	* 名称：微信支付订单创建 对应 sCreateOrder
	* @param 
	* @return 
	* @throws 
	*/
	OutDTO sCreateOrder(InDTO inParam);
	
	/**
	* 名称：微信缴费发起交费请求 对应 sOrderQry
	* @param 
	* @return 
	* @throws 
	*/
	OutDTO sOrderPay(InDTO inParam);
	
}
