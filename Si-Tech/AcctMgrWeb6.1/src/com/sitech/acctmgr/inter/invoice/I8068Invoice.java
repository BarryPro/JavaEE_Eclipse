package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：空中充值代理商用户缴费打印收据
 * 
 * @author liuhl_bj
 *
 */
public interface I8068Invoice {

	/**
	 * 名称：收据打印
	 * 
	 * @param inParam
	 * @return
	 */
	public OutDTO print(InDTO inParam);

	/**
	 * 上一笔缴费信息查询
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);
}
