package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：取消标准神州行用户余额有效期限制
 * @author liuyc_billing
 * version:1.0
 * 2016/11/14
 */

public interface IEasyOwnCancelExpire {

	/**
	 * 名称:取消标准神州行用户余额有效期限制确认服务
	 * @param inParam
	 * @return
	 */
	OutDTO cfm(InDTO inParam);
}
