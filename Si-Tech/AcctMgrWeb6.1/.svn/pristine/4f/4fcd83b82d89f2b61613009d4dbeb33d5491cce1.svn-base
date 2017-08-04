package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 校验账户信息  </p>
 * <p>Description: 目前只有校验用户状态和余额的接口  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface ICheckCon {

	/**
	 * 功能：校验用户状态 和 余额,目前提供给一级BOSS调用，手机游戏用到，用户购买游戏前校验余额，校验通过后一级BOSS调用产品订购服务
	 * @param PHONE_NO
	 * @param CHECK_FEE
	 * @return	ROOT.RETURN_CODE  : 0 通过 否则 不通过  </br>
	 * @author qiaolin
	 * */
	OutDTO checkRemainFee(final InDTO inParam);
	
	
}
