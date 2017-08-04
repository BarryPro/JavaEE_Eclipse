package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 银行卡签约客户主动交费  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface I8069 {

	/**
	* 名称：银行卡签约客户主动交费
	* @param PHONENO_SIGN		     ： 签约手机号码
	* @param PHONENO_SIGN_PASSWORD: 签约手机号密码
	* @param PHONENO_PAY		  : 缴费手机号码
	* @param PAY_MONEY            ： 缴费金额
	* @return 
	*/
	OutDTO cfm(final InDTO inParam);
	
	OutDTO alipayCfm(final InDTO inParam);
}
