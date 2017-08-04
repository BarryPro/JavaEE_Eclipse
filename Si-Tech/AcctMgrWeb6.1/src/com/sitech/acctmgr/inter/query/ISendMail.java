package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @description:账户余额邮箱发送
 * @author liuhl
 *
 */
public interface ISendMail {

	/**
	 * @Description:调用原子服务余额查询（com_sitech_acctmgr_inter_feeqry_IFeeQuerySvc_balanceQuery）和邮箱发送两个服务
	 * @param:inParam
	 * @return
	 */
	public OutDTO sendBill(InDTO inParam);
}
